from PIL import Image
from pandas import read_csv
from pandas import DataFrame
import numpy as np
import glob
import re

TRAIN_DATA_DIR = '../Data/valid/'
NUM_SETS = 6
NUM_IMAGES = 970
IMGS_PER_SET = NUM_IMAGES / 6
VALID_SET = 1 # indicate working on validation set

images = glob.glob(TRAIN_DATA_DIR+'*')
image_idxs = [int(re.match(r'.*/(\d*)\.jpg$', a, re.M | re.I).group(1)) - 1 for a in images]
labels = read_csv('../Data/train.csv').values[:, 1]


for i in xrange(NUM_SETS):
    print "Processing set: " + `i`

    file_name = 'val_set%d.bin'%(i+1)
    f = open(file_name, 'wb')

    iters = IMGS_PER_SET
    if i == NUM_SETS - 1:
        # last set
        iters = 7000 - (NUM_SETS - 1) * IMGS_PER_SET

    for j in xrange(iters):
        idx = i * IMGS_PER_SET + j
        im_name = images[idx]
        im_label_idx = image_idxs[idx]

        label = [labels[im_label_idx]-1]

        im = Image.open(im_name)
        im = (np.array(im))

        r = im[:,:,0].flatten()
        g = im[:,:,1].flatten()
        b = im[:,:,2].flatten()

        byte_format = np.array(list(label) + list(r) + list(g) + list(b),np.uint8)
        f.write(byte_format)
    f.close()
