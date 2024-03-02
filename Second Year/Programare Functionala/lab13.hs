{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use <$>" #-}

newtype Writer1 log a = Writer1 { runWriter1 :: ( a , log ) } deriving Show
f :: Int -> Writer1 String Int
f x = if x < 0 then Writer1 (-x , "negativ" )
else Writer1 ( x , "pozitiv" )

-----------------------------------------------------

{- Monada Maybe este definita in GHC.Base 

instance Monad Maybe where
  return = Just
  Just va  >>= k   = k va
  Nothing >>= _   = Nothing


instance Applicative Maybe where
  pure = return
  mf <*> ma = do
    f <- mf
    va <- ma
    return (f va)       

instance Functor Maybe where              
  fmap f ma = pure f <*> ma   
-}
pos :: Int -> Bool
pos  x = if x>=0 then True else False

fct :: Maybe Int ->  Maybe Bool
fct  mx =  mx  >>= (\x -> Just (pos x))

fct2 :: Maybe Int ->  Maybe Bool
fct2 mx = do
  x <- mx
  return (pos x)

fct3 :: Maybe Int ->  Maybe Bool
fct3 mx = do
  pos <$> mx

---------------------------------------------------------------
addM :: Maybe Int -> Maybe Int -> Maybe Int
addM mx my = (+) <$> mx <*> my

addM2 :: Maybe Int -> Maybe Int -> Maybe Int
addM2 mx my = do
  x <- mx
  y <- my
  return (x+y)

---------------------------------------------------------------------------
cartesianProduct :: Monad m => m a -> m b -> m (a, b)
cartesianProduct xs ys = xs >>= ( \x -> (ys >>= \y-> return (x,y)))
cartesianProduct2 :: Monad m => m a -> m b -> m (a, b)
cartesianProduct2 xs ys = do
  x<-xs
  y<-ys
  return (x,y)

----------------------------------------------------------------------
prod :: (t1 -> t2 -> a) -> [t1] -> [t2] -> [a]
prod f xs ys = [f x y | x <- xs, y<-ys]

prod2 :: Applicative f => (a1 -> a2 -> b) -> f a1 -> f a2 -> f b
prod2 f xs ys = f <$> xs <*> ys

prod3 :: Monad m => (t1 -> t2 -> b) -> m t1 -> m t2 -> m b
prod3 f xs ys = do
  x<-xs
  y<-ys
  return (f x y)

prod4 :: Monad m => (t1 -> t2 -> b) -> m t1 -> m t2 -> m b
prod4 f xs ys = do
  x<-xs
  f x <$> ys

--------------------------------------------------------------
myGetLine :: IO String
myGetLine = getChar >>= \x ->
      if x == '\n' then
          return []
      else
          myGetLine >>= \xs -> return (x:xs)

myGetLine2 :: IO String
myGetLine2 = do
  x<- getChar
  if x == '\n' then do
    return []
  else do
    y<-myGetLine2
    return (x:y)

----------------------------------------------------------
prelNo :: Floating a => a -> a
prelNo noin =  sqrt noin

ioNumber :: IO ()
ioNumber = do
     noin  <- readLn :: IO Float
     putStrLn $ "Intrare\n" ++ (show noin)
     let  noout = prelNo noin
     putStrLn $ "Iesire"
     print noout


ioNumber2 :: IO ()
ioNumber2 = (readLn:: IO Float) >>= \noin
      -> putStrLn ("intrare\n"++ show noin ++ "\niesire\n" ++ show (prelNo noin))

ioNumber3 :: IO ()
ioNumber3 = (readLn:: IO Float) >>= \noin-> sequence_[ putStrLn $ "Intrare\n" ++ (show noin),
     putStrLn $ "Iesire",
     let noout = prelNo noin
     in print noout]
--------------------------------------------------------------------------------------
newtype WriterS a = Writer { runWriter :: (a, String) }

instance Monad WriterS where
  return :: a -> WriterS a
  return va = Writer (va, "")

  (>>=) :: WriterS a -> (a -> WriterS b) -> WriterS b
  ma >>= k = let (va, log1) = runWriter ma
                 (vb, log2) = runWriter (k va)
             in  Writer (vb, log1 ++ log2)


instance Applicative WriterS where
  pure :: a -> WriterS a
  pure = return
  
  (<*>) :: WriterS (a -> b) -> WriterS a -> WriterS b
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

instance Functor WriterS where
  fmap :: (a -> b) -> WriterS a -> WriterS b
  fmap f ma = pure f <*> ma

tell :: String -> WriterS ()
tell log = Writer ((), log)

logIncrement :: Int  -> WriterS Int
-- logIncrement = undefined
logIncrement x = do 
  tell ("inc: "++show x++ "--")
  return (x+1)

logIncrementN :: Int -> Int -> WriterS Int
logIncrementN x 0 = return x
logIncrementN x n = do
  y<- logIncrement x
  logIncrementN y (n-1)
-------------------------------------------------------------------------------------
data Person = Person { name :: String, age :: Int }

showPersonN :: Person -> String
showPersonN (Person{name = a, age = b}) = "NAME: "++ a
showPersonA :: Person -> String
showPersonA (Person{name = a, age = b}) = "AGE: "++ show b

{-
showPersonN $ Person "ada" 20
"NAME: ada"
showPersonA $ Person "ada" 20
"AGE: 20"
-}

showPerson :: Person -> String
showPerson p = "("++ showPersonN p ++ ", " ++ showPersonA p ++")"

{-
showPerson $ Person "ada" 20
"(NAME: ada, AGE: 20)"
-}

------------------------------------------------------------------
newtype Reader env a = Reader { runReader :: env -> a }


instance Monad (Reader env) where
  return :: a -> Reader env a
  return x = Reader (\_ -> x)
  
  (>>=) :: Reader env a -> (a -> Reader env b) -> Reader env b
  ma >>= k = Reader f
    where f env = let a = runReader ma env
                  in  runReader (k a) env


instance Applicative (Reader env) where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

instance Functor (Reader env) where
  fmap f ma = pure f <*> ma

mshowPersonN ::  Reader Person String
mshowPersonN = Reader $ \env -> "NAME: " ++ name env

mshowPersonA ::  Reader Person String
mshowPersonA = Reader $ \env -> "AGE: " ++ show (age env)
mshowPerson ::  Reader Person String
mshowPerson = Reader $ \env -> "(NAME: " ++ name env ++", "++ show (age env)++")"
{-
runReader mshowPersonN  $ Person "ada" 20
"NAME:ada"
runReader mshowPersonA  $ Person "ada" 20
"AGE:20"
runReader mshowPerson  $ Person "ada" 20
"(NAME:ada,AGE:20)"
-}
