#ifndef DEROULEMENT_H
#define DEROULEMENT_H

char readChar();
int isWinner(int letterFinded[], long lenWord);
int searchLetter(char letter, char secretWord[], int letterFinded[]);
void checkEndGame(int *letterFinded,  int lenWord, char secretWord[]);
int pickWord(char *motAdeviner);
int randomInt(int max);
int piocherMot(char *motPioche);
#endif