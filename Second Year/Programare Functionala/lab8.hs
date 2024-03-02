class Collection c where
    empty :: c key value
    singleton :: key -> value -> c key value
    insert :: Ord key
        => key -> value -> c key value -> c key value
    lookup' :: Ord key => key -> c key value -> Maybe value
    delete :: Ord key => key -> c key value -> c key value
    toList :: c key value -> [(key, value)]

    keys :: c key value -> [key]
    keys colectie = map (\(k,v) -> k) (toList colectie)

    values :: c key value -> [value]
    values colectie = map (\(k,v)->v) (toList colectie)

    fromList :: Ord key => [(key,value)] -> c key value
    fromList = foldr(\(k,v) colectie -> insert k v colectie) empty


newtype PairList k v
    = PairList { getPairList :: [(k, v)] }
-- data PairList k v = PairList [(k,v)]

look_for:: Eq k => k-> [(k,v)]-> Maybe v
look_for k [] = Nothing
look_for  x ((k,v): t) 
    | (x==k) = Just v
    |  otherwise = look_for x t


instance Collection PairList where
   empty = PairList[]
   singleton k v = PairList [(k,v)]
   insert k v (PairList l) = PairList (l ++ [(k,v)])
   toList (PairList l) = l
   lookup' k (PairList l) = look_for k l
   delete k (PairList l) = PairList $ filter (\(key,v) -> key/=k) l
    
{-class Collection c where
    empty :: c key value
    singleton :: key -> value -> c key value
    insert :: Ord key => key -> value -> c key value -> c key value
    lookup :: Ord key => key -> c key value -> Maybe value
    delete :: Ord key => key -> c key value -> c key value
    keys :: c key value -> [key]
    values :: c key value -> [value]
    toList :: c key value -> [(key, value)]
    fromList :: Ord key => [(key,value)] -> c key value


    keys = (map fst) . toList
    values = (map snd) . toList
    fromList [] = empty
    fromList ((a, b) : t) = insert a b (fromList t)

newtype PairList k v
    = PairList { getPairList :: [(k, v)] }

instance Collection PairList where
    empty = PairList []
    singleton k v = PairList [(k, v)]
    insert k v clc = PairList ((k, v) : (getPairList clc))
    delete k clc = PairList (filter (\ x -> (fst x) /= k) (getPairList clc) )
    toList clc = getPairList clc
    lookup k clc = lookup_helper k (getPairList clc)
        where
            lookup_helper :: Ord k => k -> [(k, v)] -> Maybe v
            lookup_helper _ [] = Nothing
            lookup_helper k ((kk, vv) : t) = if kk == k then
                                                Just vv
                                            else
                                                lookup_helper k t-}
data SearchTree key value
    = Empty
    | BNode
        (SearchTree key value) -- elemente cu cheia mai mica
        key -- cheia elementului
        (Maybe value) -- valoarea elementului
        (SearchTree key value) -- elemente cu cheia mai mare


instance Collection SearchTree where
    empty = Empty
    singleton k v = (BNode Empty k (Just v) Empty)
    lookup' x Empty = Nothing
    lookup' x (BNode (arbStg) cheie Nothing (arbDr)) = Nothing
    lookup' x (BNode (arbStg) cheie (Just val) (arbDr)) | (x==cheie) = (Just val)
                                                        | (x<cheie) = lookup' x arbStg
                                                        | (x>cheie) = lookup' x arbDr

    keys Empty = []
    keys (BNode (arbStg) cheie Nothing (arbDr)) = keys arbStg ++ keys arbDr
    keys (BNode (arbStg) cheie (Just val) (arbDr)) = keys arbStg ++ [cheie] ++ keys arbDr

    
    values Empty = []
    values (BNode (arbStg) cheie Nothing (arbDr)) = values arbStg ++ values arbDr
    values (BNode (arbStg) cheie (Just val) (arbDr)) = values arbStg ++ [val] ++ values arbDr


    
    delete val Empty = Empty
    delete val (BNode Empty k Nothing x) = (BNode Empty k Nothing (delete val x))
    delete val (BNode x k Nothing Empty) =  (BNode (delete val x) k Nothing Empty) 
    delete val (BNode (arbStg) k (Just n) (arbDr)) | (val==k) = (BNode (arbStg) k (Nothing) (arbDr))
                                                        | (val<k) = (BNode (delete val arbStg) k (Just n) arbDr)
                                                        | (val>k) = (BNode arbStg k (Just n) (delete val arbDr))

    
    toList Empty = []
    toList (BNode (arbStg) cheie Nothing (arbDr)) = toList arbStg ++ toList arbDr
    toList (BNode (arbStg) cheie (Just val) (arbDr)) = toList arbStg ++ [(cheie,val)] ++ toList arbDr


    insert val nume Empty = (BNode (Empty) val (Just nume) Empty)
    insert val nume (BNode Empty k Nothing x) = (BNode Empty k Nothing (insert val nume x))
    insert val nume (BNode x k Nothing Empty) =  (BNode (insert val nume x) k Nothing Empty) 
    insert val nume (BNode (arbStg) k (Just n) (arbDr)) | (val==k) = (BNode (arbStg) k (Just n) (arbDr))
                                                        | (val<k) = (BNode (insert val nume arbStg) k (Just n) arbDr)
                                                        | (val>k) = (BNode arbStg k (Just n) (insert val nume arbDr))

    fromList l= foldr (\(v,n) arb-> insert v n arb) (Empty) l



data Punct = Pt [Int]

data Arb = Vid | F Int | N Arb Arb deriving Show

class ToFromArb a where
    toArb :: a -> Arb
    fromArb :: Arb -> a


showCoords :: [Int] -> String
showCoords [] = ""
showCoords [x] = show x
showCoords (x:xs) = show x ++ ", " ++ showCoords xs

instance Show Punct where
    show (Pt []) = "()"
    show (Pt coords) = "(" ++ showCoords coords ++ ")"

turn_list_to_Arb :: [Int] -> Arb
turn_list_to_Arb [] = Vid
turn_list_to_Arb (x:t) = (N (F x) (turn_list_to_Arb t))

turn_arb_to_lis :: Arb -> [Int]
turn_arb_to_lis Vid = []
turn_arb_to_lis (N (F x) a) = [x] ++ turn_arb_to_lis a
turn_arb_to_lis (N a b) = turn_arb_to_lis a ++ turn_arb_to_lis b

instance ToFromArb Punct where
    toArb (Pt lis) = turn_list_to_Arb lis
    fromArb  a = Pt $ turn_arb_to_lis a

data Geo a = Square a | Rectangle a a | Circle a
    deriving Show

class GeoOps g where
    perimeter :: (Floating a) => g a -> a
    area :: (Floating a) => g a -> a

instance GeoOps Geo where
    perimeter (Square a) = 4*a
    perimeter (Rectangle a b) = 2*(a+b)
    perimeter (Circle a) = 2*a* pi 
    area (Square a) = a*a
    area (Rectangle a b) = a*b
    area (Circle a) = a*a* pi 

instance (Floating a, Eq a) => Eq (Geo a) where
    a == b = (perimeter a == perimeter b) 

