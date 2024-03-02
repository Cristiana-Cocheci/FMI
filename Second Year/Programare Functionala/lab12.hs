import Data.Maybe (isJust)
data List a = Nil | Cons a (List a) 
            deriving (Eq, Show)

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons x y) = Cons (f x) (fmap f y)

instance Applicative List where
    pure a = Cons a Nil
    Nil <*> _ = Nil
    _ <*> Nil = Nil
    (Cons a b) <*> xs = plus (fmap a xs) (b<*> xs)

plus :: List a-> List a-> List a
plus Nil a = a
plus (Cons a b) lista = Cons a (plus b lista)
-- instance Applicative List where
--     pure a = Cons a Nil
--     Nil <*> _ = Nil
--     _ <*> Nil = Nil
--     (Cons a rest) <*> l = combin (fmap a l) (rest<*> l)

-- combin:: List a -> List a -> List a
-- combin Nil rest = rest
-- combin (Cons a b) rest = Cons a (combin b rest)

-- instance Applicative (Either a) where
--     pure = Right
--     Left e <*> _ = Left e
--     _ <*> Left e = Left e
--     Right a <*> x = fmap a x

-- instance Applicative List where
--     pure x = Cons x Nil
--     Nil <*> _ = Nil
--     _ <*> Nil = Nil
--     (Cons f fs) <*> xs = append (fmap f xs) (fs <*> xs)

-- append :: List a -> List a -> List a
-- append Nil ys = ys
-- append (Cons x xs) ys = Cons x (append xs ys)

f = Cons (+1) (Cons (*2) Nil)
v = Cons 1 (Cons 2 Nil)


noEmpty :: String -> Maybe String
noEmpty "" = Nothing
noEmpty x = Just x

noNegative :: Int -> Maybe Int
noNegative x | x<0 = Nothing
             | otherwise = Just x

test21 = noEmpty "abc" == Just "abc"
test22 = noNegative (-5) == Nothing
test23 = noNegative 5 == Just 5

-- Define the Cow data type
data Cow = Cow { name :: String
               , age :: Int
               , weight :: Int
               } deriving (Eq, Show)

-- Function to construct a Cow value while ensuring constraints
cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString n a w
    | isJust maybeName && isJust maybeAge && isJust maybeWeight = Just (Cow n a w)
    | otherwise = Nothing
    where
        maybeName = noEmpty n
        maybeAge = noNegative a
        maybeWeight = noNegative w

constructCow :: String -> Int -> Int -> Maybe Cow
constructCow n a w = Cow <$> maybeName <*> maybeAge <*> maybeWeight
    where
        maybeName = noEmpty n
        maybeAge = noNegative a
        maybeWeight = noNegative w

newtype Name = Name String deriving (Eq, Show)
newtype Address = Address String deriving (Eq, Show)
data Person = Person Name Address deriving (Eq, Show)

validateLength :: Int -> String -> Maybe String
validateLength max s | (length s) <max = Just s
                     | otherwise = Nothing

mkName :: String -> Maybe Name
mkName s = Name <$> (validateLength 25 s)

mkAddress :: String -> Maybe Address
mkAddress a = Address <$> (validateLength 100 a)

mkPerson :: String -> String -> Maybe Person
mkPerson a b = Person <$> (mkName a) <*> (mkAddress b)