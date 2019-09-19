/*
couche applicatif, implémentant le jeu du pendu
*/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <time.h>
#include <string.h>
#include "pendu.h"

void checkEndGame(int *letterFinded, int lenWord, char secretWord[])
{/* Fonction qui verifie que le jeu est fini en faisant appel à isWinner
    @letterFinded: tableau de boolean
    @lenWord: longueur du mot à deviner
    @secretWord: mot à deviner
 */ 
    if (isWinner(letterFinded, lenWord))
        printf("\n\nisWinner ! Le mot secret etait bien : %s", secretWord);
    else
        printf("\n\nPerdu ! Le mot secret etait : %s", secretWord);

    free(letterFinded);
}

char readChar()
{ /* Fonction qui permet de lire les caractères dans l'entrée standard jusqu'à un saut de ligne (entree)
*/
    char carac = 0;

    carac = getchar();
    carac = toupper(carac);

    while (getchar() != '\n')
        ;
    return carac;
}

int isWinner(int letterFinded[], long lenWord)
{/* fonction qui permet de savoir si le mot à été deviné en
scannant le tableau  letterFinded 

@letterFinded : tableau de 0 et 1
@lenword : longueur du mot à deviner

*/
    long i = 0;
    int playerisWinner = 1;

    for (i = 0; i < lenWord; i++)
    {
        if (letterFinded[i] == 0)
        {
            playerisWinner = 0;
        }
    }
    return playerisWinner;
}

int searchLetter(char letter, char secretWord[], int letterFinded[])
{ /*
    Fonction qui permet de vérifier que la lettre est dans le mot à deviner
    @letter: input de l'user
    @secretWord: mot à deviner
    @letterFinded: tableau de boolean
*/
    long i = 0;
    int letterIsOk = 0;
    for (i = 0; secretWord[i] != '\0'; i++)
    {

        if (letter == toupper(secretWord[i]))
        {
            letterIsOk = 1;
            letterFinded[i] = 1;
        }
    }

    return letterIsOk;
}

int randomInt(int max)
{
    // fonction qui retourne un nombre aléatoire avec comme borne Max
    // @max: borne max pour le choix du nombre aléatoire
    srand(time(NULL));
    return (rand() % max);
}

int piocherMot(char *motPioche)
{/* Fonction qui permet de mettre dans motPioche un mot issu d'un fichier texte
    @motpioche: un tableau de char qui va contenir le mot à deviner
*/

    FILE *dico = NULL; 
    int nombreMots = 0, numMotChoisi = 0, i = 0;
    int caractereLu = 0;
    dico = fopen("dictionnairesMots.txt", "r"); // On ouvre le dictionnaire en lecture seule

    // On vérifie si on a réussi à ouvrir le dictionnaire
    if (dico == NULL) // Si on n'a PAS réussi à ouvrir le fichier
    {
        printf("\nImpossible de charger le dictionnaire de mots");
        return 0; // On retourne 0 pour indiquer que la fonction a échoué
        // À la lecture du return, la fonction s'arrête immédiatement.
    }

    // On compte le nombre de mots dans le fichier (il suffit de compter les
    // entrées \n
    do
    {
        caractereLu = fgetc(dico);
        if (caractereLu == '\n')
            nombreMots++;
    } while (caractereLu != EOF);

    numMotChoisi = randomInt(nombreMots); // On pioche un mot au hasard

    // On recommence à lire le fichier depuis le début. On s'arrête lorsqu'on est arrivé au bon mot
    rewind(dico);
    while (numMotChoisi > 0)
    {
        caractereLu = fgetc(dico);
        if (caractereLu == '\n')
            numMotChoisi--;
    }

    /* Le curseur du fichier est positionné au bon endroit.
    On n'a plus qu'à faire un fgets qui lira la ligne */
    fgets(motPioche, 100, dico);

    // On vire le \n à la fin
    motPioche[strlen(motPioche) - 1] = '\0';
    fclose(dico);

    return 1; // Tout s'est bien passé, on retourne 1
}
