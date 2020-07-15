{-# LANGUAGE MultiParamTypeClasses #-}
module Edge where
    
    import Vertex

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
    

    -- Helper function
    -- Returns a string with `a-b` for two vertices with identifier a and b
    edgeIdentifierFromVertices (Vertex id1 _) (Vertex id2 _) = id1++"-"++id2