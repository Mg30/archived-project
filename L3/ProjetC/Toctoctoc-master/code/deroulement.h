#ifndef DEROULEMENT_H
#define DEROULEMENT_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "types.h"
#include "affichage.h"
#include "util.h"
#include "initialisation.h"

/////////////// proposition de carte ///////////////////:
void proposer_carte(TJoueur *joueurActif, TJoueur joueurs[]);
void choix_carte(TJoueur joueur,int *indice, TCarte *carte);
TJoueur choix_joueur(TJoueur tabjoueur[],int idjoueuractif);
int reponse_carte(int joueurActif, int joueurVise);


void revelation_carte(TJoueur *joueur_actif, TJoueur *joueur_cible, TCarte carte);
int estCarteEffet(TCarte carte);
int appliquerEffet(TCarte carte); // retourune un tableau avec la classe et le type
int compteInvitesParClasse(TJoueur joueur, int classe);
int presenceBrute(TJoueur joueur, int classe);

#endif