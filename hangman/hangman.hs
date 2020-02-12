import System.IO
import System.Random

main = 
	do
    file <- openFile "enable1.txt" ReadMode
    contents <- hGetContents file --returns a seed for random num generator
    gen <- getStdGen
    let words = map init (lines contents)
     (n, _) = randomR (0, (length words)-1) gen:: (Int, StdGen)
    play(words !! n)
    putStrLn ("There are "++ show(length(lines contents)) ++ " words." )
    hClose file
  
play word = do
	        putStrLn word
	        putStrLn "Enter a character"
	        line <- getLine
	        putStrLn (handle (head line) word)
	        play word

handle letter word 
       | letter `elem` word = "Yup"
       | otherwise = "No!"