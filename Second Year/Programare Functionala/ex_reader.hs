-- main :: IO ()
-- main = do
--   env <- loadEnv
--   let str = runReader func1' env
--   print str

newtype Reader e a = Reader { runReader :: e -> a }

instance Functor (Reader a) where
  fmap f (Reader g) = Reader $ f . g
  
instance Applicative (Reader a) where
  pure x = Reader $ \_ -> x
  m <*> n = Reader $ \e -> (runReader m e) (runReader n e)
  
instance Monad (Reader a) where
  (>>=) :: Reader a1 a2 -> (a2 -> Reader a1 b) -> Reader a1 b
  m >>= f = Reader $ \e -> runReader (f $ runReader m $ e) e
  
ask :: Reader a a
ask = Reader id

asks :: (e -> a) -> Reader e a
asks = Reader

data Environment = Environment
  { param1 :: String
  , param2 :: String
  , param3 :: String
  }
x :: Environment
x = Environment { param1="param1", param2="doi", param3="p3"}
showEnv :: Reader Environment String
showEnv = Reader$ \env -> param1 env ++ param2 env ++ param3 env

func1' :: Reader Environment String
func1' = do
  res <- func2'
  return ("Result: " ++ show res)

func2' :: Reader Environment Int
func2' = do
  env <- ask
  let res3 = func3 env
  return (2 + floor res3)

-- as above
func3 :: Environment -> Float
func3 env = (fromIntegral $ l1 + l2 + l3) * 2.1
  where
    l1 = length (param1 env)
    l2 = length (param2 env) * 2
    l3 = length (param3 env) * 3