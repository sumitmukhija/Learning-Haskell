module Contract where
    data GenericContract = GenericContract Int Int Double [Char] Char Char deriving Show
    data Contract = Zero
                    | One [Char]
                    | Give GenericContract
                    | And GenericContract GenericContract
                    | Truncate Int GenericContract deriving Show


    getGenericContractFromContract:: Contract -> GenericContract
    getGenericContractFromContract Zero = GenericContract 0 0 0 [] 'A' 'B'
    getGenericContractFromContract (One currency) = GenericContract 0 (-1) 1 currency 'A' 'B'
    getGenericContractFromContract (Give genericContract) = genericContract
    getGenericContractFromContract (And gc1 gc2) = let a = soonerAcquiringDateFromContract gc1 gc2
                                                       e = laterExpiryDateFromContract gc1 gc2
                                                       am = sumOfAmountsFromGenericContracts gc1 gc2
                                                       cr = currency gc1
                                                       s =  sender gc1
                                                       r = receiver gc1 in 
                                                           GenericContract a e am cr s r

    give:: GenericContract -> Contract
    give (GenericContract acq e a cr s r) = Give (GenericContract acq e a cr r s)

    -- Utility fns
    sumOfAmountsFromGenericContracts (GenericContract _ _ a1 _ _ _) (GenericContract _ _ a2 _ _ _) = a1+a2
    
    -- Checks and returns the later expiry date from the two contracts
    laterExpiryDateFromContract:: GenericContract -> GenericContract -> Int
    laterExpiryDateFromContract (GenericContract _ expiryfirst _ _ _ _ ) (GenericContract _ expirysecond _ _ _ _) = 
        if expiryfirst > expirysecond then expiryfirst else expirysecond

    -- Checks and returns the sooner acquiring date from the two contracts
    soonerAcquiringDateFromContract:: GenericContract -> GenericContract -> Int
    soonerAcquiringDateFromContract (GenericContract acquiring1 _ _ _ _ _) (GenericContract acquiring2 _ _ _ _ _ ) =
         if acquiring1 > acquiring2 then acquiring2 else acquiring1

    -- Gets currency from a generic contract
    currency:: GenericContract -> [Char]
    currency (GenericContract  _ _ _ currency _ _) = currency
    
    -- Gets sender from the generic contract
    sender:: GenericContract -> Char
    sender (GenericContract _ _ _ _ sen _) = sen

    -- Gets receiver from the  generic contract
    receiver:: GenericContract -> Char
    receiver (GenericContract _ _ _ _ _ rece) = rece
    
    -- Sample generic contracts
    c1 = GenericContract 1590420037 1590410021 100.00 "EUR" 'A' 'B'
    c2 = GenericContract 1653492037 1853221037 121.50 "EUR" 'B' 'C'