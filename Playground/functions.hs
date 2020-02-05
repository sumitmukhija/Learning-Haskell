
-- Functions.hs

-- A function to double the given number 
makeItTwice x = x * 2

-- A function that doubles the given number and adds a number to it
makeItTwiceAndAdd x y = (x * 2) + y

-- A function that doubles the given number using `makeItTwice` and adds a number to it
doubleUsingFunctionAndAdd x y = makeItTwice x + y

-- A function that decides if can vote given an age
canVote age = if age > 18 then True else False

sayName = "The name is Sumit"
