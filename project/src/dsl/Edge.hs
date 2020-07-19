{-# LANGUAGE MultiParamTypeClasses #-}
module Edge where
    
    import Vertex
    import Attribs

    type EdgeIdentifier = String
    type EdgeAttributes = [EdgeAttribute]

    class VertexType v => EdgeType e v where
        edge:: v -> v -> Maybe EdgeAttributes -> e
    
    class EdgeAttributeType eat e where
        setEdgeAttribute :: e -> eat -> e
        getEdgeAttributes :: e -> Maybe [eat]

    -- class (VertexType v) => EdgeAttributeType eat v where
    --     setEdgeAttribute :: v -> v -> eat -> e
    --     getEdgeAttributes :: v -> Maybe [eat]

    data Edge = Edge Vertex Vertex EdgeIdentifier (Maybe EdgeAttributes) deriving Show

    instance EdgeType Edge Vertex where 
        edge vx vy attributes = Edge vx vy (edgeIdentifierFromVertices vx vy) attributes
        
    instance EdgeAttributeType EdgeAttribute Edge where
        getEdgeAttributes (Edge _ _ _ attrs) = attrs
        setEdgeAttribute(Edge v1 v2 _ Nothing) attr = (edge v1 v2 (Just [attr]))
        setEdgeAttribute (Edge v1 v2 _ (Just attrs)) attr = 
            (edge v1 v2 (Just(attrs ++ [attr])))
    
    -- Helper function
    -- Returns a string with `a-b` for two vertices with identifier a and b
    edgeIdentifierFromVertices (Vertex id1 _) (Vertex id2 _) = id1++"-"++id2