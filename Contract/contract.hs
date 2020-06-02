module Contract where
    data GenericContract = GenericContract Int Int Double [Char] Char Char deriving Show
    data Contract = Zero
                    | One [Char]
                    | Give Contract
                    | And Contract Contract deriving Show


    -- Function that converts contract to generic contract
    genericContractFromContract:: Contract -> GenericContract
    genericContractFromContract Zero = GenericContract 0 0 0 [] 'A' 'B'
    genericContractFromContract (One currency) = GenericContract 0 0 1 currency 'A' 'B'
    genericContractFromContract (Give contract) = give(genericContractFromContract contract)
    genericContractFromContract (And c1 c2) = 
                            and' (genericContractFromContract c1) (genericContractFromContract c2)
    
    -- implementation methods with generic contracts
    and' gc1 gc2 = let 
                     a = soonerAcquiringDateFromContract gc1 gc2
                     e = laterExpiryDateFromContract gc1 gc2
                     amt = sumOfAmounts gc1 gc2
                     curr = currency gc1
                     s = sender gc1
                     r = receiver gc1
                     in GenericContract a e amt curr s r

    give (GenericContract a e amt c s1 r1) =  GenericContract a e amt c r1 s1


    -- Utility methods
    laterExpiryDateFromContract:: GenericContract -> GenericContract -> Int
    laterExpiryDateFromContract (GenericContract _ expiryfirst _ _ _ _ ) (GenericContract _ expirysecond _ _ _ _) = 
        if expiryfirst > expirysecond then expiryfirst else expirysecond

    soonerAcquiringDateFromContract:: GenericContract -> GenericContract -> Int
    soonerAcquiringDateFromContract (GenericContract acquiringFirst _ _ _ _ _) (GenericContract acquiringSecond _ _ _ _ _ ) =
         if acquiringFirst > acquiringSecond then acquiringSecond else acquiringFirst

    sumOfAmounts (GenericContract _ _ amountFirst _ _ _) (GenericContract _ _ amountSecond _ _ _ ) = amountFirst + amountSecond
    
    -- Getters
    currency (GenericContract _ _ _ c _ _) = c

    sender (GenericContract _ _ _ _ s _) = s
    
    receiver (GenericContract _ _ _ _ _ r) = r
    
    
    -- Test contracts
    o = One "GBP"
    z = Zero
    o' = One "GBP"
