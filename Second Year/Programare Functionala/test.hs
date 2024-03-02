module LittleReader where
import GHC.IO.FD (readRawBufferPtr)
newtype Reader e a = Reader { runReader :: e -> a }

instance Functor (Reader a) where
  fmap f (Reader g) = Reader $ f . g
  
instance Applicative (Reader a) where
  pure x = Reader $ \_ -> x
  m <*> n = Reader $ \e -> (runReader m e) (runReader n e)
  
instance Monad (Reader a) where
  m >>= f = Reader $ \e -> runReader (f $ runReader m $ e) e
  
ask :: Reader a a
ask = Reader id

asks :: (e -> a) -> Reader e a
asks = Reader
------------------------------------------------------------

data Person = Person { name :: String, age :: Int }

showPersonN :: Person -> String
showPersonN (Person{name = a, age = b}) = "NAME: "++ a
showPersonA :: Person -> String
showPersonA (Person{name = a, age = b}) = "AGE: "++ show b
showPerson :: Person -> String
showPerson p = "("++ showPersonN p ++ ", " ++ showPersonA p ++")"


mshowPersonN :: Reader Person String
mshowPersonN = Reader $ \env -> name env
mshowPersonA :: Reader Person String
mshowPersonA = Reader $ \rdr -> show (age rdr)
mshowPerson :: Reader Person String
mshowPerson = Reader $ \env -> name env ++" "++ show (age env)
    
