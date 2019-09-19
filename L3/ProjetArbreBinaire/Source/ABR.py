class Noeud(object):
    """Classe qui représente un noeud de l'arbre"""

    def __init__(self, data):
        """Constructeur de la classe noeud"""
        self.data = data
        self.sag = None
        self.sad = None

    def insert(self, data):
        ''' Insertion d'une valeur dans l 'arbre '''
        if self.data == data:
            return False
        elif data < self.data:
            ''' la valeur est plus petite on place la valeur a gauche '''
            if self.sag:
                return self.sag.insert(data)
            else:
                self.sag = Noeud(data)
                return True

        else:
            ''' La valeur est plus grande on la place à droite '''
            if self.sad:
                return self.sad.insert(data)
            else:
                self.sad = Noeud(data)
        return True

    def minValue(self, Noeud):
        """Permet de trouver la valeur la plus petite donc la plus à gauche"""
        current = Noeud
        while current.sag is not None:
            current = current.sag
        return current


    def delete(self, data):
        ''' permet de supprimer une valeur '''
        if self is None:
            return None
        #Si la valeur est plus petite on recherche à gauche sinn à droite
        if data < self.data:
            self.sag = self.sag.delete(data)
        elif data > self.data:
            self.sad = self.sad.delete(data)
        else:
                # suppression de l'abr avec un seul noeud
            if self.sag is None:
                temp = self.sad
                self = None
                return temp
            elif self.sad is None:
                temp = self.sag
                self = None
                return temp
                #Avec deux noeuds
            temp = self.minValue(self.sad)
            self.data = temp.data
            self.sad = self.sad.delete(temp.data)
        return self


    def preorder(self):
        '''Parcours prefixe de l'arbre binaire '''
        if self:
            print(str(self.data), end = ' ')
            if self.sag:
                self.sag.preorder()
            if self.sad:
                self.sad.preorder()

    def preorderWrite(self,liste,level):
        '''cree une list de l'ensemble des valeurs avec formatage pour ecriture '''
        if self:
            liste.append(self.data)
            if self.sag:
                self.sag.preorderWrite(liste,level)

            if self.sad:
                self.sad.preorderWrite(liste,level)

    def preorderTolist(self, liste):
        '''cree une list de l'ensemble des valeurs '''
        if self:
            liste.append(self.data)
            if self.sag:
                self.sag.preorderTolist(liste)
            if self.sad:
                self.sad.preorderTolist(liste)

    def find(self, data):
        ''' Fonction de recherche '''
        if (data == self.data):
            return True
        elif (data < self.data):
            if self.sag:
                return self.sag.find(data)
            else:
                return False
        else:
            if self.sad:
                return self.sad.find(data)
            else:
                return False

class Tree(object):
    """Classe qui implemente une arbre binaire de recherche et qui est composé d'instance de la
     classe noeuds"""
    def __init__(self):
        self.root = None

    def insert(self, data):
        if self.root:
            return self.root.insert(data)
        else:
            self.root = Noeud(data)
            return True

    def delete(self, data):
        if self.root is not None:
            return self.root.delete(data)

    def find(self, data):
        if self.root:
            return self.root.find(data)
        else:
            return False

    def preorder(self):
        if self.root is not None:
            print()
            print('Preorder: ')
            self.root.preorder()

    def preorderTolist(self, liste):
        if self.root is not None:
            self.root.preorderTolist(liste)

    def preorderWrite(self, liste,level):
        if self.root is not None:
            self.root.preorderWrite(liste,level)