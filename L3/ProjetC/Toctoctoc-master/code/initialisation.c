
#include "initialisation.h"

void initialisation_pioche(TJoueur joueurs[3])
{
    // cette procedure prend en paramètre un tableau des joueurs.
    // les joueurs sont utilisés pour retirer les cartes qui ont été placées dans les soirées
    printf("Création de la pioche...");

    pioche.nbCarteMain = 0;
    pioche.carteMain = NULL;

    // classe monstre
    TClasse monstre;
    strcpy(monstre.nom, "monstre");
    monstre.classe = 0;
    monstre.cartes[0] = 7;
    monstre.cartes[1] = 1;
    monstre.cartes[2] = 1;
    monstre.cartes[3] = 5;
    // classe fantome
    TClasse fantome;
    strcpy(fantome.nom, "fantome");
    fantome.classe = 1;
    fantome.cartes[0] = 7;
    fantome.cartes[1] = 1;
    fantome.cartes[2] = 1;
    fantome.cartes[3] = 5;
    // classe monstre
    TClasse vampire;
    strcpy(vampire.nom, "vampire");
    vampire.classe = 2;
    vampire.cartes[0] = 7;
    vampire.cartes[1] = 1;
    vampire.cartes[2] = 1;
    vampire.cartes[3] = 5;
    // classe monstre
    TClasse special;
    strcpy(special.nom, "special");
    special.classe = 3;
    special.cartes[0] = 5; // enfant
    special.cartes[1] = 3; //taxi
    special.cartes[2] = 4; // epouvantail
    special.cartes[3] = 0;
    // creation des cartes
    TClasse tab[4] = {monstre,
                      fantome,
                      vampire,
                      special};

    // enlevement des cartes déjà dans les soirées.
    // int cpt = 0; // test
    for (int j = 0; j < 3; j++)
    {
        for (int i = 0; i < 4; i++)
        {
            for (int k = 0; k < 4; k++)
            {
                if (joueurs[j].soiree[i].cartes[k] > 0)
                {
                    // cpt++; // test
                    tab[i].cartes[k] -= joueurs[j].soiree[i].cartes[k]; // on les retire de la generation
                                                                        //   printf("%d\n", joueurs[j].soiree[i].cartes[k]); // debug
                }
            }
        }
    }

    srand(time(NULL));
    while (pioche.nbCarteMain < 48) // ajout de 2 cartes epouvantails donc passage de 46 à 48
    {

        struct TCarte *cell = (TCarte *)malloc(sizeof(TCarte));
        // coder le cas ou il y a rien et le cas ou il y a deja une carte
        int c; // no classe
        int t; //no type
        do
        {
            c = rand() % 4;
            t = rand() % 4;
        } while (tab[c].cartes[t] <= 0);
        pioche.nbCarteMain++;
        tab[c].cartes[t]--; // on enleve une carte

        cell->classe = c;

        cell->suivant = NULL;

        if (c == 3) // si c'est la classe spéciale
        {
            switch (t)
            {
            case 0:
                strcpy(cell->nom, "enfant");
                cell->type = ENFANT; // se référer au tableau du guide pour le numéro du type
                break;
            case 1:
                strcpy(cell->nom, "taxi");
                cell->type = TAXI;
                break;
            case 2:
                strcpy(cell->nom, "epouvantail");
                cell->type = EPOUVANTAIL;
                break;
            default:
                break;
            }
        }
        else // pour les autres classes
        {

            switch (t)
            {
            case 0:
                strcpy(cell->nom, "normal");
                cell->type = NORMAL;
                break;
            case 1:
                strcpy(cell->nom, "brute");
                cell->type = BRUTE;
                break;
            case 2:
                strcpy(cell->nom, "musicien");
                cell->type = MUSICIEN;
                break;
            case 3:
                strcpy(cell->nom, "vamp");
                cell->type = VAMP;
                break;
            }
        }
        if (pioche.carteMain == NULL) // première carte
        {
            pioche.carteMain = cell;
        }
        else // insertion queue
        {
            TCarte *aux = pioche.carteMain;
            while (aux->suivant != NULL)
            {
                aux = aux->suivant;
            }
            aux->suivant = cell;
        }
    }
    printf("OK\n");
}

