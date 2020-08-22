module Instances where

    import Graph
    import Attribs
    import Utils

    data G = G  [(String, [VertexAttribute])]
                [((String,String),[EdgeAttribute])]
                [GraphAttribute] deriving Show
    

    data BDT = EmptyBDT | 
               BDTNode (String, [VertexAttribute]) 
               (BDT, [EdgeAttribute]) 
               (BDT, [EdgeAttribute]) 
               deriving (Show, Eq)

    instance Graph G where
        -- Vertex
        vertex vtxId = G [(vtxId, [])] [] []
        setVertexAttribute vtxId vtxAttr (G vs es as)=
            G vs' es as where 
                vs' = updateVertices vtxId vtxAttr vs
        getVertexAttributes vtxId (G vs _ _) = do
            let pairs = filterVertex vtxId vs
            if length pairs == 0 then undefined
            else extractAttributesFromNonEmptyVertex pairs

        -- Edge
        edge vtx1 vtx2 = G [(vtx1, []), (vtx2, [])] [((vtx1, vtx2), [])] []
        setEdgeAttribute vtx1 vtx2 eAttr (G vs es as)=
            G vs es' as where 
                es' = updateEdges vtx1 vtx2 eAttr es
        getEdgeAttributes vtx1 vtx2 (G _ es _) = do
            let tuples = filterEdge vtx1 vtx2 es
            if length tuples == 0 then undefined
            else extractAttributesFromNonEmptyEdge tuples

        -- Graph
        empty = G [] [] []
        merge (G xvs xes xattrs) (G yvs yes yattrs) = 
            G zvs zes zattrs where 
                zvs = mergeVertices xvs yvs
                zes = mergeEdges xes yes
                zattrs = xattrs ++ yattrs
        setGraphAttribute ga (G vs es gAttr) = 
            G vs es gAttr' where 
                gAttr' = gAttr ++ [ga]
        getGraphAttributes (G _ _ gAttr) = 
            gAttr
        getGraphVertices (G v _ _ ) = v
        getGraphEdges (G _ e _ ) = e
        

    instance Graph BDT where 
        -- Vertex
        vertex vtxId = BDTNode (vtxId, []) (EmptyBDT,[]) (EmptyBDT,[])
        
        getVertexAttributes vtxId dt = findVertexAttributesForDT vtxId dt
        
        setVertexAttribute vtxId vtxAttr dt = modDt where 
            vtxAttrsUpdate = (findVertexAttributesForDT vtxId dt) ++ [vtxAttr]
            newPair = (vtxId, vtxAttrsUpdate)
            modDt = updateVertexPairforDT vtxId dt newPair

        -- Edge
        edge parent child = BDTNode (parent, []) 
            (vertex child, []) 
            (empty, []) 
        setEdgeAttribute vtx1 vtx2 eAttr bdt = modDt where
            validEdges = filterValidConnectedEdges bdt
            (_, attribs) = (filter (\((x,y), z) -> (x,y) == (vtx1,vtx2)) validEdges) !! 0
            modDt = updateEdgeAttributesforDT vtx1 vtx2 bdt (attribs ++ [eAttr])
        getEdgeAttributes vtx1 vtx2 bdt = attribs where 
            validEdges = filterValidConnectedEdges bdt
            edge = filter (\((x,y), z) -> (x,y) == (vtx1,vtx2)) validEdges
            ((x,y), attribs) = edge !! 0

        -- Graph
        empty = EmptyBDT
        merge t1 t2 = error "Cannot merge two binary decision trees."
        setGraphAttribute = error "Cannot set graph attribute for a decision tree"
        getGraphAttributes bdt = [(Strict True), (Directed False), (GraphName "DecisionTree")]
        getGraphEdges tree = filterValidConnectedEdges tree
        getGraphVertices tree = verticesForDT tree

    -- BDT utility
    findVertexAttributesForDT vtxId EmptyBDT = []
    findVertexAttributesForDT vtxId (BDTNode (root, rootAttr) (left, lEdgeAttrs) (right, rEdgeAttrs)) = 
        if vtxId == root then rootAttr else 
            (findVertexAttributesForDT vtxId left) ++ (findVertexAttributesForDT vtxId right)

    updateVertexPairforDT vtxId EmptyBDT newPair = EmptyBDT
    updateVertexPairforDT vtxId (BDTNode (root, rootAttr) (left, lEdgeAttrs) (right, rEdgeAttrs)) newPair= 
        if vtxId == root 
            then 
                BDTNode newPair (left, lEdgeAttrs) (right, rEdgeAttrs)
            else
                BDTNode (root, rootAttr) 
                (updateVertexPairforDT vtxId left newPair, lEdgeAttrs)
                (updateVertexPairforDT vtxId right newPair, rEdgeAttrs)

    updateEdgeAttributesforDT _ _ EmptyBDT _ = EmptyBDT
    updateEdgeAttributesforDT v1 v2 (BDTNode (root, rootAttr) (left, lEdgeAttrs) (right, rEdgeAttrs)) attribs = 
        if root == v1 && rootNode(left) == v2 then 
            BDTNode (root, rootAttr) (left, attribs) (right, rEdgeAttrs)
        else 
            BDTNode (root, rootAttr) 
                    (updateEdgeAttributesforDT v1 v2 left attribs, lEdgeAttrs)
                    (updateEdgeAttributesforDT v1 v2 right attribs, lEdgeAttrs)

    verticesForDT (EmptyBDT) = []
    verticesForDT (BDTNode (root, rootAttr) (left, lEdgeAttrs) (right, rEdgeAttrs)) = 
        [(root,rootAttr)] ++ verticesForDT left ++ verticesForDT right

    rootNode EmptyBDT = ""
    rootNode (BDTNode (root, _) (left, _) (right, _)) = root

    getConnectedEdgesForDT EmptyBDT = [(("",""), [])]
    getConnectedEdgesForDT (BDTNode (root, _) (left, rtlAtr) (right, rtrAtr)) = 
        [((root, rootNode(left)), rtlAtr),((root, rootNode(right)), rtrAtr)] 
        ++ (getConnectedEdgesForDT left) ++ (getConnectedEdgesForDT right)

    filterValidConnectedEdges tree = filteredEdges where 
        listOfAllEdges = getConnectedEdgesForDT tree
        filteredEdges = filter (\((x,y), z) -> (x,y) /= ("","") && y /= "") listOfAllEdges
    