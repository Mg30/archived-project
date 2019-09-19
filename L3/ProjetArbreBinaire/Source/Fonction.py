from tkinter.filedialog import *

def saveas ():
    """Fonction qui permet de demander à l'util de sauvegarder un fichier"""
    file = asksaveasfilename(title="Sauvegarder un fichier", filetypes=[('text files', '.txt'), ('all files', '.*')])
    return file


def profondeur(arbre):
    if arbre is None:
        return 0
    else:
        profGauche = profondeur(arbre.sag)
        profDroite = profondeur(arbre.sad)

        if profGauche > profDroite:
            return profGauche + 1
        else:
            return profDroite + 1

