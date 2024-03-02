newtype ReaderM env a = ReaderM { runReaderM :: env -> Either String a}

instance Applicative (ReaderM env)
-- instance Functor (ReaderM env)
instance Functor (ReaderM env) where
    fmap f (ReaderM g) = ReaderM (\env -> fmap f (g env))

instance Monad (ReaderM a) where
  return x = ReaderM (\_ -> Right x)
  ma >>= f = ReaderM $ \env -> let a = runReaderM ma env
                              in
                                case a of (Left str) -> (Left str)
                                          (Right val) -> runReaderM (f val) env
{-
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
-}

testReaderM :: ReaderM String String
testReaderM = ma >>= k
    where 
        ma = ReaderM
         (\str -> if length str > 10 then Right (length str) else Left "prea mare")
        k val = ReaderM
             (\ str -> if length str `mod` 2 == 0 then Right "par" else Left "impar")

test1 = runReaderM testReaderM $ "abcd" 
test2 = runReaderM testReaderM $ "abcdefghjklmn"
test3 = runReaderM testReaderM $ "abcdefghjklmnp"

---------------------------------------
--v2
--------------------------------------
newtype ReaderMM env a = ReaderMM { runReaderMM :: env -> Either String a }

instance Functor (ReaderMM env) where
    fmap f (ReaderMM g) = ReaderMM (\env -> fmap f (g env))

instance Applicative (ReaderMM env) where
    pure x = ReaderMM (\_ -> Right x)
    (ReaderMM f) <*> (ReaderMM g) = ReaderMM (\env -> f env <*> g env)

instance Monad (ReaderMM env) where
    return = pure
    (ReaderMM f) >>= k = ReaderMM (\env -> do
        x <- f env
        let (ReaderMM g) = k x
        g env)

testReaderMM :: ReaderMM String String
testReaderMM = ma >>= k
  where
    ma = ReaderMM (\str -> if length str > 10 then Right (show $ length str) else Left "prea mare")
    k val = ReaderMM (\str -> if length str `mod` 2 == 0 then Right "par" else Left "impar")
