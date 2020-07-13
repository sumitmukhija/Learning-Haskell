{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies #-}
module Edge where
    
    import Vertex
    import Utils
    import Alias

    class VertexType v => EdgeType e v | v -> e where
        edge:: v -> v -> e
    
    data Edge = Edge Vertex Vertex EdgeIdentifier deriving Show

    instance EdgeType Edge Vertex where 
        edge vx vy = Edge vx vy (edgeIdentifierFromVertices vx vy)
        