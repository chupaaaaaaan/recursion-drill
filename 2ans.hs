-- % cabal install hspec
-- % runghc 1.hs

import Small

main :: IO ()
main = hspec $ do
    describe "soap" $
      prop "behaves as model" $ \(Small n) -> n >= 0
        ==> soap n == sum [0..n]
    describe "fact" $
      prop "behaves as model" $ \(Small n) -> n >= 1
        ==> fact n == product [1..n]
    describe "mul" $
      prop "behaves as model" $ \(Small m) (Small n) -> m >= 1 && n >= 1
        ==> mul m n == m * n
    describe "plus" $
      prop "behaves as model" $ \(Small m) (Small n) -> m >= 0 && n >= 0
        ==> plus m n == m + n
    describe "minus" $
      prop "behaves as model" $ \(Small m) (Small n) -> m >= 0 && n >= 0
        ==> minus m n == m - n
    describe "power" $
      prop "behaves as model" $ \(Small m) (Small n) -> m >= 1 && n >= 1
        ==> power m n == m ^ n

-- soap :: Int -> Int
-- soap 0 = 0
-- soap n = soap (n-1) + n

soap :: Int -> Int
soap n = soap' n 0

soap' :: Int -> Int -> Int
soap' 0 acc = acc
soap' n acc = soap' (n-1) (acc + n)

-- fact :: Int -> Int
-- fact 1 = 1
-- fact n = fact (n - 1) * n

fact :: Int -> Int
fact n = fact' n 1

fact' :: Int -> Int -> Int
fact' 1 acc = acc
fact' n acc = fact' (n - 1) (acc * n)

-- mul :: Int -> Int -> Int
-- mul m 1 = m
-- mul m n = mul m (n - 1) + m

mul :: Int -> Int -> Int
mul m n = mul' m n m

mul' :: Int -> Int -> Int -> Int
mul' _ 1 acc = acc
mul' m n acc = mul' m (n - 1) (acc + m)

-- plus :: Int -> Int -> Int
-- plus m 0 = m
-- plus m n = plus m (n - 1) + 1

plus :: Int -> Int -> Int
plus m n = plus' m n m

plus' :: Int -> Int -> Int -> Int
plus' _ 0 acc = acc
plus' m n acc = plus' m (n - 1) (acc + 1)

-- minus :: Int -> Int -> Int
-- minus m 0 = m
-- minus m n = minus m (n - 1) - 1

minus :: Int -> Int -> Int
minus m n = minus' m n m

minus' :: Int -> Int -> Int -> Int
minus' _ 0 acc = acc
minus' m n acc = minus' m (n - 1) (acc - 1)

-- power :: Int -> Int -> Int
-- power m 1 = m
-- power m n = power m (n - 1) * m

power :: Int -> Int -> Int
power m n = power' m n m

power' :: Int -> Int -> Int -> Int
power' _ 1 acc = acc
power' m n acc = power' m (n - 1) (acc * m)