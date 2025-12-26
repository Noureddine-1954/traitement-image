# 🖼️ Traitement d'Images Numériques : Approche Algorithmique

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg) ![Python](https://img.shields.io/badge/Python-3.x-yellow.svg) ![MATLAB](https://img.shields.io/badge/MATLAB-R202x-orange.svg) ![License](https://img.shields.io/badge/License-Academic-lightgrey.svg)

Ce dépôt contient l'implémentation logicielle et la documentation technique relative au Mini-Projet académique de **Traitement d'Image**. L'application développée offre une interface graphique (GUI) intuitive permettant l'acquisition, l'analyse, la synthèse et la transformation d'images numériques via des algorithmes matriciels fondamentaux, implémentés sans recours aux fonctions de haut niveau ("boîte noire").

---

## 👥 Équipe de Réalisation

Ce projet a été conçu et développé par l'équipe suivante :

| Membre de l'équipe | Rôle / Contribution |
| :--- | :--- |
| **Moncef Enfessi** | Version Python |
| **Charaf** | Version Matlab |
| **Abdurahman El Fennane** | Version Matlab |
| **Haitam Elghazi** | Rapport et Documentation |
| **Noureddine El Moutaouakkil** | Version Python et Readme |

### 👨‍🏫 Encadrement Pédagogique
**Encadré par :** Pr. Noureddine Aboutabit  
*Module : Informatique 3 (Programmation Python & Matlab)* *Université Sultan Moulay Slimane - ENSA Khouribga*

---

## 🎯 Objectifs et Portée du Projet

L'objectif de ce projet est de transposer les concepts théoriques du traitement du signal et de l'image en applications logicielles concrètes. Les axes principaux incluent :

* **Manipulation Matricielle :** Compréhension de la structure des images numériques (matrices 2D pour les niveaux de gris, tenseurs 3D pour le RGB).
* **Algorithmique Bas Niveau :** Implémentation manuelle des transformations (symétries, inversion colorimétrique) pour maîtriser la complexité algorithmique.
* **Analyse Statistique :** Extraction de descripteurs d'image (Luminance, Variance/Contraste, Profondeur).
* **Développement GUI :** Conception d'une interface ergonomique facilitant l'interaction utilisateur-algorithme.

---

## 🚀 Fonctionnalités Détaillées

L'application est structurée autour de cinq modules principaux :

### 1. Gestion des Entrées/Sorties (I/O)
* **Lecture Universelle :** Support des formats standards (`.JPG`, `.PNG`, `.BMP`, `.TIF`).
* **Exportation :** Sauvegarde des images traitées ou générées.

### 2. Synthèse d'Images
* **Génération Unie :** Création de matrices uniformes (Noir/Blanc).
* **Motifs Géométriques :** Algorithme de génération de damier (pattern alterné).
* **Génération Stochastique :** Création de bruit aléatoire RGB (Random Noise).

### 3. Traitement et Transformations
* **Négatif (Inversion) :** Transformation linéaire $P' = 255 - P$.
* **Transformations Géométriques :** Miroir horizontal (Flip H) et vertical (Flip V) par manipulation d'indices matriciels.
* **Conversion Colorimétrique :** Passage du RGB au Niveaux de Gris via calcul de luminance pondérée ou moyenne.

### 4. Analyse Quantitative
* **Luminance :** Calcul de la moyenne des intensités des pixels.
* **Contraste :** Évaluation de la dispersion des intensités (Variance).
* **Métadonnées :** Extraction de l'intensité maximale (Profondeur) et des dimensions spatiales.

### 5. Opérations de Combinaison
* **Juxtaposition :** Algorithmes de collage vertical et horizontal avec gestion dynamique du redimensionnement pour aligner les matrices.

---

## 💻 Guide d'Installation et d'Exécution

### Prérequis Techniques
* **Environnement Python :** Python 3.8+ (Bibliothèques requises : `numpy`, `matplotlib`, `tkinter`).
* **Environnement MATLAB :** MATLAB R2018b+ ou GNU Octave.
* **Système :** Compatible Linux, macOS et Windows.

### ⚙️ Déploiement Rapide

Pour faciliter l'exécution des différentes versions, des scripts shell sont fournis. Veuillez suivre la procédure ci-dessous dans votre terminal :

1.  **Cloner le dépôt :**
    ```bash
    git clone https://github.com/Noureddine-1954/traitement-image.git
    cd traitement-image
    ```

2.  **Accorder les permissions d'exécution :**
    ```bash
    chmod +x version_python.sh version_matlab.sh
    ```

3.  **Lancer l'application :**

    * *Pour la version MATLAB :*
        ```bash
        ./version_matlab.sh
        ```
    * *Pour la version Python :*
        ```bash
        ./version_python.sh
        ```

---

## 📚 Bibliographie et Références

Les ressources suivantes ont été consultées pour l'élaboration des algorithmes et la compréhension théorique du traitement d'image :

1.  **Support de Cours / Énoncé du Projet :**
    * [cite_start]*Mini-projet : Traitement d'images - Informatique 3*, ENSA Khouribga, Université Sultan Moulay Slimane [cite: 9-11].

2.  **Documentation Technique et Théorique :**
    * Benhadda, N. (n.d.). *Traitement des images*. Scribd.  
      Disponible sur : [https://www.scribd.com/document/609175575/Traitement-des-images](https://www.scribd.com/document/609175575/Traitement-des-images)

3.  **Documentation Officielle :**
    * [Documentation MATLAB Image Processing Toolbox](https://www.mathworks.com/help/images/)
    * [Documentation NumPy](https://numpy.org/doc/)

---
*Dernière mise à jour : Décembre 2025*