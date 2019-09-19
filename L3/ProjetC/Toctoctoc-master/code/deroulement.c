#include "deroulement.h"
//////////////////////deroulement du jeu /////////////////
void revelation_carte(TJoueur *joueur_actif, TJoueur *joueur_cible, TCarte carte)
{

    int sansEffet = 1;
    int presBrute[3] = {0, 0, 0}; // booleen pour chaque classe

    if (!estCarteEffet(carte))
    {
        joueur_cible->soiree[carte.classe].cartes[carte.type]++; //ajout
    }
    else
    {
        switch (carte.type)
        {
        case VAMP:         // vamp (vol d'une carte)
            sansEffet = 1; // booleen pour indiquer s'il existe une carte à voler
            for (int i = 0; i < 3; i++)
            {
                if (joueur_cible->soiree[carte.classe].cartes[i] > 0)
                {
                    sansEffet = 0;
                    break;
                }
            }

            if (!sansEffet)
            {
                int type;
                int valide = 0;
                do
                {
                    printf("\n /!\\ Au joueur n°%d de faire son choix\n", joueur_actif->id);
                    type = appliquerEffet(carte); // penser à choisir un type parmi la même classe que la vamp.

                    if (joueur_cible->soiree[carte.classe].cartes[type] > 0)
                    {

                        joueur_cible->soiree[carte.classe].cartes[type]--; //retrait
                        joueur_actif->soiree[carte.classe].cartes[type]++; // ajout

                        valide = 1;
                    }
                    else
                    {
                        printf("La carte n'existe pas.\n");
                    }

                } while (!valide);
                printf("Le joueur %d vole la carte ", joueur_actif->id);
                nomType(type);
                printf(" du joueur %d !\n", joueur_cible->id);
            }
            else
            {
                printf("Aucune carte à voler pour la classe ");
                nomClasse(carte.classe);
                printf(" de la vamp , la carte est sans effet.\n");
            }

            break;

        case ENFANT: // enfant (vol de la classe)

            //////////////// en cours //////////////////////////
            for (int i = 0; i < 3; i++) // pour chaque classe de la soirée on verifie s'il y a une brute
            {
                if (!presenceBrute(*joueur_cible, i))
                {
                    sansEffet = 0;
                }
                else
                {
                    presBrute[i] = 1;
                }
            }
            if (sansEffet) // s'il y a des brutes dans toutes les classes, la carte est sans effet
            {
                printf("Les brutes empêchent l'effet de la carte ");
                nomType(carte.type);
                printf("\n");
            }
            else // sinon on continue les tests
            {
                /////////////// en cours ////////////////////////
                int cptInvites[3]; // le nombre d'invite par classe sera stocké dans cette variable
                for (int i = 0; i < 3; i++)
                {
                    if (presenceBrute(*joueur_cible, i))
                    {
                        cptInvites[i] = -1; // pas de choix possible
                    }
                    else
                    {
                        cptInvites[i] = compteInvitesParClasse(*joueur_cible, i);
                    }
                }
                int maxi = max(cptInvites, 3);

                if (maxi == 0) // Pas d'invites à voler
                {
                    printf("Il n'y a pas d'invités qu'il est possible de faire fuire !\n");
                }
                else
                {
                    int nbChoix = 0;
                    int choix;
                    for (int i = 0; i < 3; i++)
                    {

                        if (cptInvites[i] == maxi && !presBrute[i])
                        {
                            nbChoix++;
                        }
                    }
                    printf("nbChoix : %d \n", nbChoix);
                    if (nbChoix > 1) // s'il y a deux au moins deux choix possible
                    {
                        printf("\n /!\\ Au joueur n°%d de faire son choix\n", joueur_actif->id);

                        printf("Saisir la classe que vous souhaitez voler parmi :\n");
                        for (int i = 0; i < 3; i++)
                        {

                            if (cptInvites[i] == maxi && !presBrute[i])
                            {
                                printf("%d - ", i);
                                nomClasse(i);
                                printf("\n");
                            }
                        }
                        do
                        {
                            printf("classe ? :");
                            scanf("%d", &choix);
                            getchar();                                              // pour eviter les boucles infinis
                        } while (cptInvites[choix] <= 0 || choix < 0 || choix > 2); // tant que c'est pas un choix valide on redemande
                    }
                    else if (nbChoix == 1) // choix de classe unique, c'est le système qui décide
                    {

                        for (int i = 0; i < 3; i++)
                        {
                            if (cptInvites[i] > 0)
                            {
                                choix = i;

                                break;
                            }
                        }
                    }
                    else
                    {
                        printf("Il n'y a pas d'invités qu'il est possible de faire fuire !\n");
                    }
                    // le choix de la classe est fait, plus qu'a supprimer et ajouter les invites
                    int nbCarte = 0;
                    for (int i = 0; i < 3; i++)
                    {
                        // ajout des cartes du joueur cible dans le joueur actif
                        nbCarte = joueur_cible->soiree[choix].cartes[i];

                        joueur_cible->soiree[choix].cartes[i] -= joueur_cible->soiree[choix].cartes[i];
                        joueur_actif->soiree[choix].cartes[i] += nbCarte;
                    }
                }
            }
            break;
        case TAXI:
            //////////////// en cours //////////////////////////
            for (int i = 0; i < 3; i++) // pour chaque classe de la soirée on verifie s'il y a une brute
            {
                if (!presenceBrute(*joueur_cible, i))
                {
                    sansEffet = 0;
                }
                else
                {
                    presBrute[i] = 1;
                }
            }
            if (sansEffet) // s'il y a des brutes dans toutes les classes, la carte est sans effet
            {
                printf("Les brutes empêchent l'effet de la carte ");
                nomType(carte.type);
                printf("\n");
            }
            else // sinon on continue les tests
            {

                int cptInvites[3]; // le nombre d'invite par classe sera stocké dans cette variable
                for (int i = 0; i < 3; i++)
                {
                    if (presenceBrute(*joueur_cible, i))
                    {
                        cptInvites[i] = -1; // pas de choix possible
                    }
                    else
                    {
                        cptInvites[i] = compteInvitesParClasse(*joueur_cible, i);
                    }
                }
                int maxi = max(cptInvites, 3);
                if (maxi == 0) // Pas d'invites à voler
                {
                    printf("Il n'y a pas d'invités qu'il est possible de faire fuire !\n");
                }
                else
                {
                    int nbChoix = 0;
                    int choix;
                    for (int i = 0; i < 3; i++)
                    {

                        if (cptInvites[i] == maxi && !presBrute[i])
                        {
                            nbChoix++;
                        }
                    }
                    if (nbChoix > 1) // s'il y a deux au moins deux choix possible
                    {
                        printf("\n /!\\ Au joueur n°%d de faire son choix\n", joueur_actif->id);

                        printf("Saisir la classe que vous souhaitez retirer parmi :\n");
                        for (int i = 0; i < 3; i++)
                        {
                            if (cptInvites[i] == maxi && !presBrute[i])
                            {
                                printf("%d - ", i);
                                nomClasse(i);
                                printf("\n");
                            }
                        }
                        do
                        {
                            printf("classe ? :");
                            scanf("%d", &choix);
                            getchar();                                              // pour eviter les boucles infinis
                        } while (cptInvites[choix] <= 0 || choix < 0 || choix > 2); // tant que c'est pas un choix valide on redemande
                    }
                    else if (nbChoix == 1) // choix de classe unique, c'est le systeme qui décide
                    {

                        for (int i = 0; i < 3; i++)
                        {
                            if (cptInvites[i] > 0)
                            {
                                choix = i;

                                break;
                            }
                        }
                    }
                    else
                    {
                        printf("Il n'y a pas d'invités qu'il est possible de faire fuire !\n");
                    }
                    // le choix de la classe est fait, plus qu'à supprimer les invites
                    for (int i = 0; i < 3; i++)
                    {

                        // supression des cartes de la soirée dans joueur cible.
                        joueur_cible->soiree[choix].cartes[i] = 0;
                    }
                }
            }

            break;
        }
    }

    ////// supprimer la carte de la main du joueur à la fin ////////
}
int presenceBrute(TJoueur joueur, int classe)
{
    // verifie s'il y a une brute dans la soirée du joueur et de classe donnée en paramètre

    int present = 0;
    for (int i = 0; i < 4; i++)
    {
        if (joueur.soiree[classe].cartes[BRUTE] > 0)
        {
            present = 1;
            break;
        }
    }
    return present;
}

