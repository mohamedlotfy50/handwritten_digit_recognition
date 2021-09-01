import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Flatten, Conv2D, MaxPool2D
from tensorflow.keras.datasets import mnist


(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train = x_train.reshape(60000, 28, 28, 1).astype("float32") / 255.0
x_test = x_test.reshape(10000, 28, 28, 1).astype("float32") / 255.0
y_train = y_train.astype("float32")
y_test = y_test.astype("float32")

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
model.compile(optimizer=tf.keras.optimizers.RMSprop(),
              loss=tf.keras.losses.sparse_categorical_crossentropy,
              metrics=[tf.keras.metrics.sparse_categorical_accuracy],)
model.fit(x_train, y_train, epochs=5)
loss, accuracy = model.evaluate(x_test, y_test)
print(accuracy)
print(loss)