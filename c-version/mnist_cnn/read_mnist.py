import numpy as np
import struct
import matplotlib.pyplot as plt

filename = 'train-images.idx3-ubyte'
binfile = open(filename, 'rb')
buf = binfile.read()

index = 0
magic, numImages, numRows, numColumns = struct.unpack_from('>IIII', buf, index)
index += struct.calcsize('>IIII')

#im = struct.unpack_from('>784B', buf, index)
for i in range(12):
    index += struct.calcsize('>784B')

im = struct.unpack_from('>784B', buf, index)
im = np.array(im)
im = im.reshape(28,28)

np.savetxt('3_number.txt',im,fmt='%d')

fig = plt.figure()
plotwindow = fig.add_subplot(111)
plt.imshow(im, cmap='gray')
plt.show()
#print(im)
#print(im.shape)
