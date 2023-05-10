import numpy as np
from skimage import io
import os

def save_img(path, name, img):
  io.imsave(path + name, img)
  print("Image saved as:", name)

def read_img(file: str) -> np.array:
    return io.imread(file)

def save_folder(path, images) -> None:
    for img in images:
        save_img(path, img[0] + '.png', img[1])

def read_folder(path, match='jpg'):
    images = []
    for file in os.listdir(path):
        try:
            name,ext = file.split('.')
        except:
            continue
        if not ext == match:
            continue
        print(name, ext)
        images.append((name, read_img(path + file)))
    return images