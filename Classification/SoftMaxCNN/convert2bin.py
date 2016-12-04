from PIL import Image
import numpy as np
import random
import glob

img_list = glob.glob('../tiles/*.jpg')
random.shuffle(img_list)

# total number of training set is 22444: 22444/8 = 2805.5

for j in range(0, 8):
    name = 'gray'+ str(j) + '.bin'
    f = open(name,'wb')
    for i in range(j*2805, (j+1)*2805):
        im = Image.open(img_list[i]).convert('L')
        im = np.array(im)

        g = im[:,:].flatten()

        if 'epithelial' in img_list[i]:
            label = [0]
        elif 'fibroblast' in img_list[i]:
            label = [1]
        elif 'inflammatory' in img_list[i]:
            label = [2]
        elif 'others' in img_list[i]:
            label = [3]
        else:
            print('Something is wrong, I can feel it!')

        out = np.array(list(label) + list(g), np.uint8)
        f.write(out)
    f.close()

