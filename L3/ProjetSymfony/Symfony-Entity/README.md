# Symfony
-----------READ ME---------------------------------------
-----ETAPE 1: INSTALLATION DE PHP 7 --------------------------------------------
--------------------------------------------------------------------------------
Placer le répertoire de l’application dans opt/lampp/htdocs.
Dans un premier temps il faut installer php 7 avec la commande suivante :
>>> sudo apt-get install php7.0 php7.0-fpm php7.0-mysql -y
--------------------------------------------------------------------------------
-----ETAPE 2: INSTALLATION DE COMPOSER------------------------------------------
--------------------------------------------------------------------------------
Puis il faut installer composer pour installer les composants nécessaires à l’application :
Pour installer composer , ouvrez un terminal et tapez les lignes suivantes :
>>>curl -sS https://getcomposer.org/installer | php
>>> sudo mv composer.phar /usr/local/bin/composer.phar
Ensuite créer un alias :
>>>gedit ~/.bashrc
Ajouter la ligne suivante à la fin du fichier composer.phar  :
alias composer='/usr/local/bin/composer.phar'
Ensuite retourner dans le terminal et taper:
>>>. ~/.bashrc

On peut désormais avoir accès à la commande $composer, qui va nous servir pour installer les dépendances.

--------------------------------------------------------------------------------
-----ETAPE 3: INSTALLATION DE L'APPLICATION------------------------------------------
--------------------------------------------------------------------------------

Dans un premier temps il faut renseigner le fichier parameters.yml qui se trouve sous le chemin suivant : 
                     >>>nom_répertoire_application/app/config

il faut renseigner les accès à la base de données et le mail utilisateur qui est nécessaire pour FOSuserbundle.
On va désormais créer la base données en se place dans nom_répertoire_application/
Exécuter : 
           >>> php bin/console doctrine:schema:create --force
puis 
           >>> >>> php bin/console doctrine:schema:update --force

Enfin tapez la commande suivante sous nom_répertoire_application/ :
                                                                    >>> composer install

Replacer le FOSuserBundle dans le vendor qui vient d'être crée.

L’application est désormais accessible depuis un navigateur web en ajoutant allant sur votre serveur et ajoutant le chemin:
                            >>>nom_répertoire_application/ web/app_dev.php.
                            
Il s’agit de la route vers le controller frontal de symfony.
