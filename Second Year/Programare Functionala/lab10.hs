import Data.List
type Nume = String
data Prop
  = Var Nume
  | F
  | T
  | Not Prop
  | Prop :|: Prop
  | Prop :&: Prop
  | Prop :->: Prop
  | Prop :<->: Prop
  deriving Eq
infixr 2 :|:
infixr 3 :&:
infixr 3 :->:
infixr 3 :<->:

p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

p3:: Prop
p3 = undefined

instance Show Prop where
  show (Var s) = s
  show F = show False
  show T = show True
  show (Not p) = "(~" ++ (show p) ++")"
  show (p :|: q) = "(" ++ show p ++ "|" ++ show q ++")"
  show (p :&: q) = "(" ++ show p ++ "&" ++ show q ++ ")"
  show (p :->: q) = "(" ++ show p ++ "->" ++ show q ++ ")"
  show (p :<->: q) = "(" ++ show p ++ "<->" ++ show q ++ ")"
  

test_ShowProp :: Bool
test_ShowProp = show (Not (Var "P") :&: Var "Q") == "((~P)&Q)"


----wx3
type Env = [(Nume, Bool)]

-- impureLookup :: Eq a => a -> [(a,b)] -> b
-- impureLookup a = fromJust . lookup a

maybeOR :: Maybe Bool -> Maybe Bool -> Maybe Bool
maybeOR Nothing _ = Nothing
maybeOR _ Nothing = Nothing
maybeOR (Just True) _ = Just True
maybeOR _ (Just True) = Just True
maybeOR (Just False) (Just False) = Just False

maybeAND :: Maybe Bool -> Maybe Bool -> Maybe Bool
maybeAND Nothing _ = Nothing
maybeAND _ Nothing = Nothing
maybeAND (Just False) _ = Just False
maybeAND _ (Just False) = Just False
maybeAND (Just True) (Just True) = Just True

maybeNOT :: Maybe Bool -> Maybe Bool
maybeNOT (Just True) = Just False
maybeNOT (Just False) = Just True
maybeNOT Nothing = Nothing

maybeEgal :: Maybe Bool -> Maybe Bool-> Maybe Bool
maybeEgal _ Nothing = Nothing
maybeEgal Nothing _ = Nothing
maybeEgal (Just True) (Just False) = Just False
maybeEgal (Just False) (Just True) = Just False
maybeEgal (Just True) (Just True) = Just True
maybeEgal (Just False) (Just False) = Just True

eval :: Prop -> Env -> Maybe Bool
eval T _ = Just True
eval F _ = Just False
eval (Var v) l = lookup v l 
eval (x :|: y) l = (eval x l) `maybeOR` (eval y l)
eval (x :&: y) l = (eval x l) `maybeAND` (eval y l)
eval (Not x) l = maybeNOT (eval x l) 

-- eval (Var "P" :|: Var "Q") [("P", True), ("Q", False)]

toList :: Prop -> [String]
toList (Var s) = [s]
toList F = ["F"]
toList T = ["T"]
toList (Not p) = ["~"] ++ (toList p) 
toList (p :|: q) = toList p ++ ["|"] ++ toList q 
toList (p :&: q) = toList p ++ ["&"] ++ toList q 
toList (p :->: q) = toList p ++ ["->"] ++ toList q
toList (p :<->: q) = toList p ++ ["<->"] ++ toList q

sp::[String] = ["(",")","|","~","&", "->","<->"]
removeSpecial :: [String] -> [Nume]
removeSpecial l = foldr (\c s-> if (elem c sp) then s else c:s) [] l

getvar :: Prop -> [Nume] --lista de variabile
getvar x = removeSpecial. nub .toList $ x --nub sterge duplicatele

tf::[Bool] = [True, False]

generateBinaryNumbers :: Int -> [String]
generateBinaryNumbers n
  | n < 0     = error "Length must be non-negative"
  | otherwise = map (padToLength n . intToBinary) [0 .. 2^n - 1]
  where
    intToBinary :: Int -> String
    intToBinary 0 = "0"
    intToBinary 1 = "1"
    intToBinary x = intToBinary (x `div` 2) ++ show (x `mod` 2)

    padToLength :: Int -> String -> String
    padToLength len str = replicate (len - length str) '0' ++ str

intToBool :: [Char] -> [Bool]
intToBool l = map (\b -> if (b=='0') then False else True) l

all_tf:: Int -> [[Bool]]
all_tf n = [intToBool i | i <- generateBinaryNumbers n ]

envs::[Nume] -> [Env]
envs x = [zip x i | i <- all_tf.length $ x]

satisfiabila :: Prop -> Maybe Bool
satisfiabila p = foldr (\l b-> (eval p l) `maybeOR` b) (Just False) (envs. getvar $ p)

valida:: Prop -> Maybe Bool
valida p | satisfiabila (Not p) == (Just True) = Just False
         | otherwise = Just True

echivalenta :: Prop -> Prop -> Maybe Bool
echivalenta p q = foldr (\(l1, l2) b-> maybeAND b (maybeEgal (eval p l1) (eval q l2))) (Just True) (zip (envs. getvar $ p) (envs. getvar $ q))