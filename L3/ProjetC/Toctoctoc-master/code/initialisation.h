#ifndef INITIALISATION_H
#define INITIALISATION_H


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "types.h"


////////////////// initialisation ///////////////////////
void initialisation_soiree_joueur(TJoueur joueurs[]);
void initialisation_pioche(TJoueur joueurs[3]); 
void initialisation_main(TJoueur* joueur); // Procédure qui prend en entrée un pointeur vers la pioche, et un joueur pour lui insérer une carte dans la main
void piocher(TCarte *carte,int *piochePossible);
int isvalid(int num, int tab[]);


#endif // FONCTION_H_INCLUDED