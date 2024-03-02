
instance Semigroup Int where
  a <> b = a+b

instance Monoid Int where
  mempty = 0

{-
instance Semigroup [a] where
  xs <> ys = xs ++ ys

instance Monoid [a] where
  mempty = []

-- Not commutative!
-- [1, 2] <> [3, 4] == [1, 2, 3, 4]
-- [3, 4] <> [1, 2] == [3, 4, 1, 2]
-}
----------------------------------------------
newtype WriterI a = Writer { runWriter :: (a, Int) }

instance Monad WriterI where
  return :: a -> WriterI a
  return va = Writer (va, 0)

  (>>=) :: WriterI a -> (a -> WriterI b) -> WriterI b
  ma >>= k = let (va, log1) = runWriter ma
                 (vb, log2) = runWriter (k va)
             in  Writer (vb, log1 + log2)


instance Applicative WriterI where
  pure :: a -> WriterI a
  pure = return
  
  (<*>) :: WriterI (a -> b) -> WriterI a -> WriterI b
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

instance Functor WriterI where
  fmap :: (a -> b) -> WriterI a -> WriterI b
  fmap f ma = pure f <*> ma

tell :: Int -> WriterI ()
tell log = Writer ((), log)
-----------------------------------------------------------
acc2' :: String -> WriterI String
acc2' input = if (length input) > 10
  then do
    tell 1
    acc4' (take 9 input)
  else do
    tell 10
    return input

acc3' :: String -> WriterI String
acc3' input = if (length input) `mod` 3 == 0
  then do
    tell 3
    acc2' (input ++ "ab")
  else do
    tell 1
    return $ tail input

acc4' :: String -> WriterI String
acc4' input = if (length input) < 10
  then do
    tell (length input)
    return (input ++ input)
  else do
    tell 5
    return (take 5 input)

acc1' :: String -> (String, Int)
acc1' input = if length input `mod` 2 == 0
  then runWriter (acc2' input)
  else runWriter $ do
    str1 <- acc3' (tail input)
    str2 <- acc4' (take 1 input)
    return (str1 ++ str2)