-- Tuples.hs

t = ("Sumit", "Student")

-- First and last element
first = fst t
last = snd t

-- List comprehension to create triangles with sides from 1-10
triangles = [ (a,b,c) | c <- [1..10], b <- [1..10], a <- [1..10]]

-- right angled triangles
hundredTriangles = [(a,b,c) | a <- [1.. 100], b <- [1.. 100], c <- [1.. 100], a*a + b*b == c*c]

-- sum of elements in a list
listOfTups = [(3,1), (13,3), (1, 6), (1,0), (2,5)]
accTuple = [x + y | (x,y) <-  listOfTups]
