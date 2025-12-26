import numpy as np
from random import randrange

def initImageRGB(imageRGB):
    H, W = imageRGB.shape[:2]
    # On prépare une toile vide de la même taille
    result = np.empty((H, W, 3), dtype=np.uint8)

    # On parcourt chaque pixel un par un (Ligne -> Colonne -> Couleur)
    # et on tire une valeur au hasard pour remplir l'image (bruit numérique).
    for i in range(H):
        for j in range(W):
            for k in range(3):
                result[i, j, k] = randrange(256) # Hasard entre 0 et 255
    return result

def symetrie_v(img):
    W = img.shape[1]
    img_cpy = img.copy() # On travaille sur une copie pour protéger l'original
    half = W // 2
    
    # On prend la partie GAUCHE de l'image (0 à half),
    # on la retourne comme un miroir (fliplr), 
    # et on colle le résultat sur la partie DROITE.
    img_cpy[:, W-half :] = np.fliplr(img_cpy[:, 0 : half])
    return img_cpy

def symetrie_h(img):
    H = img.shape[0]
    img_cpy = img.copy()
    half = H // 2
    
    # Même chose mais verticalement.
    # On prend le HAUT, on le retourne (flipud), et on le colle en BAS.
    img_cpy[H-half:, :] = np.flipud(img_cpy[:half, :])
    return img_cpy

def grayscale(imageRGB):
    # Sécurité technique pour les formats d'image
    if imageRGB.dtype != np.uint8:
        imageRGB = (imageRGB * 255).astype(np.uint8)

    H, W = imageRGB.shape[:2]
    img_gr = np.zeros((H, W), dtype=np.uint8)

    if len(imageRGB.shape) == 3:
        # Pour chaque pixel, on cherche la couleur la plus forte (Max)
        # et la plus faible (Min). On fait la moyenne des deux.
        # Ça donne un niveau de gris "moyen" (désaturation).
        for h in range(H):
            for w in range(W):
                val = int(np.max(imageRGB[h, w])) + int(np.min(imageRGB[h, w]))
                img_gr[h, w] = val // 2
    else:
        img_gr = imageRGB.copy()

    return img_gr