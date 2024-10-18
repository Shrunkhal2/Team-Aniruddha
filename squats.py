import cv2
import mediapipe as mp
import numpy as np
import tkinter as tk
from tkinter import messagebox
from tkinter import ttk  # Import for progress bar

mp_pose = mp.solutions.pose
pose = mp_pose.Pose()

mp_drawing = mp.solutions.drawing_utils

counter = 0
stage = None
target_count = None

def calculate_angle(a, b, c):
    a = np.array(a)
    b = np.array(b)
    c = np.array(c)

    radians = np.arctan2(c[1] - b[1], c[0] - b[0]) - np.arctan2(a[1] - b[1], a[0] - b[0])
    angle = np.abs(radians * 180.0 / np.pi)

    if angle > 180.0:
        angle = 360.0 - angle

    return angle

def start_squat_counter(target, progress_bar):
    global counter, stage, target_count
    target_count = int(target)

    cap = cv2.VideoCapture(0)

    cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)

    counter = 0  # Reset counter for each new session

    while cap.isOpened():
        ret, frame = cap.read()

        if not ret:
            break

        rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

        results = pose.process(rgb_frame)

        if results.pose_landmarks:
            mp_drawing.draw_landmarks(frame, results.pose_landmarks, mp_pose.POSE_CONNECTIONS)

            landmarks = results.pose_landmarks.landmark

            hip = [landmarks[mp_pose.PoseLandmark.LEFT_HIP.value].x,
                   landmarks[mp_pose.PoseLandmark.LEFT_HIP.value].y]
            knee = [landmarks[mp_pose.PoseLandmark.LEFT_KNEE.value].x,
                    landmarks[mp_pose.PoseLandmark.LEFT_KNEE.value].y]
            ankle = [landmarks[mp_pose.PoseLandmark.LEFT_ANKLE.value].x,
                     landmarks[mp_pose.PoseLandmark.LEFT_ANKLE.value].y]

            knee_angle = calculate_angle(hip, knee, ankle)

            if knee_angle < 100:  
                stage = 'down'
            if knee_angle > 160 and stage == 'down':  
                stage = 'up'
                counter += 1

                # Update progress bar
                progress = int((counter / target_count) * 100)
                progress_bar['value'] = progress
                progress_bar.update()

            # Display squat count on the frame
            cv2.putText(frame, f'Squats: {counter}', (50, 100),
                        cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2, cv2.LINE_AA)

        cv2.imshow('Squat Counter', frame)

        if cv2.waitKey(10) & 0xFF == ord('q'):
            break

        if counter >= target_count:
            messagebox.showinfo("Target Reached", f"Congratulations! You've completed {target_count} squats.")
            break

    cap.release()
    cv2.destroyAllWindows()

def start_gui():
    root = tk.Tk()
    root.title("Squat Counter Setup")

    # Label for squat target
    label = tk.Label(root, text="Set Your Squat Target:")
    label.pack(pady=10)

    target_entry = tk.Entry(root)
    target_entry.pack(pady=10)

    # Progress bar setup
    progress_bar = ttk.Progressbar(root, orient="horizontal", length=300, mode="determinate")
    progress_bar.pack(pady=20)

    # Button to start the squat counter
    start_button = tk.Button(root, text="Start", command=lambda: start_squat_counter(target_entry.get(), progress_bar))
    start_button.pack(pady=20)

    root.mainloop()

start_gui()
