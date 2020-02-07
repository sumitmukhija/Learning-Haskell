-- Guard.hs

canVote:: Integer -> Bool
canVote age | (age >=18) = True | otherwise = False


-- Guard with three. 
findMaxOfATuple:: (Int, Int) -> Int
findMaxOfATuple (a, b)
                | a > b = a
                | b > a = b
                | otherwise = a

-- Guards with where
isRightAngledTriangle::(Int,Int,Int) -> Bool
isRightAngledTriangle (x,y,z) | sqOfSides==z^2 = True
                              | otherwise = False
                              where sqOfSides = (x^2 + y^2)