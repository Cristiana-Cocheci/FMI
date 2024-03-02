sumPatrImp::[Int]->Int
sumPatrImp  = foldr (+) 0 .map (^2).filter (odd)

adev::[Bool]->Bool
adev = foldr (&&) True

allVerifies:: (Int->Bool) ->[Int] ->Bool
allVerifies f l = foldr (&&) True . map (f) $ l

anyVerifies :: (Int -> Bool) -> [Int] -> Bool
anyVerifies f l = foldr (||) False . map (f) $ l


mapFoldr :: (a->b)->[a]->[b]
mapFoldr f l= foldr (\x s -> (f x):s) [] l

filterFoldr :: (a->Bool)->[a]->[a]
filterFoldr f l = foldr (\x s -> if f x then x:s else s)[]l

listToInt :: [Int]->Int
listToInt = foldl (\x y -> x*10+y) 0 

rmChar:: Char->[Char]->[Char]
rmChar c str= filter (\x -> if (elem x [c]) then False else True) str

rmCharRec ::String->String->String
rmCharRec [] cuv = cuv
rmCharRec (x:s) cuv= rmCharRec s (rmChar x cuv)

rmCharsFold :: String->String->String
rmCharsFold l cuv= foldr (rmChar) cuv l

myReverse :: [Int]->[Int]
myReverse = foldr (\x s-> s++[x]) []

myElem :: Int->[Int]->Bool
myElem x = foldr (\a boo-> boo || (a==x)) False

myUnzip::[(a,b)]->([a],[b])
myUnzip list = (foldr (\(a,b) l-> a:l) [] list, foldr (\(a,b) l-> b:l) [] list)

union :: [Int]->[Int]->[Int]
union l1 l2 = foldr (\x l-> if(elem x l) then l else x:l) [] (l2++l1) --sort???

intersect :: [Int] ->[Int]->[Int]
intersect l1 l2 = union (foldr (\x l-> if(elem x l) then x:l else l) (union l2 []) (union l1 [])) []


--filtr :: (Int->Bool) ->[[Int]]->[[Int]]
--filtr f ll = map (\l -> filter f l) ll

permutationsWeird :: [Int] -> [[Int]]
permutationsWeird l= foldr(\x li-> (map (x:) (permutations (filter(/=x) l)))++li) [[]] l

permutations :: [Int] -> [[Int]]
permutations l= filter(\li -> length li == length l) (permutationsWeird l)