data Arbore a = Nil
  | Nod a ( Arbore a ) ( Arbore a )
instance Functor  Arbore where
  fmap f Nil = Nil
  fmap f (Nod x l r) = Nod (f x) (fmap f l) (fmap f r)

newtype Identity a = Identity a
instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

data Pair a = Pair a a deriving Show
instance Functor Pair where
  fmap f (Pair a b) = Pair (f a) (f b)

data Constant a b = Constant b deriving Show
instance Functor (Constant a) where
  fmap f (Constant x) = Constant (f x)

data Two a b = Two a b
instance Functor (Two a) where
  fmap f (Two aa bb) = (Two aa (f bb))

data Three a b c = Three a b c
instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

data Three' a b = Three' a b b
instance Functor (Three' a) where
  fmap f (Three' a b c) = Three' a (f b) (f c)

data Four a b c d = Four a b c d
instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)

data Four'' a b = Four'' a a a b
instance Functor (Four'' a) where
  fmap f (Four'' e b c d) = Four'' e b c (f d)

data Quant a b = Finance | Desk a | Bloor b
instance Functor (Quant a) where
  fmap _ Finance = Finance
  fmap f (Bloor b) = Bloor (f b)
  fmap f (Desk a) = Desk a

data LiftItOut f a = LiftItOut (f a)
instance Functor f=> Functor (LiftItOut f) where
  fmap fc (LiftItOut x) = LiftItOut (fmap fc x)
--fmap :: Functor f => (a -> b) -> f a -> f b

data Parappa f g a = DaWrappa (f a) (g a)
instance (Functor f, Functor g) => Functor (Parappa f g) where
  fmap fc (DaWrappa x y) = (DaWrappa (fmap fc x) (fmap fc y))

data IgnoreOne f g a b = IgnoringSomething (f a) (g b)
instance (Functor f, Functor g) => Functor (IgnoreOne f g a) where
  fmap fc (IgnoringSomething x y) = IgnoringSomething x (fmap fc y)

data Notorious g o a t = Notorious (g o) (g a) (g t)
instance (Functor g) => Functor (Notorious g o a) where
  fmap fc (Notorious x y z) =  Notorious x y (fmap fc z)

data GoatLord a = NoGoat | OneGoat a
                | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)
instance Functor GoatLord where
  fmap _ NoGoat= NoGoat
  fmap f (OneGoat x) = OneGoat (f x)
  fmap f (MoreGoats x y z) = MoreGoats (fmap f x) (fmap f y) (fmap f z)

data TalkToMe a = Halt | Print String a | Read (String -> a)
instance Functor TalkToMe where
  fmap _ Halt = Halt
  fmap f (Print s a) = Print s (f a)
  fmap f (Read x) = Read (fmap f x)

x = Read (\str -> length str)
evalRead :: TalkToMe a ->String-> a
evalRead (Read f) s = f s
-- ghci> evalRead x
-- 5
-- ghci> evalRead (fmap (+1) x)
-- 6