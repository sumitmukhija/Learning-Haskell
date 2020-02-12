-- making-our-own

data Center = Point Int Int deriving (Show)
-- data Radius = Radius Float deriving (Show)
data Shape = Circle Center Float | Rectangle Int Int Int Int deriving (Show)


area:: Shape -> Float
area (Circle _ r) = 3.14 * r * r
area (Rectangle a b c d) = 1

-- map with value constructors
diffCircles = map (Circle (Point 2 2)) [4,5,6,6]  


-- Person
data Person = Person String String Int Bool Car deriving (Show)
data Car = Car {
	make :: String, year :: Int
} deriving (Show)

chevy = Car "Chevy" 1990
jon = Person "Jon" "Galway" 32 True chevy


nameAndPlace:: Person -> String
nameAndPlace (Person name city _ _ _) = name ++ " from "++ city

makeAndYear:: Car -> String
makeAndYear (Car name year) = name ++ " of " ++ show year

whatCar:: Person -> String
whatCar (Person _ _ _ _ car) = (makeAndYear car)


-- Typecalass
class Breakable a where
	