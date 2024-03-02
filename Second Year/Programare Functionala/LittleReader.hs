module LittleReader where
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