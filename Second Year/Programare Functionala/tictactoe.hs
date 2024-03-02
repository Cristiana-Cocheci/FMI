import Data.Char
twice ::[Int] -> [Int]
twice xs = do
  x<- xs 
  if even x then [x*x, x*x] else [x*x]

pasar :: String -> String
pasar xs = do 
  l<- xs 
  if isAlpha l && (elem l ['a', 'e', 'i', 'o', 'u'] ) then [l]++"P"++[l] else [l]


--------------------------------------------

data Ceva = C { get :: String -> Int }

-- Example function that creates a Ceva value
makeCeva :: Int -> Ceva
makeCeva n = C { get = \str -> length str + n }

isCeva :: Ceva
isCeva = C { get = \str -> length (filter (\l-> elem l ['a', 'e', 'i', 'o', 'u']) str)}

-- Example usage
main :: IO ()
main = do
    let ceva = makeCeva 5  -- Create a Ceva value with n = 5
    putStrLn $ "Length of 'hello': " ++ show (get ceva "hello")  -- Output: Length of 'hello': 10

