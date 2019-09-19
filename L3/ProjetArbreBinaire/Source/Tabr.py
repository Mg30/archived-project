# -*-coding: utf-8 -*
from tkinter import *
from tkinter.filedialog import *
from tkinter.messagebox import *
from Fonction import *
from ABR import *
class Tabr:
    """Classe qui permet de stocker les intervals """


    def __init__(self):
        """constructeur"""
        self.liste = list()
        self.verif = False
        self.interval= True # boolen qui permet de verifier si les intervals sont corrects
        self.entier = True # Boolean qui permet de verifier que les entiers sont compris dans l' interval
        self.disjoint = True # intervals disjoints et ordre croissant
        self.croissant = True
    def initialisation(self, content):
        """Methode qui permet de créer un tabr à partir d'un fichier"""
        index = content.split("\n")
        del(index[len(index)-1])
        for value in index:
            value = value.split(";")
            cle = value[0].split(":")
            cle = [int(x) for x in cle]
            cle = (cle[0], cle[1])
            if value[1] == '':
                abr = Tree()
            else:
                valeur = value[1].split(":")
                valeur = [int(x) for x in valeur]
                abr = Tree()
                for entier in valeur:
                    abr.insert(entier)

            dico = dict()
            dico[cle] = abr
            self.liste.append(dico)


    def verification(self):
        """Procédure qui verfie sur le Tabr repond aux critères souhaités"""

        listcles = list()
        for dico in self.liste:
            for cle, valeur in dico.items():
                listentier = list()
                listcles.append(cle)
                if cle[0] > cle[1]:
                    self.interval = False
                valeur.preorderTolist(listentier)
                for entier in listentier:
                    if entier not in range(cle[0], cle[1]):
                        self.entier = False

        for i in range(0, len(listcles)-2):
            if listcles[i][1] > listcles[i+1][0]:
                self.croissant = False
            if listcles[i+1][0] in range(listcles[i][0],listcles[i][1]) or listcles[i+1][1] in range(listcles[i][0],listcles[i][1]):
                self.disjoint = False



    def toFile (self, path):
        """Fonction qui permet d'exporter le TABR vers un fichier text"""

        with open(path,"a") as f:
            i = 1
            for dico in self.liste:
                f.write("Index" + str(i)+"\n")
                for cle,valeur in dico.items():
                    prefixe = list()
                    f.write(str(cle))
                    f.write("=>")
                    valeur.preorderWrite(prefixe)
                    f.write(str(prefixe))
                f.write("\n")
                i = i + 1

    def toScreen(self):
        """Methode qui permet de retourner un string formate pour l'affichage"""
        data = ""
        i = 1
        for dico in self.liste:
            data = data +"Index" + str(i) + "\n"
            for cle, valeur in dico.items():
                level = 0
                if valeur is None:
                    valeur = Tree()
                    dico[cle] = valeur
                prefixe = list()
                data = data +(str(cle))
                data = data + "=>"
                valeur.preorderWrite(prefixe,level)
                data = data + str(prefixe)
            data = data + "\n"
            i = i + 1

        return data


    def insertion(self,data):
        """Procedure qui insère une valeur dans le bon interval"""
        insert = False
        for dico in self.liste:
            for cle,arbre in dico.items():
                if data in range(cle[0], cle[1]):
                    arbre.insert(data)
                    insert = True
                    break
        return insert

    def suppresion(self, data):
        """Procedure qui supprime une valeur du tabr"""
        list
        statut = 0
        for dico in self.liste:
            for cle, arbre in dico.items():
                if data in range(cle[0], cle[1]):
                    if arbre.find(data):
                        a = Tree()
                        a = arbre.delete(data)
                        dico[cle] = a
                        statut = 3
                    else:
                        statut = 2
                if statut != 0:
                    break
            if statut != 0:
                break

        return statut


    def fusion(self,index):
        """Methode qui permet de fusionner deux cases du Tabr """

        for cle in self.liste[index].keys():
            cle1 = cle
        for cle in self.liste[index+1].keys():
            cle2 = cle
        newCle =(cle1[0],cle2[1])
        listvalabr1 = list()
        listvalabr2 = list()
        listFusion= list()
        dico = {}
        arbre1 = self.liste[index][cle1]
        arbre1.preorderTolist(listvalabr1)
        arbre2 = self.liste[index+1][cle2]
        arbre2.preorderTolist(listvalabr2)
        listFusion = listvalabr1 + listvalabr2
        arbreFusion = Tree()
        for valeur in listFusion:
            arbreFusion.insert(valeur)
        dico[newCle] = arbreFusion
        del(self.liste[index])
        del(self.liste[index])
        self.liste.append(dico)
        self.liste = sorted(self.liste, key=lambda k: list(k.keys())[0][1])





    def versAbr(self):
        """Methode qui permet de transformer le Tabr en abr avec toutes les valeurs"""
        listEntier = list ()
        for dico in self.liste:
            for valeur in dico.values():
                valeur.preorderTolist(listEntier)
        abr = Tree()
        for entier in listEntier:
            abr.insert(entier)
        dictio = {}
        dictio["abr"] = abr
        self.liste = list()
        self.liste.append(dictio)













