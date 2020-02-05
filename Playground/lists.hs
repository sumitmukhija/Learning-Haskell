-- Lists.hs

-- Creating two lists
groceries = ["eggs", "milk"]
sauces = ["Mayo"]
-- Adding two lists
shoppingList = groceries ++ sauces

-- Adding two strings(list of characters)
firstName = "Sumit"
lastName = "Mukhija"
fullName = firstName ++ " " ++ lastName 

-- Using cons operator
-- nameWithSal = "Mr. ":fullName Won't work because cons can be used with a single element
faultyDice = [2,3,4,5,6]
dice = 1:faultyDice

-- Getting element at an index from list
laundry = ["shirt", "jacket", "sheets", "towel", "socks"]
washSecondItem = laundry !! 1

-- Comparing lists
isListGreater = [2, 3] > [2,3,4]

-- head
fChar = head fullName

-- tail
everythingElse = tail fullName

-- last
lChar = last fullName

-- init
everythingButLast = init fullName

--length
charsLong = length firstName

-- null
isNoName = null fullName

-- Reverse
nameInReverse = reverse fullName

--take
extractFirstName = take (length firstName) fullName

--drop
dropFirstName = drop ((length firstName)+1) fullName

--maximum & minimum
numbers = [124,12243, 3433, 999871]
largestNumber =  maximum numbers
smallestNumber = minimum numbers

--elem
didYouForgetToWrite item = if item `elem` shoppingList then "No!" else "Oh, yes!"