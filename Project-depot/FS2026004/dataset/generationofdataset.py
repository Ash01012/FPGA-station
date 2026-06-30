import numpy as np
def generate_noisy_xor_dataset():

    np.random.seed(42)

    n_samples = 10000
    n_features = 12

    # Generate 12 random binary features
    X = np.random.randint(0, 2, size=(n_samples, n_features))

    # XOR only first two bits
    y = X[:,0] ^ X[:,1]

    # Add 40% label noise
    noise_mask = np.random.rand(n_samples) < 0.40
    y[noise_mask] ^= 1

    # 5000 train / 5000 test
    X_train = X[:5000]
    y_train = y[:5000]

    X_test = X[5000:]
    y_test = y[5000:]

    # Save training features
    with open("x_train.mem", "w") as f:
        for row in X_train:
            f.write("".join(map(str,row)) + "\n")

    # Save training labels
    with open("y_train.mem", "w") as f:
        for label in y_train:
            f.write(str(label) + "\n")

    # Save test features
    with open("x_test.mem", "w") as f:
        for row in X_test:
            f.write("".join(map(str,row)) + "\n")

    # Save test labels
    with open("y_test.mem", "w") as f:
        for label in y_test:
            f.write(str(label) + "\n")

    print("Generated Files:")
    print("x_train.mem  (5000 samples)")
    print("y_train.mem  (5000 labels)")
    print("x_test.mem   (5000 samples)")
    print("y_test.mem   (5000 labels)")

generate_noisy_xor_dataset()