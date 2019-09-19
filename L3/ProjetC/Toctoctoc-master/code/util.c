#include <stdio.h>
#include <stdlib.h> 
#include "util.h"
void debug_pioche()
{
    // fonction de debogage qui affiche le nombre de cartes de la pioche
    // ainsi que toutes ses cartes
    printf("nombre de cartes : %d\n", pioche.nbCarteMain);
    TCarte *aux;
    aux = pioche.carteMain;
    int i = 0;
    while (aux != NULL)
    {
        i++;
        printf("carte numero %d : %d %s ", i, aux->type, aux->nom);
        nomClasse(aux->classe);
        aux = aux->suivant;
        printf("\n");
    }
}

int max(int tab[], int taille)
{
    // retourne la plus grande valeur d'un tableau d'entier
    int maxi = tab[0];
    for (int i = 0; i < taille; i++)
    {
        if (tab[i] > maxi)
        {
            maxi = tab[i];
        }
    }
    return maxi;
}