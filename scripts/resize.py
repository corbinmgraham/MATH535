import numpy as np
import matplotlib.pyplot as plt
from skimage import io, color, transform, util
import os
from img_folder import read_folder, save_folder

def img_op(images, op):
    new_images = []
    for img in images:
        new_images.append((
            img[0], # name
            op(img[1]))) # image resized
    return new_images

def resize(img, shape=(1024,1024)):
    img = img[0:1024, 0:1024]
    return img

def flatten(img):
    if(len(img.shape) > 2):
        img = color.rgb2gray(img)
    return img

def save_images(images, path):
    plt.imsave(path, images[0][1])

def main(cd):
    loc = cd + "/Images/Graham_flatfield/"
    imgs = read_folder(loc)

    imgs = img_op(imgs, flatten)
    imgs = img_op(imgs, resize)

    loc = loc + 'new/'
    save_folder(loc, imgs)

if __name__ == "__main__":
    main(os.getcwd())