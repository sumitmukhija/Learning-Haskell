data Contract = Contract {acqDate:: Int, expDate:: Int, amount:: Double, currency:: [Char], sender:: Char, receiver:: Char} | Zero | One [Char] | Give Contract | And Contract Contract | Or Contract Contract | Truncate Int Contract deriving Show

-- contract with no rights, obligations
-- infinite horizon
_zero = Zero

-- immediately pays 1 unit. Infinite horizon. 0 as first argument defines "now"
-- -1 as second arg defines infinite expiry
_one:: [Char] -> Contract
_one currency = Contract 0 (-1) 1 currency 'A' 'B'

-- Reverses role. Could have simply changed the amount to negative, too.
_give:: Contract -> Contract
_give (Contract aTimestamp eTimestamp amount currency sender receiver) = 
	let
	newAmount = (-amount)
	in 
	Contract aTimestamp eTimestamp newAmount currency sender receiver

-- acquire both contracts. For the composites, adding amount, deciding latest date
_and:: Contract -> Contract -> Contract
_and c1 c2 =
	let 
	curr = if _areCurrenciesConsistent c1 c2 then _currency c1 else "Error"
	amt = _sumOfAmountsFromContract c1 c2
	edt = _laterExpiryDateFromContract c1 c2
	adt = _soonerAcquiringDateFromContract c1 c2
	sen = _sender c1
	rec = _receiver c1
	in Contract adt edt amt curr sen rec

-- either of the two contracts. If acquire date of one is in past, take the second
_or:: Contract -> Contract -> Contract
_or c1 c2 = 
	let 
	contract = if _isInPast (_acquireDate c1)
		then c2
		else c1
	in 
	contract

-- expires at given date
_truncate:: Int -> Contract -> Contract
_truncate date c1  = Contract (_acquireDate c1) date (_amount c1) (_currency c1) (_sender c1) (_receiver c1)


_then:: Contract -> Contract -> Contract
_then c1 c2=
	let 
	contract = if _isInPast (_expiryDate c1)
		then c2
		else c1
	in 
	contract

-- TODO://
_scale:: Double -> Contract -> Contract
_scale amt contract = c1

-- Acquire at expiry
_get:: Contract -> Contract
_get c = Contract (_expiryDate c) (_expiryDate c) (_amount c) (_currency c) (_sender c) (_receiver c)

-- Contract to be procured between acquire date and expiry date
_anytime:: Contract -> Contract
_anytime c = 
	let 
	contract = if (_acquireDate c < _now && _expiryDate c > _now) then _get c else Zero
	in contract


-- Utility functions

-- Checks for the timestamp to be in the past or future.

-- represents current time simulation in epochs
_now = 1500000000

-- Determines if a timestamp is in past or not.
_isInPast:: Int -> Bool
_isInPast date = date < _now

-- Returns the acquire date from the contract
_acquireDate:: Contract -> Int
_acquireDate (Contract acqDate _ _ _ _ _) = acqDate

-- Returns the expire date from the contract
_expiryDate:: Contract -> Int
_expiryDate (Contract _ expDate _ _ _ _) = expDate

-- Adds the amount from two contracts
_sumOfAmountsFromContract:: Contract -> Contract -> Double
_sumOfAmountsFromContract (Contract _ _ amount1 _ _ _ ) (Contract _ _ amount2 _ _ _ )  = amount1 + amount2

-- Checks and returns the later expiry date from the two contracts
_laterExpiryDateFromContract:: Contract -> Contract -> Int
_laterExpiryDateFromContract (Contract _ expiry_first _ _ _ _) (Contract _ expiry_second _ _ _ _) = if expiry_first > expiry_second then expiry_first else expiry_second

-- Checks and returns the sooner acquiring date from the two contracts
_soonerAcquiringDateFromContract:: Contract -> Contract -> Int
_soonerAcquiringDateFromContract (Contract acquiring1 _ _ _ _ _) (Contract acquiring2 _ _ _ _ _) = if acquiring1 > acquiring2 then acquiring2 else acquiring1

-- Checks if the currencies in the two contracts are same
_areCurrenciesConsistent:: Contract -> Contract -> Bool
_areCurrenciesConsistent (Contract _ _ _ c1 _ _) (Contract _ _ _ c2 _ _) = c1 == c2

-- Gets amount from the contract
_amount:: Contract -> Double
_amount (Contract _ _ amount _ _ _) = amount

-- Gets sender from the contract
_sender:: Contract -> Char
_sender (Contract _ _ _ _ sender _) = sender

-- Gets receiver from the contract
_receiver:: Contract -> Char
_receiver (Contract _ _ _ _ _ receiver) = receiver

-- Gets currency from a contract
_currency:: Contract -> [Char]
_currency (Contract _ _ _ currency _ _) = currency


-- Sample Contracts 

-- > Epoch timestamp, amount, currency, paying party, receiving party.
c1 = Contract 1590420037 1590410021 100.00 "EUR" 'A' 'B'
c2 = Contract 1653492037 1853221037 121.50 "EUR" 'B' 'C'
c3 = Contract 1213183621 1813183621 201.15 "EUR" 'C' 'A'
