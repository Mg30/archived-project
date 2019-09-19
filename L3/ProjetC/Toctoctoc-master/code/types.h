#ifndef TYPES_H
#define TYPES_H

///// type ////
#define NORMAL 0
#define BRUTE 1
#define MUSICIEN 2
#define EPOUVANTAIL 3
#define VAMP 4
#define ENFANT 5
#define TAXI 6

//// classe ////
#define MONSTRE 0
#define FANTOME 1
#define VAMPIRE 2
#define SPECIAL 3

#define nbjoueur 3

typedef struct TClasse
{
    char nom[10]; //monstre, vampyre ...
    int classe;   //entier correspondant au nom de la classe exemple : 1 pour monstre
    int cartes[4]; // nombre de carte du type → carte[4,1,1,1]
} TClasse;



typedef struct TCarte
{
    char nom[10]; // Brute Monstre
    int classe;   // 0, 1...
    int type;     // 0,1...
    struct TCarte *suivant;
} TCarte;



typedef struct TJoueur
{
    int id; // Joueur n°
    char nom[15];
    int nbCarteMain;          //Le joueur possède 5 cartes dans sa main
    TCarte carteMain[5]; // → TCarte correspondant a sa main
    TClasse soiree[4];
} TJoueur;

typedef struct	TPioche
{
    int nbCarteMain;          //Le joueur possède 5 cartes dans sa main
    struct TCarte *carteMain; // → TCarte correspondant a sa main
} TPioche;

TPioche pioche; // variable


#endif // FONCTION_H_INCLUDED

