module Contract where
data Contract = Contract {acqDate:: Int, expDate:: Int, amt:: Double, curr:: [Char], sen:: Char, rec:: Char} 
				| Zero 
				| One [Char] 
				| Give Contract 
				| And Contract Contract 
				| Or Contract Contract 
				| Truncate Int Contract deriving Show


-- Constructors
Zero = Contract 0 0 0 [] 'A' 'B'
One c = Contract 0 (-1) 1 c 'A' 'B'
Give (Contract acq e a cr s r) = Contract acq e a cr r s
And cn1 cn2 = let 
	curr = if areCurrenciesConsistent cn1 cn2 then currency cn1 else "Error"
	amt = sumOfAmountsFromContract cn1 cn2
	edt = laterExpiryDateFromContract cn1 cn2
	adt = soonerAcquiringDateFromContract cn1 cn2
	sen = sender cn1
	recv = receiver cn1
	in Contract adt edt amt curr sen recv

-- Wrapper functions
-- contract with no rights, obligations, infinite horizon
zero = Zero

-- immediately pays 1 unit. Infinite horizon. 0 as first argument defines "now"
-- -1 as second arg defines infinite expiry
one:: [Char] -> Contract
one curr = One curr

-- Reverses role. Could have simply changed the amount to negative, too.
give:: Contract -> Contract
give con = Give con

-- acquire both contracts. For the composites, adding amount, deciding latest date
and':: Contract -> Contract -> Contract
and' c1 c2 = And c1 c2

-- either of the two contracts. If acquire date of one is in past, take the second
or:: Contract -> Contract -> Contract
or c1 c2 = 
	let 
	contract = if isInPast (acquireDate c1)
		then c2
		else c1
	in 
	contract

-- expires at given date
truncate:: Int -> Contract -> Contract
truncate date c1  = Contract (acquireDate c1) date (amount c1) (currency c1) (sender c1) (receiver c1)


then':: Contract -> Contract -> Contract
then' c1 c2=
	let 
	contract = if isInPast (expiryDate c1)
		then c2
		else c1
	in 
	contract

-- TODO://
scale:: Double -> Contract -> Contract
scale amt contract = c1

-- Acquire at expiry
get:: Contract -> Contract
get c = Contract (expiryDate c) (expiryDate c) (amount c) (currency c) (sender c) (receiver c)

-- Contract to be procured between acquire date and expiry date
anytime:: Contract -> Contract
anytime c = 
	let 
	contract = if (acquireDate c < now && expiryDate c > now) then get c else Zero
	in contract


-- Utility functions

-- Checks for the timestamp to be in the past or future.

-- represents current time simulation in epochs
now = 1500000000

-- Determines if a timestamp is in past or not.
isInPast:: Int -> Bool
isInPast date = date < now

-- Returns the acquire date from the contract
acquireDate:: Contract -> Int
acquireDate (Contract acqDate _ _ _ _ _) = acqDate

-- Returns the expire date from the contract
expiryDate:: Contract -> Int
expiryDate (Contract _ expDate _ _ _ _) = expDate

-- Adds the amount from two contracts
sumOfAmountsFromContract:: Contract -> Contract -> Double
sumOfAmountsFromContract (Contract _ _ amt1 _ _ _ ) (Contract _ _ amt2 _ _ _)  = amt1 + amt2

-- Checks and returns the later expiry date from the two contracts
laterExpiryDateFromContract:: Contract -> Contract -> Int
laterExpiryDateFromContract (Contract _ expiryfirst _ _ _ _ ) (Contract _ expirysecond _ _ _ _) 
	= if expiryfirst > expirysecond then expiryfirst else expirysecond

-- Checks and returns the sooner acquiring date from the two contracts
soonerAcquiringDateFromContract:: Contract -> Contract -> Int
soonerAcquiringDateFromContract (Contract acquiring1 _ _ _ _ _) (Contract acquiring2 _ _ _ _ _ ) 
	= if acquiring1 > acquiring2 then acquiring2 else acquiring1

-- Checks if the currencies in the two contracts are same
areCurrenciesConsistent:: Contract -> Contract -> Bool
areCurrenciesConsistent (Contract _ _ _ c1 _ _ ) (Contract  _ _ _ c2 _ _) = c1 == c2

-- Gets amount from the contract
amount:: Contract -> Double
amount (Contract  _ _ amt _ _ _ ) = amt

-- Gets sender from the contract
sender:: Contract -> Char
sender (Contract _ _ _ _ sen _) = sen

-- Gets receiver from the contract
receiver:: Contract -> Char
receiver (Contract _ _ _ _ _ rece) = rece

-- Gets currency from a contract
currency:: Contract -> [Char]
currency (Contract  _ _ _ currency _ _) = currency

-- Sample Contracts 

-- > Epoch timestamp, amount, currency, paying party, receiving party.
c1 = Contract 1590420037 1590410021 100.00 "EUR" 'A' 'B'
c2 = Contract 1653492037 1853221037 121.50 "EUR" 'B' 'C'
c3 = Contract 1213183621 1813183621 201.15 "EUR" 'C' 'A'