int compteInvitesParClasse(TJoueur joueur, int classe)
{
    // compte les invites de la classe du joueur en paramètre

    int cpt = 0;
    for (int i = 0; i < 4; i++)
    {

        cpt += joueur.soiree[classe].cartes[i];
    }
    return cpt;
}

int estCarteEffet(TCarte carte)
{
    // fonction qui retourne vrai (1) si c'est une carte à effet et faux sinon (0)
    return carte.type == 4 || carte.type == 5 || carte.type == 6;
}

int appliquerEffet(TCarte carte)
{
    // fonction qui retourne la classe ou le type de la carte choisi (varie selon la carte retournée);

    int choix;
    //index  0 pour classe et 1 pour type
    if (carte.type == VAMP)
    { // vamp

        printf("*** Saisir le type que vous souhaitez voler *** \n");
        do
        {
            for (int c = 0; c < 3; c++)
            {
                printf("%d - ", c);
                nomType(c);
                printf("\n");
            }
            printf("type [0-2] :");
            scanf("%d", &choix);
            getchar();                    // pour eviter les boucles infinis
        } while (choix < 0 || choix > 2); // le joueur ne peut choisir que des normaux, brutes ou musiciens.
        return choix;
    }
    else
    { // enfant ou taxi
        printf("*** Saisir la classe que vous souhaitez ");
        if (carte.type == ENFANT)
            printf("voler *** \n");
        else
            printf("retirer *** \n");
        do
        {
            printf("classe ? :");
            scanf("%d", &choix);
            getchar();                    // pour eviter les boucles infinis
        } while (choix < 0 && choix > 2); // le joueur ne peut pas choisir la spéciale
                                          // type vide
        return choix;
    }
}
void choix_carte(TJoueur joueur, int *indice, TCarte *carte)
{
    //Fonction qui permet au joueur passé en paramètre de choisir une carte, renvoi une carte

    //lexique local :
    // Carte permet de stocker la carte choisie

    // Choix permet de stocker le choix du joueur, permet de retrouver la carte dans le tableau.
    int choix = 0;

    //début:
    //Boucle de contrôle de saisie
    do
    {
        //Demande du numéro de carte
        printf("\nQuelle carte voulez vous lui proposer : \n");
        //On affiche la main pour que le joueur puisse faire son choix
        //affiche_main(joueur);
        printf("Choix [1-5]: ");
        scanf("%d", &choix);
        getchar(); // pour eviter les boucles infinis
    } while (choix > 5 || choix < 1 || joueur.carteMain[choix - 1].type == -1);

    *carte = joueur.carteMain[choix - 1];

    *indice = choix - 1; // indice du tableau
}

