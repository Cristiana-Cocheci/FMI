data Expr = Const Int -- integer constant
            | Expr :+: Expr -- addition
            | Expr :*: Expr -- multiplication
            deriving Eq

instance Show Expr where
    show (Const x) = show x
    show (e1 :+: e2) = "(" ++ show e1 ++ " + "++ show e2 ++ ")"
    show (e1 :*: e2) = "(" ++ show e1 ++ " * "++ show e2 ++ ")"

exp1 = ((Const 2 :*: Const 3) :+: (Const 0 :*: Const 5))
exp2 = (Const 2 :*: (Const 3 :+: Const 4))
exp3 = (Const 4 :+: (Const 3 :*: Const 3))
exp4 = (((Const 1 :*: Const 2) :*: (Const 3 :+: Const 1)) :*: Const 2)

evalExp :: Expr ->Int
evalExp (Const x) = x
evalExp (a :+: b) = evalExp a + evalExp b
evalExp (a :*: b) = evalExp a * evalExp b

data Operation = Add | Mult deriving (Eq, Show)

data Tree = Lf Int -- leaf
            | Node Operation Tree Tree -- branch
            deriving (Eq, Show)


arb1 = Node Add (Node Mult (Lf 2) (Lf 3)) (Node Mult (Lf 0)(Lf 5))
arb2 = Node Mult (Lf 2) (Node Add (Lf 3)(Lf 4))
arb3 = Node Add (Lf 4) (Node Mult (Lf 3)(Lf 3))
arb4 = Node Mult (Node Mult (Node Mult (Lf 1) (Lf 2)) (Node Add (Lf 3)(Lf 1))) (Lf 2)

evalArb :: Tree ->Int
evalArb (Lf x) = x
evalArb (Node Add ex1 ex2) = evalArb ex1 + evalArb ex2
evalArb (Node Mult ex1 ex2) = evalArb ex1 * evalArb ex2

expToArb :: Expr -> Tree
expToArb (Const x) = Lf x
expToArb (a :+: b) = Node Add (expToArb a) (expToArb b)
expToArb (a :*: b) = Node Mult (expToArb a) (expToArb b)

data IntSearchTree value
        = Empty
        | BNode
        (IntSearchTree value) -- elemente cu cheia mai mica
        Int -- cheia elementului
        (Maybe value) -- valoarea elementului
        (IntSearchTree value) -- elemente cu cheia mai mare
        deriving Show

barb1 :: IntSearchTree Int
barb1= (BNode (BNode (Empty) 3 (Just 1) (BNode (Empty) 5 (Just 2) (Empty))) 6 (Just 0) (BNode (Empty) 8 (Just 3) (Empty)))

lookup' :: Int -> IntSearchTree value -> Maybe value
lookup' x Empty = Nothing
lookup' x (BNode (arbStg) cheie Nothing (arbDr)) = Nothing
lookup' x (BNode (arbStg) cheie (Just val) (arbDr)) | (x==cheie) = (Just val)
                                                    | (x<cheie) = lookup' x arbStg
                                                    | (x>cheie) = lookup' x arbDr

keys :: IntSearchTree value -> [Int]
keys Empty = []
keys (BNode (arbStg) cheie Nothing (arbDr)) = keys arbStg ++ keys arbDr
keys (BNode (arbStg) cheie (Just val) (arbDr)) = keys arbStg ++ [cheie] ++ keys arbDr

values :: IntSearchTree value -> [value]
values Empty = []
values (BNode (arbStg) cheie Nothing (arbDr)) = values arbStg ++ values arbDr
values (BNode (arbStg) cheie (Just val) (arbDr)) = values arbStg ++ [val] ++ values arbDr


delete :: Int -> IntSearchTree value -> IntSearchTree value
delete val Empty = Empty
delete val (BNode Empty k Nothing x) = (BNode Empty k Nothing (delete val x))
delete val (BNode x k Nothing Empty) =  (BNode (delete val x) k Nothing Empty) 
delete val (BNode (arbStg) k (Just n) (arbDr)) | (val==k) = (BNode (arbStg) k (Nothing) (arbDr))
                                                       | (val<k) = (BNode (delete val arbStg) k (Just n) arbDr)
                                                       | (val>k) = (BNode arbStg k (Just n) (delete val arbDr))

toList :: IntSearchTree value -> [(Int, value)]
toList Empty = []
toList (BNode (arbStg) cheie Nothing (arbDr)) = toList arbStg ++ toList arbDr
toList (BNode (arbStg) cheie (Just val) (arbDr)) = toList arbStg ++ [(cheie,val)] ++ toList arbDr


insert :: Int-> value -> IntSearchTree value -> IntSearchTree value
insert val nume Empty = (BNode (Empty) val (Just nume) Empty)
insert val nume (BNode Empty k Nothing x) = (BNode Empty k Nothing (insert val nume x))
insert val nume (BNode x k Nothing Empty) =  (BNode (insert val nume x) k Nothing Empty) 
insert val nume (BNode (arbStg) k (Just n) (arbDr)) | (val==k) = (BNode (arbStg) k (Just n) (arbDr))
                                                       | (val<k) = (BNode (insert val nume arbStg) k (Just n) arbDr)
                                                       | (val>k) = (BNode arbStg k (Just n) (insert val nume arbDr))

fromList :: [(Int,value)]-> IntSearchTree value
fromList l= foldr (\(v,n) arb-> insert v n arb) (Empty) l


printTree :: IntSearchTree value -> String
printTree Empty = ""
printTree (BNode (Empty) cheie _ (Empty)) = "("++show cheie ++")"
printTree (BNode (Empty) cheie _ (arbDr)) = "("++ show cheie ++")"++
                                            "("++printTree arbDr++")"
printTree (BNode (arbStg) cheie _ (Empty)) = "(" ++ printTree arbStg ++ ")"++
                                            "("++ show cheie ++")"
                                            
printTree (BNode (arbStg) cheie _ (arbDr)) = "(" ++ printTree arbStg ++ ")"++
                                            "("++ show cheie ++")"++
                                            "("++printTree arbDr++")"


divImp :: [(Int,value)] -> [(Int,value)]
divImp []=[]
divImp l= [(l !! ((length l) `div` 2))] ++divImp(take ((length l) `div` 2) l)++ divImp(drop (((length l) `div` 2)+1) l)

balance :: IntSearchTree value -> IntSearchTree value
balance arb = fromList.reverse.divImp.toList $ arb

(<+) :: String -> [Int] -> Bool
(<+) str l = True