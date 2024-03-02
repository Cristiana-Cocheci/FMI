factori:: Int -> [Int]
factori x = [a | a<-[1..x], mod x a ==0]

prim:: Int -> Bool
prim 1 = False
prim x | (length (factori x)) ==2 = True
       | otherwise = False

numerePrime :: Int -> [Int]
numerePrime x= [a | a<-[2..x], prim a == True]

myzip3 :: [Int]->[Int]->[Int]->[(Int,Int,Int)]
myzip3 [] a b = []
myzip3 a [] b = []
myzip3 a b [] = []
myzip3 (a:b) (c:d) (e:f) = [(a,c,e)] ++ myzip3 b d f

firstEl::[(a,b)]->[a]
firstEl l = map(\(a,b)->a)l

sumList::[[Int]]->[Int]
sumList l= map(sum)l

f::Int->Int
f x | mod x 2==0 = div x 2 
    | otherwise =2*x

prel2::[Int]->[Int]
prel2 l= map(f)l

f9::Char->[String]->[String]
f9 c l = filter (elem c)l

f10::[Int]->[Int]
f10 l = map (\x->x*x)(filter odd l)

indiceImp::(Int,Int)->Bool
indiceImp (a,b) | a `mod` 2 ==0 =False
                | otherwise= True

f11::[Int]->[Int]
f11 l = map (\x->x*x) (map((\(a,b)->b))(filter (indiceImp) (zip [1..]l)))

fvoc::String->String
fvoc c = filter(`elem` ['a','e','i','o','u'])c

numaiVocale::[String]->[String]
numaiVocale l = map (\cuv -> filter(`elem` ['a','e','i','o','u', 'A','E','I','O','U'])cuv) l

mymap:: (a->b)->[a]->[b]
mymap f []=[]
mymap f (x:s)= [f x]++mymap f s

myfilter:: (a->Bool)->[a]->[a]
myfilter f []=[]
myfilter f (x:s)| f x ==True = [x]++myfilter f s
                | otherwise = myfilter f s





--joc de x si 0
este_gol::(Int,String)->Bool
este_gol (a,b) | b=="gol" = True
             |otherwise=False

lista_pozitii_goale::[String]->[Int]
lista_pozitii_goale l= map(\(a,b)->a)(filter(este_gol)(zip [1..]l))

modifica_pozitie::String->Int->[(Int,String)]->[String]
modifica_pozitie x poz []=[]
modifica_pozitie x poz ((i,a):b) | i==poz = [x]++modifica_pozitie x poz b 
                                 | otherwise = [a]++modifica_pozitie x poz b 

step::String->[String]->[[String]] --0==gol, 1==x, 2==0
step x l = [modifica_pozitie x poz (zip [1..]l)| poz<-lista_pozitii_goale l]

next::String->[[String]]->[[String]]
next x ll = concat (map(step x) ll)


pozitii_x::String->[(Int,String)]->[Int]
pozitii_x x []=[]
pozitii_x x ((i,a):b) | x==a = [i]++ pozitii_x x b 
                      | otherwise = pozitii_x x b

--winners [[1,2,3],[4,5,6],[7,8,9],[1,5,9],[3,5,7]]
-- ["X","0","X","gol","0","0","0","gol","X"]
-- ["gol","gol","gol","gol","gol","gol","gol","gol","gol"]

include::[Int]->[Int]->Int
include l1 l2 | [x `elem` l2| x<-l1]==[True,True,True] = 1
              | otherwise =0

winner::String->[String]->Bool
winner x l | sum [include a (pozitii_x x (zip [1..]l))| a<-[[1,2,3],[4,5,6],[7,8,9],[1,5,9],[3,5,7]]]>0 = True
           | otherwise = False

win::String->[[String]]->[[String]]
win x ll = filter(winner x)ll

--daca configuratia e castigatoare, atunci terminam
--

full::[[String]]->Bool
full (a:s)| lista_pozitii_goale a==[] = True
          | otherwise =False

game::String->[[String]]->[[String]]
game x config | full config==True = win x config
              | x=="X" = game "0" (next "X" config)
              | otherwise = game "X" (next "0" config)
--[x|x<-[1..9]]
--x mod 2 ==0 -> next "0"
--otherwise -> next "X"

--final -> win "X" config 
    