int reponse_carte(int joueurActif, int joueurVise)
{

    int choix = 0;
    char reponse;

    do
    {
        printf("TocTocToc, joueur %d , le joueur %d vous propose une carte acceptez vous O/N ? ", joueurVise, joueurActif);

        scanf(" %c", &reponse);

    } while (reponse != 'O' && reponse != 'o' && reponse != 'N' && reponse != 'n');

    if (reponse == 'O' || reponse == 'o')
    {
        choix = 1;
    }

    return choix;
}

TJoueur choix_joueur(TJoueur tabjoueur[], int idjoueuractif)
{
    //Permet au joueur actif de choisir un joueur en vu de lui proposer une carte

    int choix;
    do
    {
        printf("Joueur %d, A quel joueur voulez vous proposez une carte parmi   : \n", idjoueuractif);

        for (int i = 0; i < 3; i++)
        {
            if (tabjoueur[i].id != idjoueuractif)
            {
                printf("Joueur n° %d \n", tabjoueur[i].id);
            }
        }
        printf("Choix [1-3]: ");
        scanf("%d", &choix);
        getchar(); // pour eviter les boucles infinis

    } while ((choix < 1 || choix > 3) || choix == idjoueuractif);

    return tabjoueur[choix - 1];
}

void proposer_carte(TJoueur *joueurActif, TJoueur joueurs[])
{
    // Permet au joueur actif de proposer une carte
    // Cette procédure regroupe plusieurs procédures
    TJoueur joueurVise;
    TCarte carteChoisie;
    int reponse = 0;
    int indiceCarte = 0;

    int piochePossible = 0;

    joueurVise = choix_joueur(joueurs, joueurActif->id);
    printf("Le joueur vise est le joueur %d \n", joueurVise.id);
    choix_carte(*joueurActif, &indiceCarte, &carteChoisie);

    reponse = reponse_carte(joueurActif->id, joueurVise.id);
    printf("\n");
    if (reponse == 1) // le joueur vise devient le joueur cible
    {
        revelation_carte(joueurActif, &joueurVise, carteChoisie);
        joueurs[joueurVise.id - 1] = joueurVise;
    }
    else // le joueurActif devient le joueur cible
    {
        revelation_carte(&joueurs[joueurVise.id - 1], joueurActif, carteChoisie);
    }
    // nomType(carteChoisie.type);
    // nomClasse(carteChoisie.classe);

    // printf("Cartchoisi type : %d", carteChoisie.type);
    piocher(&carteChoisie, &piochePossible);

    if (piochePossible)
    {
        joueurActif->carteMain[indiceCarte] = carteChoisie;
    }
    else
    {
        joueurActif->carteMain[indiceCarte].type = -1;
        joueurActif->carteMain[indiceCarte].classe = -1;
        joueurActif->nbCarteMain--;
    }
}