void initialisation_soiree_joueur(TJoueur joueurs[])
{
    printf("Création des soirées...");

    for (int n = 0; n < nbjoueur; n++)
    { // Joueur
        for (int j = 0; j < 4; j++)
        { // Classe
            for (int k = 0; k < 4; k++)
            {                                       // Type
                joueurs[n].soiree[j].cartes[k] = 0; // Initialise TOUT le tableau a 0
            }
        }
    }
    int tab[12] = {0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2}; // initialisation d'un tableau correspondant a 4monstres(0,0,0,0)/4fantôme(1,1,1,1)/4vampires(2,2,2,2)
    int nombre_aleatoire = 0;
    srand(time(NULL));
    int nb = nbjoueur * 2; // On distribue 2cartes pour chaques joueurs
    for (int i = 0; i < nb; i++)
    {                                   // Boucle pour distribuer les N cartes
        nombre_aleatoire = rand() % 12; // Nombre aléatoire entre 0 et 11
        while (!isvalid(nombre_aleatoire, tab))
        { // Boucle jusqu'à ce que le nombre soit valide
            nombre_aleatoire = rand() % 12;
        }
        if (i < 2)
        {
            joueurs[0].soiree[tab[nombre_aleatoire]].cartes[NORMAL]++;
        }
        else if (i < 4)
        {
            joueurs[1].soiree[tab[nombre_aleatoire]].cartes[NORMAL]++;
        }
        else if (i < 6)
        {
            joueurs[2].soiree[tab[nombre_aleatoire]].cartes[NORMAL]++;
        }
        tab[nombre_aleatoire] = 9; // Change la valeur du tab[nombre_aléatoire] en 9 pour le rendre "déjà utilisé"
    }
    printf("OK\n");
}

int isvalid(int num, int tab[]) // utilise pour init soirée
{ // Boucle de validité d'un nombre

    // Si le tab[num] est différent de 9, alors il est "utilisable"
    return tab[num] != 9;
    // Si le tab[num] est égale à 9, alors il est "déjà utilisé"
}

void initialisation_main(TJoueur *joueur) // probleme initilaisation main
{
    // la procédure permet un à joueur de piocher 5 fois
    joueur->nbCarteMain = 0;
    printf("Création de la main du joueur %d ...", joueur->id);
    //boucle qui fait appel à la fonction pioche
    for (int i = 0; i < 5; i++)
    {
        int indice = 0;

        // A chaque tour on met une carte dans l'indice courant du tableau
        piocher(&joueur->carteMain[i], &indice);

        //On incrémente nbcarteMain pour mettre le nombre de cartes en main à 5
        joueur->nbCarteMain++;
    }
    printf("OK\n");
    //debug_pioche();
}
void piocher(TCarte *carte, int *piochePossible)
{
    //piocher permet à un joueur de piocher une carte
    //Lexique local:
    // On crée un variable qui va contenir la carte piochée

    //initialisation:
    TCarte *aux = pioche.carteMain;
    // pointeur aux qui prend la valeur du pointeur vers pioche
    
    //Début:

    //test pour voir si la pioche est vide
    if (pioche.nbCarteMain > 0)
    {

        //On affecte à carte la valeur de la première carte
        *carte = *pioche.carteMain;

        //On fait pointer cartemain vers la carte suivante
        pioche.carteMain = pioche.carteMain->suivant;
        pioche.nbCarteMain--;
        //On dessalloue aux qui a pour valeur la carte piochée
        free(aux);
        *piochePossible = 1;
    }
    else
    {
        printf("La pioche est vide.\n");
        *piochePossible = 0;
        // On ne pas piocher la pioche est vide
    }
}