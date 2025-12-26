import matplotlib.pyplot as plt
import numpy as np

def lectureImage(chemin):
    # lecture de l'image via matplotlib
    img = plt.imread(chemin)
    return img

def AfficherImg_nb(img):
    plt.axis("off")
    # affiche en niveaux de gris
    plt.imshow(img, cmap="gray", interpolation="nearest")
    plt.show()

def saveImage(img):
    # sauvegarde de l'image sur le disque
    plt.imsave("image1.png", img)

def image_noire(h, l):
    # image vide remplie de 0 (noir)
    return np.zeros((h, l), dtype=int)

def image_blanche(h, l):
    # image remplie de 1 (blanc)
    return np.ones((h, l), dtype=int)

def creerImgBlancNoir(h, l):
    # creation damier avec modulo 2
    return np.array([[(i + j) % 2 for i in range(l)] for j in range(h)])

def negatif(img):
    # inverse les valeurs (1 devient 0 et inversement)
    return 1 - img