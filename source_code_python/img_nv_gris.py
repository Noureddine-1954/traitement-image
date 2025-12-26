import matplotlib.pyplot as plt
import numpy as np

# --- Chargement et Affichage ---

def ouvrir(path):
    """Charge une image et enlève le canal Alpha (transparence) si présent."""
    img = plt.imread(path)
    # Si l'image a 3 dimensions (ex: RGB ou RGBA), on garde les 3 premiers canaux (RGB)
    if len(img.shape) == 3:
        img = img[:, :, :3]
    return img

def AfficherImg(img):
    """Affiche l'image sans les axes."""
    plt.axis("off")
    # cmap="gray" ne sert que si l'image est en 2D (niveaux de gris). 
    # Si elle est en RGB, matplotlib l'affiche en couleur quand même.
    plt.imshow(img, cmap="gray", interpolation="nearest")
    plt.show()

def saveImage(img, nom_fichier="image_sortie.png"):
    """Sauvegarde l'image (nom personnalisable)."""
    plt.imsave(nom_fichier, img)

# --- Statistiques ---

def luminance(img):
    """Retourne la luminance moyenne globale de l'image."""
    return np.mean(img)

def contraste(img):
    """Calcule la variance des pixels (mesure de dispersion)."""
    mu = np.mean(img)
    diff_carre = (img - mu) ** 2
    somme = np.sum(diff_carre)
    N = img.size # size est plus sûr que shape[0]*shape[1] pour le RGB
    return somme / N

def profondeur(img):
    """Retourne la valeur maximale d'un pixel (ex: 255 ou 1.0)."""
    return np.max(img)

# --- Manipulations ---

def inverser(img):
    """Inverse les couleurs (négatif)."""
    # Pas besoin de convertir en np.array si img l'est déjà via imread
    p = np.max(img) 
    return p - img

def flipH(img):
    """Miroir Horizontal."""
    return np.flip(img, axis=1)

def flipV(img):                                                                     
    """Miroir Vertical."""
    return np.flip(img, axis=0) 

def poserV(img1, img2):
    """Colle deux images verticalement (l'une sur l'autre)."""
    # Attention: les images doivent avoir la même largeur
    return np.concatenate((img1, img2), axis=0)
    # Note: np.concatenate est souvent préféré à np.append pour les images

def poserH(img1, img2):
    """Colle deux images horizontalement (côte à côte)."""
    # Attention: les images doivent avoir la même hauteur
    return np.concatenate((img1, img2), axis=1)