
-- Double even numbers
evenNumbersFromZeroToHundred = [0,2..100]
doubleEachNumber = [x*2 | x <- evenNumbersFromZeroToHundred]

-- Double even numbers between a range
allEvenNumbersBetweenXandY x y = if y > x then [x, x+2 .. y] else []
doubleAllEvenNumbersBetween x y = [n+n | n <- allEvenNumbersBetweenXandY x y]

-- get successor of each odd element from a list if the element is even, return itself
l = [4,41,2,3,5,6,8,10, 1, 80]
processL = [if odd x == True then succ x else x | x <- l]

-- Create a list with items and quantity
items = ["eggs", "Bread", "Apples", "Milk", "Cookies"]
qty = ["12", "2", "3", "1", "10"]

itemsAndQty = [ y ++" "++ x | x <- items, y <- qty]
-- ["12 eggs","2 eggs","3 eggs","1 eggs","10 eggs","12 Bread","2 Bread","3 Bread","1 Bread","10 Bread","12 Apples","2 Apples","3 Apples","1 Apples","10 Apples","12 Milk","2 Milk","3 Milk","1 Milk","10 Milk","12 Cookies","2 Cookies","3 Cookies","1 Cookies","10 Cookies"]