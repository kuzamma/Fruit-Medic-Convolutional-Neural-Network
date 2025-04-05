
The app is designed for the purpose of quickly identifying rubber tree clones and comparing them against different plant classes in real-time. It supports both camera capture and image selection from the gallery to classify plant images. The model provides confidence scores for predictions.

---

## Features

- **Camera Capture**: Capture real-time images using the device's camera and predict if the image belongs to the rubber tree clone class.
- **Gallery Selection**: Choose images from the gallery and classify them based on the model's recognition.
- **Confidence Score**: The application generates a confidence score between 85% and 98% for predictions.
- **Error Handling**: If the image is not recognized as a rubber tree clone, the app returns a "Not Rubber Tree Clone" label.
- **Flutter-based**: Built using Flutter, making it cross-platform (works on both iOS and Android).
- **TensorFlow Lite Integration**: The app uses TensorFlow Lite to run the pre-trained model on-device, enabling fast and efficient inference.

---



## Requirements

- Flutter (any stable version, preferably >=2.5.0)
- TensorFlow Lite (for running the ML model)
- Android/iOS device or simulator/emulator for testing

---

## Installation

### Clone this repository

```bash
Clone this repository
```

### Install dependencies

Make sure you have Flutter installed, then run the following command:

```bash
flutter pub get
```

### Run the app

For Android:

```bash
flutter run
```

For iOS (macOS only):

```bash
flutter run --ios
```

---

## How it Works

1. **Loading the Model**: The app loads the TensorFlow Lite model and label file from the assets folder to make predictions.
2. **Capturing or Selecting Image**: The app allows the user to either take a photo using the camera or select an image from the gallery.
3. **Model Prediction**: After an image is captured or selected, the app runs the image through the pre-trained model for classification.
4. **Displaying Results**: The result is shown with the predicted class label and the confidence score. If the image is not recognized as a rubber tree clone, it will display "Not Recognize"

---

## TensorFlow Lite Model

The app uses a pre-trained **TensorFlow Lite model** to classify images. The model is loaded into the app's memory when the app starts, and predictions are made locally on the device without requiring internet access.

Make sure that the model and labels are stored in the `assets` folder of the Flutter project. If you are using a different model, update the paths to the model and label files accordingly.




