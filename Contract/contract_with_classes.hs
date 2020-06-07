module Contract where

    data Contract = Zero
                    | One [Char]
                    | Give Contract
                    | And Contract Contract deriving Show

    -- zero = Zero
    -- one currency = One currency  --  one = One
    -- give c = Give c
    -- and' c1 c2 = And c1 c2

    class ContractDSL c where
      zero :: c
      one  :: [Char] -> c
      give :: c -> c
      and' :: c -> c -> c

    instance ContractDSL Contract  where
       zero = Zero
       one c = One c
       give c = error "???"
       and' c1 c2 = undefined


    data GenericContract = GenericContract Int Int Double [Char] Char Char deriving Show

    instance ContractDSL GenericContract where
      zero = GenericContract 0 0 0 [] 'A' 'B'
      one currency = GenericContract 0 0 1 currency 'A' 'B'
      give contract = giveGen contract
      and' c1 c2 = andGen c1 c2

    -- Function that converts contract to generic contract
    genericContractFromContract:: Contract -> GenericContract
    genericContractFromContract Zero = GenericContract 0 0 0 [] 'A' 'B'
    genericContractFromContract (One currency) = GenericContract 0 0 1 currency 'A' 'B'
    genericContractFromContract (Give contract) = giveGen(genericContractFromContract contract)
    genericContractFromContract (And c1 c2) =
                            andGen (genericContractFromContract c1) (genericContractFromContract c2)

    -- implementation methods with generic contracts
    andGen gc1 gc2 = let
                     a = soonerAcquiringDateFromContract gc1 gc2
                     e = laterExpiryDateFromContract gc1 gc2
                     amt = sumOfAmounts gc1 gc2
                     curr = currency gc1
                     s = sender gc1
                     r = receiver gc1
                     in GenericContract a e amt curr s r

    giveGen (GenericContract a e amt c s1 r1) =  GenericContract a e amt c r1 s1


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
