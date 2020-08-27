{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Edge where
    
    import Vertex
    import Attribs

    type EdgeIdentifier = String
    type EdgeAttributes = [EdgeAttribute]
    type EdgeBundle = (VertexIdentifier, VertexIdentifier, Maybe EdgeAttributes)

    class VertexType v => EdgeType e v | v -> e where
        edge:: v -> v -> Maybe EdgeAttributes -> e
        edgeBundleFromEdge:: e -> EdgeBundle
    
    class EdgeAttributeType eat e | e -> eat where
        setEdgeAttribute :: e -> eat -> e
        getEdgeAttributes :: e -> Maybe [eat]

    data Edge = Edge Vertex Vertex EdgeIdentifier (Maybe EdgeAttributes) deriving Show

    instance EdgeType Edge Vertex where 
        edge vx vy attributes = 
            Edge vx vy (edgeIdentifierFromVertices vx vy) attributes
        edgeBundleFromEdge (Edge (Vertex vid1 _) (Vertex vid2 _) eId eAts) =
            undefined
        
    instance EdgeAttributeType EdgeAttribute Edge where
        getEdgeAttributes (Edge _ _ _ attrs) = attrs
        setEdgeAttribute(Edge v1 v2 _ Nothing) attr = (edge v1 v2 (Just [attr]))
        setEdgeAttribute (Edge v1 v2 _ (Just attrs)) attr = 
            (edge v1 v2 (Just(attrs ++ [attr])))

