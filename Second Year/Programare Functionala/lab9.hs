data Tree = Empty -- arbore vid
    | Node Int Tree Tree Tree -- arbore cu valoare de tip Int in radacina
    deriving Show
-- si 3 fii

  --extree :: Tree
--extree = Node 4 (Node 5 Empty Empty Empty)(Node 3 Empty Empty (Node 1 Empty Empty Empty)) Empty

class ArbInfo t where
    level :: t -> Int -- intoarce inaltimea arborelui;
                      -- consideram ca un arbore vid are inaltimea 0
    sumval :: t -> Int -- intoarce suma valorilor din arbore
    nrFrunze :: t -> Int -- intoarce nr de frunze al arborelui

maxim::Int-> Int-> Int-> Int
maxim a b c = max (max a b) c

instance ArbInfo Tree where
    level Empty = 0
    level (Node _ a b c) = 1+ maxim (level a) (level b) (level c)

    sumval Empty = 0
    sumval (Node x a b c) = x+ sumval a + sumval b + sumval c

    nrFrunze Empty =0
    nrFrunze (Node _ Empty Empty Empty) = 1
    nrFrunze (Node _ a  b c) = nrFrunze a + nrFrunze b + nrFrunze c


class (Num a)=>Scalar a where
    zero :: a
    one :: a
    adds :: a -> a -> a
    mult :: a -> a -> a
    negates :: a -> a
    recips :: a -> a

instance Scalar Int where
    zero = 0
    one = 1
    adds a b = a+b 
    mult a b = a*b 
    negates a = -1*a 
    recips a = 0 
instance Scalar Float where
    zero = 0
    one = 1
    adds a b = a+b 
    mult a b = a*b 
    negates a = -1*a 
    recips a = 1/a 

data Bidimensional a = Bidimensional a a deriving Show 
data Tridimensional a = Tridimensional a a a deriving Show

class (Scalar a) => Vector v a where
    zerov :: v a
    onev :: v a
    addv :: v a -> v a -> v a -- adunare vector
    smult :: a -> v a -> v a -- inmultire cu scalare
    negatev :: v a -> v a -- negare vector


instance (Scalar a) => Vector Bidimensional a where
    zerov = (Bidimensional 0 0)
    onev = (Bidimensional 1 1)
    addv (Bidimensional a b) (Bidimensional c d) = Bidimensional (a+c) (b+d)
    smult x (Bidimensional a b) = Bidimensional (x*a) (x*b)
    negatev (Bidimensional a b) = Bidimensional (-a) (-b)

instance (Scalar a) => Vector Tridimensional a where
    zerov = (Tridimensional 0 0 0)
    onev = (Tridimensional 1 1 1)
    addv (Tridimensional a b c) (Tridimensional d e f) = Tridimensional (a+d) (b+e) (c+f)
    smult x (Tridimensional a b c) = Tridimensional (x*a) (x*b) (x*c)
    negatev (Tridimensional a b c) = Tridimensional (-a) (-b) (-c)
