from PIL import Image
import numpy as np
import glob
import re

TRAIN_DATA_DIR = '../../Data/Detection/tiles/'
NUM_SETS = 6
NUM_IMAGES = 30000
IMGS_PER_SET = NUM_IMAGES / 6
VALID_SET = 0 # indicate working on validation set

images = glob.glob(TRAIN_DATA_DIR+'*')

for i in xrange(NUM_SETS):
    print "Processing set: " + `i`

    file_name = 'set%d.bin'%(i+1)
    f = open(file_name, 'wb')

    iters = IMGS_PER_SET
    if i == NUM_SETS - 1:
        # last set
        iters = NUM_IMAGES- (NUM_SETS - 1) * IMGS_PER_SET

    for j in xrange(iters):
        idx = i * IMGS_PER_SET + j
        im_name = images[idx]

        # f means false, not f in name means true
        label = [int(not 'f' in im_name)]

        im = Image.open(im_name)
        im = (np.array(im))

        r = im[:,:,0].flatten()
        g = im[:,:,1].flatten()
        b = im[:,:,2].flatten()

        byte_format = np.array(list(label) + list(r) + list(g) + list(b),np.uint8)
        f.write(byte_format)
    f.close()
