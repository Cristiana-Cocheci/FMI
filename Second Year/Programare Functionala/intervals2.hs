
data ListaMea = ListaMea { nume :: String, val :: [Int] }

newtype RW a = RW { runRW :: ListaMea -> (a, String) }

instance Monad RW where
    return a = RW (\_ -> (a, []))
    (RW f) >>= k = RW $ \env ->
        let (a, l1) = f env
            (RW h) = k a
            (b, l2) = h env
        in (b, l1 ++ l2)

instance Applicative RW where
    pure = return
    mf <*> ma = do
        f <- mf
        a <- ma
        return (f a)

instance Functor RW where
    fmap f ma = pure f <*> ma

tell :: String -> RW ()
tell log = RW $ \_ -> ((), log)

getFromInterval :: Int -> Int -> ListaMea -> RW [Int]
getFromInterval a b list = do
    let 
      v = val list
      num = nume list
      result = filter (\x -> x >= a && x <= b) v
    tell num
    return result

listaMea = ListaMea { nume = "example", val = [1..10] }
showm :: RW [Int]-> ListaMea -> String
showm rw l = let (a,b) = (runRW rw l) 
            in (foldr (\int str -> (show int) ++ str) "" a)++" "++b 
--runReader mshowPerson $ Person "ada" 20
--foldr (\(v,n) arb-> insert v n arb) (Empty) l
