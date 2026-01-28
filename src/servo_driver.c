#include <linux/module.h>
#include <linux/fs.h>
#include <linux/device.h>
#include <linux/cdev.h>
#include <linux/uaccess.h>
#include <linux/pwm.h>

#define DEVICE_NAME "servo"
#define CLASS_NAME "servo_class"
#define NUM_SERVOS 2

static dev_t dev_num;
static struct cdev servo_cdev;
static struct class *servo_class;
static struct pwm_device *pwm[NUM_SERVOS];

// SG-90 스펙: PWM 주기 20ms (50Hz), 펄스 폭 0.5ms(0도) ~ 2.5ms(180도)
#define PWM_PERIOD_NS 20000000  // 20ms
#define MIN_PULSE_NS  500000    // 0.5ms (0도)
#define MAX_PULSE_NS  2500000   // 2.5ms (180도)

static int servo_open(struct inode *inode, struct file *file) {
    printk(KERN_INFO "Servo: Device opened\n");
    return 0;
}

static int servo_release(struct inode *inode, struct file *file) {
    printk(KERN_INFO "Servo: Device closed\n");
    return 0;
}

static int set_servo_angle(int channel, int angle) {
    long duty_ns;
    int ret;

    if (channel < 0 || channel >= NUM_SERVOS) {
        printk(KERN_ERR "Servo: Invalid channel %d\n", channel);
        return -EINVAL;
    }

    if (angle < 0 || angle > 180) {
        printk(KERN_ERR "Servo: Invalid angle %d\n", angle);
        return -EINVAL;
    }

    // 각도 -> 펄스 폭 계산
    duty_ns = MIN_PULSE_NS + ((MAX_PULSE_NS - MIN_PULSE_NS) * angle / 180);

    // PWM 설정
    ret = pwm_config(pwm[channel], duty_ns, PWM_PERIOD_NS);
    if (ret) {
        printk(KERN_ERR "Servo: pwm_config failed for channel %d\n", channel);
        return ret;
    }

    ret = pwm_enable(pwm[channel]);
    if (ret) {
        printk(KERN_ERR "Servo: pwm_enable failed for channel %d\n", channel);
        return ret;
    }

    printk(KERN_INFO "Servo: Channel %d set to angle %d (duty %ld ns)\n", channel, angle, duty_ns);
    return 0;
}

static ssize_t servo_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos) {
    char str[32];
    int angle1, angle2;
    int ret;

    if (count > sizeof(str) - 1) 
        return -EINVAL;

    if (copy_from_user(str, buf, count)) 
        return -EFAULT;
    
    str[count] = '\0';

    // "angle1 angle2" 형식 파싱
    ret = sscanf(str, "%d %d", &angle1, &angle2);
    
    if (ret != 2) {
        printk(KERN_ERR "Servo: Invalid format. Expected: 'angle1 angle2'\n");
        return -EINVAL;
    }

    // 두 서보 제어
    ret = set_servo_angle(0, angle1);
    if (ret)
        return ret;

    ret = set_servo_angle(1, angle2);
    if (ret)
        return ret;

    return count;
}

static const struct file_operations fops = {
    .owner = THIS_MODULE,
    .open = servo_open,
    .release = servo_release,
    .write = servo_write,
};

static int __init servo_init(void) {
    int ret, i;
    struct device *dev;

    printk(KERN_INFO "Servo: Initializing dual servo driver\n");

    // 두 개의 PWM 디바이스 요청 - 채널 번호 직접 지정
    for (i = 0; i < NUM_SERVOS; i++) {
        // pwm_request(채널번호, 레이블)
        pwm[i] = pwm_request(i, i == 0 ? "servo0" : "servo1");
        if (IS_ERR(pwm[i])) {
            printk(KERN_ERR "Servo: PWM request failed for channel %d (err %ld)\n", 
                   i, PTR_ERR(pwm[i]));
            printk(KERN_INFO "Servo: Make sure PWM overlay is enabled in /boot/config.txt\n");
            printk(KERN_INFO "Servo: Add 'dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2'\n");
            ret = PTR_ERR(pwm[i]);
            goto err_pwm;
        }

        printk(KERN_INFO "Servo: PWM channel %d requested successfully\n", i);

        // PWM 초기 설정
        ret = pwm_config(pwm[i], 0, PWM_PERIOD_NS);
        if (ret) {
            printk(KERN_ERR "Servo: Initial pwm_config failed for channel %d\n", i);
            pwm_free(pwm[i]);
            goto err_pwm;
        }
    }

    // 디바이스 번호 할당
    ret = alloc_chrdev_region(&dev_num, 0, 1, DEVICE_NAME);
    if (ret < 0) {
        printk(KERN_ERR "Servo: Failed to allocate device number\n");
        goto err_pwm;
    }

    // cdev 초기화
    cdev_init(&servo_cdev, &fops);
    servo_cdev.owner = THIS_MODULE;
    
    ret = cdev_add(&servo_cdev, dev_num, 1);
    if (ret < 0) {
        printk(KERN_ERR "Servo: Failed to add cdev\n");
        goto err_chrdev;
    }

    // 클래스 생성
    servo_class = class_create(THIS_MODULE, CLASS_NAME);
    if (IS_ERR(servo_class)) {
        ret = PTR_ERR(servo_class);
        printk(KERN_ERR "Servo: Failed to create class\n");
        goto err_cdev;
    }

    // 디바이스 파일 생성 (/dev/servo)
    dev = device_create(servo_class, NULL, dev_num, NULL, DEVICE_NAME);
    if (IS_ERR(dev)) {
        ret = PTR_ERR(dev);
        printk(KERN_ERR "Servo: Failed to create device\n");
        goto err_class;
    }

    printk(KERN_INFO "Servo: Loaded successfully (major %d)\n", MAJOR(dev_num));
    printk(KERN_INFO "Servo: Use 'echo <angle1> <angle2> > /dev/servo' to control (0-180)\n");
    printk(KERN_INFO "Servo: GPIO18 (PWM channel 0) and GPIO19 (PWM channel 1)\n");
    return 0;

err_class:
    class_destroy(servo_class);
err_cdev:
    cdev_del(&servo_cdev);
err_chrdev:
    unregister_chrdev_region(dev_num, 1);
err_pwm:
    for (i = 0; i < NUM_SERVOS; i++) {
        if (!IS_ERR_OR_NULL(pwm[i])) {
            pwm_disable(pwm[i]);
            pwm_free(pwm[i]);
        }
    }
    return ret;
}

static void __exit servo_exit(void) {
    int i;
    
    printk(KERN_INFO "Servo: Exiting\n");

    for (i = 0; i < NUM_SERVOS; i++) {
        if (!IS_ERR_OR_NULL(pwm[i])) {
            pwm_disable(pwm[i]);
            pwm_free(pwm[i]);
        }
    }
    
    device_destroy(servo_class, dev_num);
    class_destroy(servo_class);
    cdev_del(&servo_cdev);
    unregister_chrdev_region(dev_num, 1);

    printk(KERN_INFO "Servo: Unloaded\n");
}

module_init(servo_init);
module_exit(servo_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Your Name");
MODULE_DESCRIPTION("Dual PWM Servo Driver for SG-90 on Raspberry Pi");
MODULE_VERSION("2.0");
