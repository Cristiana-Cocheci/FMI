import Data.Char

--1
palindrom :: String -> Bool
palindrom x | (x== reverse x) = True
            | otherwise = False

cntVoc :: [Char] -> Int
cntVoc []=0
cntVoc (a:b) | (elem a ['a', 'e', 'i', 'o', 'u'] == True) = 1 + cntVoc b
             | otherwise = cntVoc b

nrVocale :: [String] -> Int
nrVocale [] =0
nrVocale (a:b) | (palindrom a == True)= cntVoc a + nrVocale b
               | otherwise = nrVocale b

--2
repet :: Int -> [Int]-> [Int]
repet x []=[]
repet x (h:t) | (mod h 2 ==0) = [h]++[x]++repet x t
              | otherwise = [h]++repet x t

repfl :: Int -> [Int]-> [Int]
repfl x l = foldr (\int ls -> [int,x]++ls) [] l
--3
divizori :: Int->[Int]
divizori n = [i | i <- [1..n] , (mod n i) ==0]

--4
listadiv :: [Int] -> [[Int]]
listadiv [] =[]
listadiv (h:t) = [(divizori h)] ++ listadiv t

--5 a
inIntervalRec :: Int -> Int -> [Int] ->[Int]
inIntervalRec l r [] = []
inIntervalRec l r (h:t) | (l<= h && h<=r)= [h]++inIntervalRec l r t
                        | otherwise = inIntervalRec l r t

--5 b
inIntervalComp :: Int-> Int -> [Int] ->[Int]
inIntervalComp l r s = [x | x<-s, l<=x, r>=x]

--6 a
pozitivRec :: [Float] -> Int
pozitivRec [] = 0
pozitivRec (h:t) | (h>0) = 1 + pozitivRec t
                 | otherwise = pozitivRec t

--6 b
pozitivComp :: [Float] -> Int
pozitivComp l = sum [1 | x<-l, x>0]

--7 a
pozImp :: Int -> [Int]-> [Int]
pozImp x [] =[]
pozImp x (a:s) | (mod a 2 /=0)= [x]++pozImp (x+1) s
               | otherwise = pozImp (x+1) s

pozitiiImpareRec :: [Int] -> [Int]
pozitiiImpareRec [] =[]
pozitiiImpareRec l = pozImp 0 l

--7 b
pozitiiImpareComp :: [Int] -> [Int]
pozitiiImpareComp l = [i | (x,i)<- zip l [0..length l], mod x 2 /=0]

--8 a

multDigitsRec :: String -> Int
multDigitsRec []= 1
multDigitsRec (a:b) | (isDigit a) = (digitToInt a)* multDigitsRec b 
                    | otherwise = multDigitsRec b

--8 b
mult:: [Int]->Int
mult []=1
mult (a:b) = a* mult b

multDigitsComp ::String -> Int
multDigitsComp l = mult [digitToInt x | x<-l, isDigit x]

--Extra
--9
lista_fara_x ::[Int]->Int->[Int]
lista_fara_x [] x=[]
lista_fara_x (a:b) x | (a==x) = lista_fara_x b x 
                     | otherwise = [a]++ lista_fara_x b x 

permutare :: [Int] -> [[Int]]
permutare [] = [[]]
permutare l = [[x]++y | x<-l, y<-permutare (lista_fara_x l x)]












{-

permutare1 :: [a]->Int-> [Bool]->[a]->[[a]]->[[a]]
permutare1 [] 0 [] [] rez = rez
permutare1 (h:t) length (h:t)+1 b lista_curenta rez = permutare1 [] 0 [] [] rez++lista_curenta
permutare1 (h:t) p b lista_curenta rez = 

permutari :: [a] -> [[a]]
permutari l = permutare1 l 1 zip l [False..] []

-}