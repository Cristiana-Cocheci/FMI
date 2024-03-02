type Nume = String
type Env = [(Nume, Bool)]

genCombinations :: Int -> [[Bool]]
genCombinations 0 = [[]]
genCombinations n = [x : xs | x <- [False, True], xs <- genCombinations (n - 1)]


envs :: [Nume] -> [Env]
envs vars = map (zip vars) combinations
  where
    combinations = genCombinations (length vars)

test_envs :: Bool
test_envs = envs ["P", "Q"] == expectedEnvs
  where
    expectedEnvs =
      [ [("P", False), ("Q", False)]
      , [("P", False), ("Q", True)]
      , [("P", True), ("Q", False)]
      , [("P", True), ("Q", True)]
      ]