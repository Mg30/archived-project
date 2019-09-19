#include "affichage.h"
void afficher_pioche()
{
    // procédure qui affiche la première carte de la pile de la pioche.
    if (pioche.carteMain != NULL)
    {
        printf("Prochaine carte à piocher : %s ", pioche.carteMain->nom);
        nomClasse(pioche.carteMain->classe);

        printf("\n");
    }
    else
    {
        printf("La pioche est vide\n");
    }
}

void nomClasse(int classe)
{
    // affiche le nom de classe en fonction du numero de la classe
    // utilisation :  nomclasse(carte);
    switch (classe)
    {
    case -1:
        printf("INDISPONIBLE");
        break;
    case 0:
        printf("MONSTRE");
        break;
    case 1:
        printf("FANTOME");
        break;
    case 2:
        printf("VAMPIRE");
        break;
    case 3:
        printf("SPECIAL");
        break;
    }
}
void nomType(int type)
{
    // affiche le nom de classe en fonction du numero de la classe
    // utilisation :  nomclasse(carte);
    switch (type)
    {
    case -1:
        printf("INDISPONIBLE");
        break;
    case 0:
        printf("Normal");
        break;
    case 1:
        printf("Brute");
        break;
    case 2:
        printf("Musicien");
        break;
    case 3:
        printf("Epouvantail");
        break;

    case 4:
        printf("Vamp");
        break;

    case 5:
        printf("Enfant");
        break;

    case 6:
        printf("Taxi");
        break;
    }
}

void afficher_soiree(TJoueur joueur)
{
    printf("\nJOUEUR %d NORMAL      BRUTE      MUSICIEN", joueur.id);
    for (int j = 0; j < 3; j++)
    { // Classe
        printf("\n");
        nomClasse(j);
        printf("S");
        //~ switch (j){
        //~ case 0: printf("\nMONSTRES "); ;break;
        //~ case 1: printf("\nVAMPIRES "); ;break;
        //~ case 2: printf("\nFANTOMES "); ;break;
        //~ case 3: printf("\nSPECIALS "); ;break;
        //~ }
        for (int k = 0; k < 3; k++)
        {                                                        // Type
            printf("  %d         ", joueur.soiree[j].cartes[k]); // Affiche contenue
        }
    }
    printf("\nNOMBRES D'EPOUVANTAIL : %d\n", joueur.soiree[SPECIAL].cartes[EPOUVANTAIL]);
}
void affiche_main(TJoueur joueur)
{

    printf("Cartes du joueur %d \n", joueur.id);
    if (joueur.nbCarteMain != 0)
    {
        for (int i = 0; i < 5; i++)
        {
            printf("carte n° %d : ", i + 1);
            nomClasse((joueur.carteMain[i]).classe);
            printf(" ");
            nomType((joueur.carteMain[i]).type);
            printf("\n");
        }
    }
    else
    {
        printf("Vous n'avez plus de cartes");
    }
}