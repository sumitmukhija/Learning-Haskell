{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module Edge where
    
    import Vertex
    import Attribs

    type EdgeIdentifier = String
    type EdgeAttributes = [EdgeAttribute]
    type EdgeBundle = (VertexIdentifier, VertexIdentifier, Maybe EdgeAttributes)

    class VertexType v => EdgeType e v where
        edge:: v -> v -> Maybe EdgeAttributes -> e
        edgeBundleFromEdge:: e -> EdgeBundle
    
    class EdgeAttributeType eat e where
        setEdgeAttribute :: e -> eat -> e
        getEdgeAttributes :: e -> Maybe [eat]

    data Edge = Edge Vertex Vertex EdgeIdentifier (Maybe EdgeAttributes) deriving Show

    instance EdgeType Edge Vertex where 
        edge vx vy attributes = 
            Edge vx vy (edgeIdentifierFromVertices vx vy) attributes
        edgeBundleFromEdge (Edge (Vertex id1 _) (Vertex id2 _) eId eAttrs) = 
            (id1, id2, eAttrs)
        
    instance EdgeAttributeType EdgeAttribute Edge where
        getEdgeAttributes (Edge _ _ _ attrs) = attrs
        setEdgeAttribute(Edge v1 v2 _ Nothing) attr = (edge v1 v2 (Just [attr]))
        setEdgeAttribute (Edge v1 v2 _ (Just attrs)) attr = 
            (edge v1 v2 (Just(attrs ++ [attr])))
    
    -- Helper function
    -- Returns a string with `a-b` for two vertices with identifier a and b
    edgeIdentifierFromVertices (Vertex id1 _) (Vertex id2 _) = id1++"-"++id2