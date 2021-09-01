# Digit recognition
It's a fun project to try convolutional neural networks and test,  And test understanding for the computer vision theorise, and testing connections between tflite and flutter.

## Features
- Finger drawing on canvas
- Convert canvas to image to recognize
- Ai model that detect hand writting digit

## Tech

- [Flutter](https://flutter.dev/) - Google's UI toolkit for building beautiful, natively compiled applications
- [TensorFlow](https://www.tensorflow.org/) - training and inference of deep neural networks
- [Keras](https://keras.io/) - a Python interface for artificial neural networks

## Model training & testing

Starting by defining the model, layers and activation function (you can play arround with this layers and values).

```python
model = Sequential([
    Conv2D(16, (3, 3), activation=tf.nn.relu, input_shape=(28, 28, 1)),
    MaxPool2D(pool_size=(2, 2)),
    Conv2D(32, (3, 3), activation=tf.nn.relu),
    MaxPool2D(pool_size=(2, 2)),
    Flatten(),
    Dense(units=128, activation=tf.nn.relu),
    Dense(units=128, activation=tf.nn.relu),
    Dense(units=10, activation=tf.nn.softmax),
])
```
Defining the model optimizer , loss and the accuracy matrix
```python
model.compile(optimizer=tf.keras.optimizers.RMSprop(),
              loss=tf.keras.losses.sparse_categorical_crossentropy,
              metrics=[tf.keras.metrics.sparse_categorical_accuracy],)
model.fit(x_train, y_train, epochs=5)
```
Saving the model for later use and convert the model to tflite (it shrink the model size and to be able to use in mobile apps)
```python
model.save('digits_recognition.h5')
tf_model = tf.keras.models.load_model('digits_recognition.h5')
converter = tf.lite.TFLiteConverter.from_keras_model(tf_model)
new_tf_model = converter.convert()
open('digits_recognition.tflite','wb').write(new_tf_model)
```
## Use model in flutter app

first app the model location to flutter pubspec.yaml

```
flutter:
  uses-material-design: true
  assets:
    - assets/model/
```

Creating a class for the model to ease use it's methods

```dart
class DigitRecognizerTFlite {
  Future<String?> loadModel() async {
    return Tflite.loadModel(
      model: 'assets/model/digits_recognition.tflite',
      labels: 'assets/model/digits_recognition.txt',
    );
  }

  Future<List<Predection>> predict(Uint8List image) async {
    List<Predection>? predect;
    final output = await Tflite.runModelOnBinary(
      binary: image,
      asynch: true,
    );
    predect = output?.map((element) => Predection.fromMap(element)).toList();
    return predect ?? [];
  }
}
```
