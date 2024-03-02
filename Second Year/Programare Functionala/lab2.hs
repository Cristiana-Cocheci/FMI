poly :: Double-> Double-> Double->Double->Double
poly a b c x = a*x^2+b*x+c

eeny:: Int->[Char]
eeny a = 
    if(even a)
        then "eeny"
        else "meeny"

fizzbuzz:: Int->[Char]
fizzbuzz a=
    if(mod a 3 == 0)
        then if(mod a 5 == 0)
            then "FizzBuzz"
            else "Buzz"
        else if(mod a 5 == 0)
            then "Fizz"
            else ""

fizbuz a  | (mod a 3 == 0 && mod a 5 == 0) = "fb"
          | (mod a 3==0) ="b"
          | (mod a 5 == 0) = "z"
          | otherwise =""

tribonacci1 :: Integer -> Integer
tribonacci1 x  | (x==1) = 1
               | (x==2) = 1
               | (x==3) = 2
               | otherwise = tribonacci1 (x-1) +tribonacci1 (x-2) +tribonacci1 (x-3) 


tribonacci2 :: Integer -> Integer
tribonacci2 1 = 1
tribonacci2 2 = 1
tribonacci2 3 = 2
tribonacci2 x = tribonacci1 (x-1) +tribonacci1 (x-2) +tribonacci1 (x-3) 

bino :: Integer -> Integer -> Integer
bino n k | (k==0) =1
         | (n==0) =0
         | otherwise = bino (n-1) k + bino (n-1) (k-1)


verifL ::[Int] -> Bool
verifL (x : t) = even (length (x : t))

takefinal :: [Int]->Int->[Int]
takefinal (x:s) n = drop (length(x:s)-n) (x:s)

remove :: [Int] -> Int -> [Int]
remove (x:s) n = take (n-1)(x:s) ++ takefinal (x:s)(length(x:s)-n)

semiPareRec :: [Int]->[Int]
semiPareRec []=[]
semiPareRec (x:s) | (mod x 2==0)= ((div x 2) : semiPareRec(s))
                  | otherwise = semiPareRec(s)


myreplicate:: Int->a->[a]
myreplicate 1 x =[x]
myreplicate n x = myreplicate (n-1) x ++ [x]

sumImp :: [Int]->Int
sumImp [] =0
sumImp (x:s) | (mod x 2==0)= sumImp s
             | otherwise= x+ sumImp s


totalLen :: [String] -> Int
totalLen []=0
totalLen ((a:b):s) | (a=='A')= length(a:b) + totalLen s
                   | otherwise= totalLen s