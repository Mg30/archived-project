#include <stdio.h>
#include <stdlib.h>
#include "pendu.c"

int main()
{
    char letter = 0; // variable qui va contenir l'input user
    char secretWord[100] = {0}; // talbleau qui va contenir le mot secret
    int *letterFinded = NULL; // variable qui stocke le tableau de boolean réprésentant le mot à deviner
    int i = 0;
    int lenWord = 0; // longueur du mot à deviner
    int left = 10; // nombre de coups

//************DEBUT DU PROGRAMME*************************

    if (!piocherMot(secretWord))
        exit(0);
    lenWord = strlen(secretWord)-1;
     printf("%d",lenWord);
    letterFinded = malloc(lenWord * sizeof(int));
    
    if (letterFinded == NULL)
        exit(0);

    for (i = 0; i < lenWord; i++)
        letterFinded[i] = 0;

    while (left > 0 && !isWinner(letterFinded, lenWord))
    {
        printf("\n\nPlus que  %d coups", left);
        printf("\nDevinez le mot ? ");

        for (i = 0; i < lenWord; i++)
        {
            if (letterFinded[i])
                printf("%c", secretWord[i]);
            else
                printf("*");
        }

        printf("\nEntrer une lettre : ");
        letter = readChar();
        if (!searchLetter(letter, secretWord, letterFinded))
        {
            left--;
        }
    }

    if (isWinner(letterFinded, lenWord))
        printf("\n\nisWinner ! Le mot secret etait bien : %s", secretWord);
    else
        printf("\n\nPerdu ! Le mot secret etait : %s", secretWord);

    free(letterFinded);

    return 0;
}