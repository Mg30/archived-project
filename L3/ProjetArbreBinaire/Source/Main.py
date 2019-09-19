# -*-coding: utf-8 -*
from Tabr import *
from Fonction import *

content = ""
tabr = Tabr()
affichage =""
def openfile():
    """Fonction qui ouvre une boite de dialogue pour ouvrir un fichier et retourne le contenu du fichier"""
    filename = askopenfilename(title="Ouvrir un fichier", filetypes=[('text files', '.txt'), ('all files', '.*')])
    try:
        with open(filename) as f:
            global content
            content = f.read()
    except:
        showerror(message="Erreur avec le fichier")

def check():

    if content == '':
        showinfo(title="Info", message="Veuillez ouvrir un fichier")
        return False
    else:
        return True

def creation():
    """ procédure pricnpale"""
    global content
    global tabr
    if check():
        tabr = Tabr()
        data = content
        tabr.initialisation(data)


def verification():

    if check():
        global tabr
        tabr.verification()
        text.delete('1.0',END)

        if tabr.interval:
            text.insert('1.0', "Les intervalles sont corrects : Oui \n")
        else:
            text.insert('1.0', "Les intervalles sont corrects : Non \n")

        if tabr.entier:
            text.insert('1.0', "Les entiers sont compris dans l' interval : Oui \n")
        else:
            text.insert('1.0', "Les entiers sont compris dans l' interval : Non \n")

        if tabr.disjoint:
            text.insert('1.0', "Les intervalles  sont disjoints: Oui\n")
        else:
            text.insert('1.0', "Les intervalles  sont disjoints: Non \n")

        if tabr.croissant:
            text.insert('1.0', "Les intervalles  sont en ordre croissant: Oui \n")
        else:
            text.insert('1.0', "Les intervalles  sont en ordre croissant: Non \n")

def affichage():
    if check():
        global tabr
        global affichage
        affichage = tabr.toScreen()
        text.delete('1.0',END)
        text.insert('1.0', affichage)


def save():
    global tabr
    file = saveas()
    tabr.toFile(file)

def insert():
    if check():
        if entree2.get() == "":
            showinfo(title="Info", message="Nombre à insérer vide")
            return
        else:
            global tabr
            nb = int(entree2.get())
            if tabr.insertion(nb):
                showinfo(title="Info", message="Insertion réussie")
            else:
                showinfo(title="Info", message="Aucun interval pour ce nombre")


def supp():
    if check():
        if entree3.get() == "":
            showinfo(title="Info", message="Nombre à supprimer vide")
            return
        else:
            global tabr
            nb = int(entree3.get())
            statut = tabr.suppresion(nb)
            if statut == 0:
                showinfo(title="Info", message="Aucun intervalle ne contient ce nombre")
            elif statut == 2:
                showinfo(title="Info", message="Ce nombre n'est dans aucun arbre")
            else:
                showinfo(title="Info", message="Suppresion réussie")


def fusion():
    if check():
        if entree4.get() == "":
            showinfo(title="Info", message="Veuillez remplir le numéro d'index")
            return
        else:
            global tabr
            nb = int(entree4.get())
            if nb > len(tabr.liste) or nb < 0:
                showinfo(title="Info", message="Veuillez saisir une numéro d'index valide")
            elif nb-1 == len(tabr.liste)-1:
                showinfo(title="Info", message="Index n+1 n'existe pas")

            else:
                tabr.fusion(nb-1)

def abr():
    global tabr
    tabr.versAbr()

def effacer():
    text.delete('1.0',END)




fenetre = Tk() # création de la fenetre principale

#Création du menu déroulant
menubar = Menu(fenetre)
fenetre.config(menu=menubar)
menu1 = Menu(menubar)
menubar.add_cascade(label="Fichier..", menu=menu1)
menu1.add_command(label="Ouvrir un fichier..", command=openfile)
menu1.add_separator()
menu1.add_command(label="Quitter", command=fenetre.quit)
frame= LabelFrame(fenetre, text="Conception algo", padx=20, pady=20)
frame.pack(fill="both", expand="yes")
frame3= LabelFrame(frame, text="Affichage",padx=20, pady=20)
frame3.pack(side=LEFT,fill="both", expand="yes")
frame10 = LabelFrame(frame3, text="Menu",padx=20, pady=20)
frame10.pack(side=BOTTOM)
frame2= Frame(frame)
frame2.pack(side=BOTTOM)

frame5= LabelFrame(frame, text="Manipulation TABR",padx=20, pady=20)
frame5.pack(side=BOTTOM,fill="both", expand="yes")

frame4= LabelFrame(frame5, text="Insertion", padx=20, pady=20, relief=RAISED)
frame4.pack(fill="both", expand="yes")
frame6= LabelFrame(frame5, text="Suppresion", padx=20, pady=20, relief=RAISED)
frame6.pack(fill="both", expand="yes")
frame7= LabelFrame(frame5, text="Fusion", padx=20, pady=20, relief=RAISED)
frame7.pack(fill="both", expand="yes")
text = Text(frame3, width=50, height=10)
text.pack()
bouton2 = Button(frame10,text="Créer",width=30,relief=GROOVE,command= creation)
bouton2.pack()

bouton3 = Button(frame10,text="Verifier",width=30,relief=GROOVE,command= verification)
bouton3.pack()

bouton4 = Button(frame10,text="Afficher",width=30,relief=GROOVE,command= affichage)
bouton4.pack()

bouton5 = Button(frame10,text="Vers fichier",width=30,relief=GROOVE,command= save)
bouton5.pack()

bouton6 = Button(frame10,text="Insérer",width=30,relief=GROOVE,command= insert)
bouton6.pack()

bouton10 = Button(frame10,text="Supprimer",width=30,relief=GROOVE,command= supp)
bouton10.pack()

bouton7 = Button(frame10,text="Fusion",width=30,relief=GROOVE,command= fusion)
bouton7.pack()
bouton8 = Button(frame10,text="Vers abr",width=30,relief=GROOVE,command= abr)
bouton8.pack()



bouton9 = Button(frame3,text="Effacer",width=30,relief=GROOVE,command= effacer)
bouton9.pack()


#Creation de l'entrée clavier
label1= Label(frame4, text="Nombre à insérer: ")
label1.grid(row=0,sticky=E)

value2 = StringVar()
entree2 = Entry(frame4, textvariable=value2, width=3)
entree2.grid(row=0, column=1)

label2= Label(frame6, text="Nombre à supprimer: ")
label2.grid(row=0,sticky=E)

value1 = StringVar()
entree3 = Entry(frame6, textvariable=value1, width=3)
entree3.grid(row=0, column=1)

label3 = Label(frame7, text="Index pour fusion: ")
label3.grid(row=0,sticky=E)
value3 = StringVar()
entree4 = Entry(frame7, textvariable=value3, width=3)
entree4.grid(row=0, column=1)


fenetre.mainloop()

#Passer le content a une instance TABR qui va avoir une methode ecrire ficher

