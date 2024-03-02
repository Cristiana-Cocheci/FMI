import Data.List
newtype Point = Pt [Int] deriving Show
data Arb = Empty | Node Int Arb Arb deriving Show


class ToFromArb a where
  toArb :: a -> Arb
  fromArb :: Arb -> a

normalext::Arb -> [Int]
normalext Empty =[]
normalext (Node x a b) = normalext a ++ [x] ++ normalext b

middle_of_list::[Int] -> Int
middle_of_list l = l !! (length l `div` 2)

first_half:: [Int] -> [Int]
first_half l = take ((length l `div` 2) ) l

second_half :: [Int] -> [Int]
second_half l = drop (length l `div` 2 +1) l

toArb2 :: [Int] -> Arb
toArb2 [] = Empty
toArb2 ls = Node (middle_of_list ls) (toArb2 $ first_half ls) (toArb2 $ second_half ls)

instance ToFromArb Point where
  toArb (Pt ls) = toArb2 $ sort ls
  fromArb Empty = Pt []
  fromArb (Node x a b) = Pt (normalext a ++ [x] ++ normalext b)

getFromInterval:: Int-> Int -> [Int] -> [Int]
getFromInterval a b = filter (\x-> a<=x && x<=b)

getFromInterval2 :: Ord a => a -> a -> [a] -> [a]
getFromInterval2 a b l = [x| x<-l, x>=a && x<=b]

getFromInterval3 :: Int-> Int -> [Int] -> [Int]
getFromInterval3 a b ls = do
  x <- ls
  if x >= a && x<=b then 
    return x else []

newtype ReaderWriter env a = RW {getRW :: env-> (a,String)}

instance Functor (ReaderWriter env) where
  fmap :: (a -> b) -> ReaderWriter env a -> ReaderWriter env b
  fmap f fct = RW  (\env -> let (a, log) = getRW fct env
      in (f a, log))

instance Applicative (ReaderWriter env) where
  pure :: a -> ReaderWriter env a
  pure x = RW $ \_ -> (x, "")

  (<*>) :: ReaderWriter env (a -> b)-> ReaderWriter env a -> ReaderWriter env b
  (RW f) <*> (RW x) = RW $ \env->
    let (g, log1) = f env
        (a, log2) = x env
    in (g a, log1 ++ log2)

instance Monad (ReaderWriter env) where
  return :: a -> ReaderWriter env a
  return a = RW (\_ -> (a,""))

  (>>=) :: ReaderWriter env a-> (a -> ReaderWriter env b) -> ReaderWriter env b
  (RW f) >>= k = RW $ \env->
    let (a, log1) = f env
        (RW h) = k a
        (b, log2) = h env
    in (b, log1++log2)


{-
mkmk
ma >>= k = RW f
        where f env = let (va, log1) = getRW ma env
                          (vb, log2) = getRW (k va) env
                      in (vb, log1 ++ log2)
-}

