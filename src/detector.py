# detector.py
import mediapipe as mp
import cv2
import numpy as np

class FaceDetector:
    def __init__(self):
        # 최적화를 위해 min_detection_confidence 조절 가능
        self.mp_face_detection = mp.solutions.face_detection.FaceDetection(
            model_selection=0, min_detection_confidence=0.5)

    def detect(self, frame_pointer, height, width):
        # C++ Mat 데이터를 numpy로 변환
        frame = np.frombuffer(frame_pointer, dtype=np.uint8).reshape(height, width, 3)
        rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        results = self.mp_face_detection.process(rgb_frame)

        if results.detections:
            # 가장 먼저 잡힌 얼굴 하나 반환
            bbox = results.detections[0].location_data.relative_bounding_box
            cx = int((bbox.xmin + bbox.width / 2) * width)
            cy = int((bbox.ymin + bbox.height / 2) * height)
            return [True, cx, cy]
        
        return [False, 0, 0]