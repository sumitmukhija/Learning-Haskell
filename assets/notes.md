## Haskell

- purely functional, no side effects. Thinks of programs as a series of transformations on data
- lazy
- referential transparency
- Statically typed. 
- Type inference
- GHC is a Haskell compiler. GHCi is the interactive mode, let's us see the output of a function exec of a loaded file.
- To load a Haskell file `:l filename`. To reload `:r filename` 
- If we want to have a negative number, it's always best to surround it with parentheses. Doing `5 * (-3)` 
- && means a boolean and, || means a boolean or. not negates a True or a False.
- * is a function that takes two numbers and multiplies them. This is what we call an infix function. Most functions that aren't used with numbers are prefix functions. 


#### Functions
- functions can't begin with uppercase letters
- When a function doesn't take any parameters, we usually say it's a definition (or a name).

```haskell
<!-- function_name<space>parameters -->

min 0 -1 

<!-- In other languages min(0,-1) -->

```

- Function application (calling a function by putting a space after it and then typing out the parameters) has the highest precedence 

```
<!-- The line below returns 51 -->
succ 9 * max 5 4 + 1    
```

```
<!-- The line below returns 100 -->
succ 9 * 10

<!-- The line below returns 91 -->
succ (9 * 10)
```

- If a function takes two parameters, we can also call it as an infix function by surrounding it with backticks. For instance, the div function takes two integers and does integral division between them.

```
<!-- The line below returns 9. prefix fn-->
div 92 10

<!-- The line below returns 9. Infix fn -->
92 `div` 10
``` 

- The difference between Haskell's if statement and if statements in imperative languages is that the else part is mandatory in Haskell. Because the else is mandatory, an if statement will always return something and that's why it's an expression

`if condition then branch1 else branch2`

- We usually use ' to either denote a strict version of a function (one that isn't lazy)


#### Lists

-  lists are a homogenous data structure. 
- 	We can use the let keyword to define a name right in GHCI. Doing let a = 1 inside GHCI is the equivalent of writing a = 1 in a script and then loading it. 
- putting two lists together is done by using the ++ operator.
putting something at the beginning of a list using the `:` operator (also called the cons operator)

`5:[4,3,2,1]`

- `:` takes a number and a list of numbers or a character and a list of characters, whereas ++ takes two lists. Even if you're adding an element to the end of a list with ++, you have to surround it with square brackets so it becomes a list.

- If you want to get an element out of a list by index, use !!. The indices start at 0.

`list !! 5`

- Lists can contain lists. The lists within a list can be of different lengths but they can't be of different types. Just like you can't have a list that has some characters and some numbers, you can't have a list that has some lists of characters and some lists of numbers.
- Lists can be compared. They are compared in lexicographical order. First the heads are compared. If they are equal then the second elements are compared, etc.


#### What can be done with Lists
- `head` - first element of list
- `tail` - tail takes a list and returns its tail. In other words, it chops off a list's head.
- `last` takes a list and returns its last element.
- `init` takes a list and returns everything except its last element.
- `length` takes a list and returns its length.
- `null` checks if a list is empty. If it is, it returns True, otherwise it returns False. Use this function instead of xs == [] 
- `reverse` reverses a list.
- `take` takes number and a list. It extracts that many elements from the beginning of the list
- `drop` works in a similar way, only it drops the number of elements from the beginning of a list.
- `maximum` takes a list of stuff that can be put in some kind of order and returns the biggest element.
- `sum` takes a list of numbers and returns their sum.
- `product` takes a list of numbers and returns their product.
- `elem` takes a thing and a list of things and tells us if that thing is an element of the list.
- `cycle` takes a list and cycles it into an infinite list. If you just try to display the result, it will go on forever so you have to slice it off somewhere.
- `repeat` takes an element and produces an infinite list of just that element
- `replicate` function if you want some number of the same element in a list. replicate 3 10 returns [10,10,10].

#### Ranges
- Ranges are a way of making lists that are arithmetic sequences of elements that can be enumerated.
`[1..20]`

- every third number between 1 and 20
`[3,6..20]`

- To make a list with all the numbers from 20 to 1, you can't just do [20..1], you have to do `[20,19..1]`

- You can also use ranges to make infinite lists by just not specifying an upper limit.

#### List comprehensions

- `[x*2 | x <- [1..10]]`. x is drawn from [1..10] and for every element in [1..10]which we have bound to x, we get that element, only doubled
-  If we have two lists, [2,5,10] and [8,10,11] and we want to get the products of all the possible combinations between numbers in those lists, here's what we'd do.

#### Tuples
- denoted with parentheses and their components are separated by commas.
-  they don't have to be homogenous


- `fst` takes a tuple and returns the first component.
- `snd` takes a pair and returns its second component.
- `zip` takes two lists and then zips them together into one list by joining the matching elements into pairs. The longer list simply gets cut off to match the length of the shorter one

#### Types and typeclasses

- using the :t command which, followed by any valid expression, tells us its type
- Here we see that doing :t on an expression prints out the expression followed by :: and its type. :: is read as "has type of"
- Explicit types are always denoted with the first letter in capital case. 'a', as it would seem, has a type of Char.
- Functions also have types. When writing our own functions, we can choose to give them an explicit type declaration. This is generally considered to be good practice except when writing very short functions.
- The parameters are separated with -> and there's no special distinction between the parameters and the return type. The return type is the last item in the declaration
- Functions are expressions too, so :t works on them without a problem.
- Int stands for integer. It's used for whole numbers. 7 can be an Int but 7.2 cannot. 
- Integer stands for integer. The main difference is that it's not bounded so it can be used to represent really really big numbers.
- Float is a real floating point with single precision.
- Double is a real floating point with double the precision
- Bool is a boolean type. It can have only two values: True and False.
- Char represents a character. It's denoted by single quotes. A list of characters is a string.
- Functions that have type variables are called polymorphic functions. The type declaration of head states that it takes a list of any type and returns one element of that type.
`head :: [a] -> a`

##### Typeclasses

- A typeclass is a sort of interface that defines some behavior.
- Some basic typeclasses: `Eq` is used for types that support equality testing, `Ord` is for types that have an ordering, `Show` can be presented as strings. `Read` is sort of the opposite typeclass of Show. The read function takes a string and returns a type which is a member of Read, `Enum` members are sequentially ordered types, `Bounded` members have an upper and a lower bound.
- In the code below, Everything before the => symbol is called a class constraint. We can read the previous type declaration like this: the equality function takes any two values that are of the same type and returns a Bool. The type of those two values must be a member of the Eq class (this was the class constraint).

```
ghci> :t (==)  
(==) :: (Eq a) => a -> a -> Bool  
```

- All standard Haskell types except for IO (the type for dealing with input and output) and functions are a part of the Eq typeclass.

#### Pattern matching
- When defining functions, you can define separate function bodies for different patterns. This leads to really neat code that's simple and readable. 

```
lucky :: (Integral a) => a -> String  
lucky 7 = "LUCKY NUMBER SEVEN!"  
lucky x = "Sorry, you're out of luck, pal!"   
```

- When making patterns, we should always include a catch-all pattern so that our program doesn't crash if we get some unexpected input.
- Pattern matching can also be used on tuples