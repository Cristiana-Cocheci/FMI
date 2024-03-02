myInt = 31415926535897932384626433832795028841971693993751058209749445923
double :: Integer -> Integer
double x = x+x
triple x= double x + x

multiply :: Integer->Integer -> Integer
multiply x y = x*y

maxim :: Integer -> Integer -> Integer
maxim x y = if (x > y) then x else y


max3 :: Integer-> Integer-> Integer-> Integer
max3 x y z =
    if(x>y)
        then if(x>z)
            then x
            else z
        else if(y>z)
            then y
            else z

maxim3 x y z =
    let
        u = maxim x y
    in
        maxim u z


max4:: Integer-> Integer-> Integer-> Integer-> Integer
max4 a b c d=
    let 
        u= max3 a b c 
    in 
        maxim u d

--exercitiul 1-

power x= multiply x x

sump :: Integer-> Integer-> Integer
sump x y= power x + power y

--exercitiul 2-

par :: Integer-> [Char]
par x = 
    if(mod x 2==0)
        then "par"
        else "impar"


--exc 3-
fact:: Integer->Integer
fact 1=1
fact x=fact(x-1)* x

--exc 4-


--exc 5-
maxlist:: [Integer]->Integer
maxlist []=0
maxlist (h:t) = 
    maxim h (maxlist(t))