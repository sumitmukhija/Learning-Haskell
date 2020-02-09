-- HOF.hs

mx = max 4 5

mmx = (max 4) 5 

-- mult 2 3 4
-- (((mult 2) 3) 4) - functions broken down like these are called curried
mult:: (Num a) => a -> a -> a -> a
mult x y z = x * y * z

-- A function that returns a function
retAFunction:: Int -> (Int -> Int)
retAFunction x = mult x x

-- A function that takes a function
takeAFunction:: (Int -> Int) -> Int
takeAFunction fn = 6


-- The function below is an example of partial function. The map takes two arguments
-- function and the list. The max fn takes two arguments and gives the max
-- In this case max has two arguments 3 and each list elem
checkWithThree = map (max 3) [1,2,3]

-- zip with
x = zipWith (*) [1..6][1..5]

-- Lambda
addSet = map (\(x,y) ->  x+y) [(1,2), (3,4), (5,6)]

-- Folds
-- lfold

fsum:: [Int] -> Int
fsum xs = foldl(\acc x ->  acc + x) 0  xs