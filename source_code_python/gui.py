import tkinter as tk
from img_noir_blanc import *
from img_nv_gris import *
from img_rgb import *
from tkinter import filedialog, simpledialog, messagebox

# variable global sert a sauvegarder tout changement pour que les changements/ les effets peu rester
img = None

# --------------------- Helper ---------------------
def ask_dimensions():
    """Ask user for height and width"""
    h = simpledialog.askinteger("Hauteur", "Entrez la hauteur (h):")
    w = simpledialog.askinteger("Largeur", "Entrez la largeur (w):")
    return h, w

def load_image():
    global img
    path = filedialog.askopenfilename(title="Ouvrir image")
    if path:
        img = ouvrir(path)
        AfficherImg(img)

def save_image():
    global img
    if img is None:
        messagebox.showerror("Erreur", "Charge une image d'abord.")
        return
    saveImage(img)
    messagebox.showinfo("Sauvegarde", "Image sauvegardée sous 'image1.png'.")

    #-------- Effects -----------#
def apply_image_effect(effect_func):
    global img
    if img is None:
        messagebox.showerror("Erreur", "Charge une image d'abord.")
        return
    img = effect_func(img)
    AfficherImg(img)

    #-------- Info -----------#
def apply_scalar_effect(effect_func):
    global img
    if img is None:
        messagebox.showerror("Erreur", "Charge une image d'abord.")
        return
    result = effect_func(img)
    messagebox.showinfo(effect_func.__name__, f"Résultat: {result}")

def Taille(img):
    return (str(img.shape[0]) + 'x' + str(img.shape[1]) + ' \n' + str(img.nbytes)+ ' Bytes.')

    #-------- Creation -----------#
def apply_create_image(create_func):
    global img
    h, w = ask_dimensions()
    if h is None or w is None:
        return
    if (create_func == initImageRGB):
        # Passe un tableau vide 3D pour que initImageRGB puisse en extraire H et W
        img = create_func(np.empty((h, w, 3), dtype=np.uint8))
        AfficherImg(img)
    else:
        img = create_func(h, w)
        plt.axis("off")
        plt.imshow(img, cmap = "gray",interpolation = "nearest", vmin = 0, vmax = 1)
        plt.show()

    #-------- Concatenation -----------#
def apply_poserV():
    global img
    path2 = filedialog.askopenfilename(title="Ouvrir image 2 pour poser vertical")
    if path2:
        img2 = ouvrir(path2)
        img = poserV(img, img2)
        AfficherImg(img)

def apply_poserH():
    global img
    path2 = filedialog.askopenfilename(title="Ouvrir image 2 pour poser horizontal")
    if path2:
        img2 = ouvrir(path2)
        img = poserH(img, img2)
        AfficherImg(img)

# --------------------- GUI ---------------------
root = tk.Tk()
root.title("Test Images - Toutes Fonctions")
root.geometry("200x850")

# Open / Save section
tk.Label(root, text="--- Ouvrir / Sauvegarder ---").pack()
tk.Button(root, text="Ouvrir image", command=load_image).pack(pady=2)
tk.Button(root, text="Sauvegarder image", command=save_image).pack(pady=2)

# Create images section
tk.Label(root, text="--- Créer Images ---").pack(pady=4)
tk.Button(root, text="Image noire", command=lambda: apply_create_image(image_noire)).pack(pady=2)
tk.Button(root, text="Image blanche", command=lambda: apply_create_image(image_blanche)).pack(pady=2)
tk.Button(root, text="Blanc/Noir (Damier)", command=lambda: apply_create_image(creerImgBlancNoir)).pack(pady=2)
tk.Button(root, text="Init RGB random", command=lambda: apply_create_image(initImageRGB)).pack(pady=2)

# Effects section
tk.Label(root, text="--- Effets ---").pack(pady=4)
tk.Button(root, text="Négatif", command=lambda: apply_image_effect(negatif)).pack(pady=2)
tk.Button(root, text="Inverser", command=lambda: apply_image_effect(inverser)).pack(pady=2)
tk.Button(root, text="Flip H", command=lambda: apply_image_effect(flipH)).pack(pady=2)
tk.Button(root, text="Flip V", command=lambda: apply_image_effect(flipV)).pack(pady=2)
tk.Button(root, text="Symétrie H", command=lambda: apply_image_effect(symetrie_h)).pack(pady=2)
tk.Button(root, text="Symétrie V", command=lambda: apply_image_effect(symetrie_v)).pack(pady=2)
tk.Button(root, text="Grayscale", command=lambda: apply_image_effect(grayscale)).pack(pady=2)

# Info section
tk.Label(root, text="--- Infos (valeurs) ---").pack(pady=4)
tk.Button(root, text="Luminance", command=lambda: apply_scalar_effect(luminance)).pack(pady=2)
tk.Button(root, text="Contraste", command=lambda: apply_scalar_effect(contraste)).pack(pady=2)
tk.Button(root, text="Profondeur", command=lambda: apply_scalar_effect(profondeur)).pack(pady=2)
tk.Button(root, text="Size", command=lambda: apply_scalar_effect(Taille)).pack(pady=2)

# Poser section
tk.Label(root, text="--- Combiner Images ---").pack(pady=4)
tk.Button(root, text="Poser Vertical", command=apply_poserV).pack(pady=2)
tk.Button(root, text="Poser Horizontal", command=apply_poserH).pack(pady=2)

root.mainloop()
