module Types where 

    import Attribs

    data G = G  [(String, [VertexAttribute])]
                [((String,String),[EdgeAttribute])]
                [GraphAttribute] deriving Show

    data BDT = EmptyBDT | 
               BDTNode (String, [VertexAttribute]) 
               (BDT, [EdgeAttribute]) 
               (BDT, [EdgeAttribute]) 
               deriving (Show, Eq)
               