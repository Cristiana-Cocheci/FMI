data Fruct = Mar String Bool
          | Portocala String Int

cosFructe = [Mar "Ionatan" False,
            Portocala "Sanguinello" 10,
            Portocala "Valencia" 22,
            Mar "Golden Delicious" True,
            Portocala "Sanguinello" 15,
            Portocala "Moro" 12,
            Portocala "Tarocco" 3,
            Portocala "Moro" 12,
            Portocala "Valencia" 2,
            Mar "Golden Delicious" False,
            Mar "Golden" False,
            Mar "Golden" True]

ePortocalaDeSicilia :: Fruct ->Bool
ePortocalaDeSicilia (Mar _ _) = False
ePortocalaDeSicilia (Portocala t _) | (t=="Tarocco")=True
                                    | (t=="Moro")=True
                                    | (t=="Sanguinello")=True
                                    | otherwise = False

nrFeliiSicilia :: [Fruct]->Int
--nrFeliiSicilia l= sum(map(\(Portocala _ x)->x)(filter ePortocalaDeSicilia l))
nrFeliiSicilia  = sum . map (\(Portocala _ x)->x) . filter ePortocalaDeSicilia 
--nrFeliiSicilia l = sum $ map (\(Portocala _ x)->x) $ filter ePortocalaDeSicilia l

marViermi :: Fruct -> Bool
marViermi (Portocala _ _)=False
marViermi (Mar _ x) | (x==True) = True
                    | otherwise = False

nrMereViermi ::[Fruct]->Int
nrMereViermi = length . filter marViermi

-----------------------------------------------------------------

type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa
            deriving Show

main :: IO ()
main = do
    let mimi = Pisica "Mimi"
    let rex = Caine "Rex" "German Shepherd"
    putStrLn $ show mimi
    putStrLn $ show rex

vorbeste :: Animal -> String
vorbeste (Pisica _)="Meow!"
vorbeste (Caine _ _)= "Woof!"

rasa:: Animal -> Maybe String
rasa (Pisica _)=Nothing
rasa (Caine _ r)= Just r


----------------------------
data Linie = L [Int]
        deriving Show
data Matrice = M [Linie]
        deriving Show

verifica :: Matrice -> Int -> Bool
verifica (M list) n = foldr (\(L li) boo-> boo && ((sum li) ==n)) True list

doarPozN :: Matrice -> Int -> Bool
doarPozN (M list) n = foldr (\(L li) boo -> boo && (length li == (length $ filter (>0) li))) True $ filter (\(L li)-> if((length li)==n) then True else False) list

corect :: Matrice -> Bool
corect (M ((L h):t)) = foldr (\(L li) boo -> boo && ((length h) == length li)) True t 

---------------------------------------------------------------------------------------------
data PunctCardinal = Nord | Sud | Est | Vest 
                deriving Show
data Pozitie = Poz (Int,Int)
            deriving Show
data Turtle = Trt Pozitie PunctCardinal
                deriving Show

data Action = Step | Turn
data Command = Do Action | Repeat Action Int

doAction:: Turtle -> Action -> Turtle
doAction (Trt (Poz (i,j)) Nord) Step  = Trt (Poz (i-1, j)) Nord
doAction (Trt (Poz (i,j)) Sud) Step  = Trt (Poz (i+1, j)) Sud
doAction (Trt (Poz (i,j)) Est) Step  = Trt (Poz (i, j+1)) Est
doAction (Trt (Poz (i,j)) Vest) Step  = Trt (Poz (i, j-1)) Vest

doAction (Trt poz Nord) Turn = Trt poz (Est)
doAction (Trt poz Sud) Turn = Trt poz (Vest)
doAction (Trt poz Est) Turn = Trt poz (Sud)
doAction (Trt poz Vest) Turn = Trt poz (Nord)
                              
                               

getPizza:: Turtle -> [Command] -> Pozitie
getPizza (Trt p pc) []= p
getPizza trtl ((Do act):tail) = getPizza (doAction trtl act) tail
getPizza trtl ((Repeat act 1): tail) = getPizza (doAction trtl act) tail
getPizza trtl ((Repeat act n): tail) = getPizza (doAction trtl act) ([(Repeat act (n-1))]++tail)


--getPizza (Trt (Poz (1,1)) Est) [Do(Step), Do(Step), Repeat Turn 2, Repeat Step 5]