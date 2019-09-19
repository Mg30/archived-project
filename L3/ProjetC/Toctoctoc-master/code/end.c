#include "end.h"
void liberer_pioche()
{
    // procédure qui libère la mémoire de la pioche
    // elle n'est pas utilisée, mais elle pourrait l'être si
    // on laisse le choix aux utilisateurs d'arrêter le jeu.
    TCarte *prec;
    while (pioche.carteMain != NULL)
    {
        prec = pioche.carteMain;
        pioche.carteMain = pioche.carteMain->suivant;
        free(prec);
        pioche.nbCarteMain--;
        if (prec->nom == NULL)
            printf("%s\n", prec->nom);
    }
}

int calcul_score(TJoueur joueur)
{

    int musicien[3] = {1, 1, 1};
    int point[4] = {0, 0, 0, 0}; // Récap des points {MONSTRE,FANTOME,VAMPIRES}
    for (int j = 0; j < 4; j++)
    { // Classe
        for (int k = 0; k < 4; k++)
        { // Type
            if (k == MUSICIEN && joueur.soiree[j].cartes[k] != 0)
            {
                musicien[j] = 2; // Le musicien multiplie le score de sa classe par 2
                point[j] += joueur.soiree[j].cartes[k];
            }
            else if (k == SPECIAL && j == EPOUVANTAIL)
            {
                point[j] += (joueur.soiree[j].cartes[k]) * 3; // L'épouvantail vaut 3 points
            }
            else
            {
                point[j] += joueur.soiree[j].cartes[k];
            }
        }
    }
    return (point[MONSTRE] * musicien[MONSTRE] + point[FANTOME] * musicien[FANTOME] + point[VAMPIRE] * musicien[VAMPIRE] + point[EPOUVANTAIL]); // On cumul tout les scores de chaque classe pour obtenir le score total.=
}