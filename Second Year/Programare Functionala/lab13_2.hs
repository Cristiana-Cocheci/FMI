newtype WriterS a = Writer { runWriter :: (a, [String]) }

instance Monad WriterS where
  return :: a -> WriterS a
  return va = Writer (va, [])

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

tell :: [String] -> WriterS ()
tell log = Writer ((), log)

logIncrement :: Int  -> WriterS Int
-- logIncrement = undefined
logIncrement x = do
  tell ["inc: "++show x]
  return (x+1)

logIncrementN :: Int -> Int -> WriterS Int
logIncrementN x 0 = return x
logIncrementN x n = do
  y<- logIncrement x
  logIncrementN y (n-1)