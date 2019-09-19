#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "types.h"

#include "initialisation.h"
#include "deroulement.h"
#include "affichage.h"
#include "end.h"
#include "util.h"

// **********************
//  programme principal
// **********************

int main()
{
    // Affichage du jeu //
    printf("------------------------------------------------------------\nI			 Le Jeu du	   		   I\nI			TOC TOC TOC			   I\n------------------------------------------------------------\n");
    // initialisation du jeu de carte
    //******//
    int recommencer ;
    do
    {
        recommencer = 1;
        TJoueur joueurs[nbjoueur];
        for (int joueur = 0; joueur < nbjoueur; joueur++)
        {
            joueurs[joueur].id = joueur + 1;
        }
        initialisation_soiree_joueur(joueurs);
         initialisation_pioche(joueurs);
        for (int i = 0; i < nbjoueur; i++)
        {
            initialisation_main(&joueurs[i]);
        }
        int stop = 0;
        int nbtour = 1;
        while (!stop)
        {
            int j = 0;

            printf("------------------------------------------------------------\nI			 TOUR N°	   		   I\nI			   %d				   I\n------------------------------------------------------------\n", nbtour);

            while (j < nbjoueur)
            {
                afficher_pioche();
                for (int i = 0; i < nbjoueur; i++)
                {
                    afficher_soiree(joueurs[i]);
                }
                printf("\n------------------------------------------------------------\nI		     Cartes de la main du	   	   I\nI		          JOUEUR N°%d		 	   I\n------------------------------------------------------------\n", joueurs[j].id);
                affiche_main(joueurs[j]);
                proposer_carte(&joueurs[j], joueurs);
                j++;
                system("clear");
            }
            if (joueurs[0].nbCarteMain == 0)
            {
                stop = 1;
            }
            
            nbtour++;
        }
        // calcul du score et du gagnant
        
        int score[nbjoueur];
        int maxi;
        printf("test");
        for(int k=0;k<nbjoueur;k++){	
			score[k] = calcul_score(joueurs[k]);
			printf("\nLe joueur n°%d a obtenu un score de %d !!!!!\n",k+1,score[k]);

		}
		
		maxi = max(score,nbjoueur);
		int gagnant = 0;
		
		for(int k=0;k<nbjoueur;k++){	
			if(maxi== score[k])
				gagnant = k;
		}
		printf("\nLe joueur gagnant est le joueur n°%d !!!!!\n",gagnant+1);

        liberer_pioche();
        char resp ;
        printf("%d ) Voulez-vous rejouer une partie ? (O/N)", recommencer);
        scanf("%c", &resp);
        if (resp != 'O' && resp != 'o')
        {
            recommencer = 0;
        }
    } while (recommencer == 1);
}
