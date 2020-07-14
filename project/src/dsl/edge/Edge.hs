{-# LANGUAGE MultiParamTypeClasses #-}
module Edge where
    
    import Vertex
    import Utils

    type EdgeIdentifier = String
    type EdgeAttributes = [EdgeAttribute]

    class VertexType v => EdgeType e v where
        edge:: v -> v -> EdgeAttributes -> e
    
    class EdgeAttributeType eat e where
        setEdgeAttribute :: e -> eat -> e
        getEdgeAttributes :: e -> [eat]

    data Edge = Edge Vertex Vertex EdgeIdentifier EdgeAttributes deriving Show
    data EdgeAttribute = EdgeAttribute String deriving Show

    instance EdgeType Edge Vertex where 
        edge vx vy attributes = Edge vx vy (edgeIdentifierFromVertices vx vy) attributes
        
    instance EdgeAttributeType EdgeAttribute Edge where
        getEdgeAttributes (Edge _ _ _ attrs) = attrs
        setEdgeAttribute (Edge v1 v2 _ attrs) attr = 
            (edge v1 v2 (attrs ++ [attr]))
    