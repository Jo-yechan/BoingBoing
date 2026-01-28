#include <linux/module.h>
#include <linux/fs.h>
#include <linux/device.h>
#include <linux/cdev.h>
#include <linux/uaccess.h>
#include <linux/gpio.h>

#define DEVICE_NAME "led"
#define CLASS_NAME "led_class"
#define NUM_LEDS 1  // 하나의 LED로 가정 (필요 시 확장 가능)
#define LED_GPIO_PIN 21  // LED 연결된 GPIO 핀 번호 (예: GPIO 21, 필요 시 변경)

static dev_t dev_num;
static struct cdev led_cdev;
static struct class *led_class;

static int led_open(struct inode *inode, struct file *file) {
    printk(KERN_INFO "LED: Device opened\n");
    return 0;
}

static int led_release(struct inode *inode, struct file *file) {
    printk(KERN_INFO "LED: Device closed\n");
    return 0;
}

static int set_led_state(int state) {
    if (state != 0 && state != 1) {
        printk(KERN_ERR "LED: Invalid state %d (must be 0 or 1)\n", state);
        return -EINVAL;
    }

    gpio_set_value(LED_GPIO_PIN, state);
    printk(KERN_INFO "LED: Set to %s\n", state ? "ON" : "OFF");
    return 0;
}

static ssize_t led_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos) {
    char str[32];
    int state;
    int ret;

    if (count > sizeof(str) - 1) 
        return -EINVAL;

    if (copy_from_user(str, buf, count)) 
        return -EFAULT;
    
    str[count] = '\0';

    // "state" 형식 파싱 (0 또는 1)
    ret = sscanf(str, "%d", &state);
    
    if (ret != 1) {
        printk(KERN_ERR "LED: Invalid format. Expected: '0' or '1'\n");
        return -EINVAL;
    }

    // LED 제어
    ret = set_led_state(state);
    if (ret)
        return ret;

    return count;
}

static const struct file_operations fops = {
    .owner = THIS_MODULE,
    .open = led_open,
    .release = led_release,
    .write = led_write,
};

static int __init led_init(void) {
    int ret;
    struct device *dev;

    printk(KERN_INFO "LED: Initializing LED driver\n");

    // GPIO 요청
    ret = gpio_request(LED_GPIO_PIN, "led_gpio");
    if (ret) {
        printk(KERN_ERR "LED: Failed to request GPIO %d\n", LED_GPIO_PIN);
        return ret;
    }

    // GPIO 출력 모드로 설정
    ret = gpio_direction_output(LED_GPIO_PIN, 0);  // 초기 OFF
    if (ret) {
        printk(KERN_ERR "LED: Failed to set GPIO %d direction\n", LED_GPIO_PIN);
        gpio_free(LED_GPIO_PIN);
        return ret;
    }

    printk(KERN_INFO "LED: GPIO %d requested and set to output\n", LED_GPIO_PIN);

    // 디바이스 번호 할당
    ret = alloc_chrdev_region(&dev_num, 0, 1, DEVICE_NAME);
    if (ret < 0) {
        printk(KERN_ERR "LED: Failed to allocate device number\n");
        goto err_gpio;
    }

    // cdev 초기화
    cdev_init(&led_cdev, &fops);
    led_cdev.owner = THIS_MODULE;
    
    ret = cdev_add(&led_cdev, dev_num, 1);
    if (ret < 0) {
        printk(KERN_ERR "LED: Failed to add cdev\n");
        goto err_chrdev;
    }

    // 클래스 생성
    led_class = class_create(THIS_MODULE, CLASS_NAME);
    if (IS_ERR(led_class)) {
        ret = PTR_ERR(led_class);
        printk(KERN_ERR "LED: Failed to create class\n");
        goto err_cdev;
    }

    // 디바이스 파일 생성 (/dev/led)
    dev = device_create(led_class, NULL, dev_num, NULL, DEVICE_NAME);
    if (IS_ERR(dev)) {
        ret = PTR_ERR(dev);
        printk(KERN_ERR "LED: Failed to create device\n");
        goto err_class;
    }

    printk(KERN_INFO "LED: Loaded successfully (major %d)\n", MAJOR(dev_num));
    printk(KERN_INFO "LED: Use 'echo 1 > /dev/led' to turn ON, 'echo 0 > /dev/led' to turn OFF\n");
    printk(KERN_INFO "LED: Connected to GPIO %d\n", LED_GPIO_PIN);
    return 0;

err_class:
    class_destroy(led_class);
err_cdev:
    cdev_del(&led_cdev);
err_chrdev:
    unregister_chrdev_region(dev_num, 1);
err_gpio:
    gpio_free(LED_GPIO_PIN);
    return ret;
}

static void __exit led_exit(void) {
    printk(KERN_INFO "LED: Exiting\n");

    gpio_set_value(LED_GPIO_PIN, 0);  // 종료 시 OFF
    gpio_free(LED_GPIO_PIN);
    
    device_destroy(led_class, dev_num);
    class_destroy(led_class);
    cdev_del(&led_cdev);
    unregister_chrdev_region(dev_num, 1);

    printk(KERN_INFO "LED: Unloaded\n");
}

module_init(led_init);
module_exit(led_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Your Name");
MODULE_DESCRIPTION("Simple LED Driver for Raspberry Pi using GPIO");
MODULE_VERSION("1.0");
