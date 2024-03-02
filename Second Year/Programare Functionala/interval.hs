--getFromInterval 5 7 [1..10] == [5,6,7]

--using reader writer monad
newtype RW env a = RW { runRW :: env->(a, [Int]) }

instance Monad (RW a) where
  return a = RW (\_ -> (a,[]))

  --  ma >>= k = let (va, log1) = runWriter ma
  --                (vb, log2) = runWriter (k va)
  --            in  Writer (vb, log1 ++ log2)
  --m >>= f = Reader $ \e -> runReader (f $ runReader m $ e) e
  (RW f) >>= k = RW $ \env->
                      let (a, l1) = f env
                          (RW h) = k a
                          (b, l2) = h env
                      in (b, l1++l2)

instance Applicative (RW a) where
  pure = return

  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

instance Functor (RW a) where
  fmap f ma = pure f <*> ma

tell :: [Int] -> (RW a) ()
tell log = RW $ \_-> ((), log)
--------------------
getFromInterval :: Int -> Int -> [Int] -> RW env [Int]
getFromInterval a b list = do
    let result = filter (\x -> x >= a && x <= b) list
    tell list
    return result

x= runRW (getFromInterval 5 7 [1..11]) ()