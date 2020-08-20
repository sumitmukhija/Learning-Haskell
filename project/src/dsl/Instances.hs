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
        setEdgeAttribute vtx1 vtx2 eAttr bdt = 
            if pathExists vtx1 vtx2 bdt == True then undefined
            else bdt
        getEdgeAttributes vtx1 vtx2 bdt = undefined

        -- Graph
        empty = EmptyBDT

    -- BDT utility
    findVertexAttributesForDT vtxId EmptyBDT = []
    findVertexAttributesForDT vtxId (BDTNode (root, rootAttr) (left, lAttrs) (right, rAttrs)) = 
        if vtxId == root then rootAttr else 
            (findVertexAttributesForDT vtxId left) ++ (findVertexAttributesForDT vtxId right)

    updateVertexPairforDT vtxId EmptyBDT newPair = EmptyBDT
    updateVertexPairforDT vtxId (BDTNode (root, rootAttr) (left, lAttrs) (right, rAttrs)) newPair= 
        if vtxId == root 
            then 
                BDTNode newPair (left, lAttrs) (right, rAttrs)
            else
                BDTNode (root, rootAttr) 
                (updateVertexPairforDT vtxId left newPair, lAttrs)
                (updateVertexPairforDT vtxId right newPair, rAttrs)

    paths (EmptyBDT) = [[]]
    paths (BDTNode (root, rootAttr) (left, lAttrs) (right, rAttrs)) = 
        map (root:) (paths left ++ paths right)

    pathExists from to dt = 
        if length (filter (\x -> x == [from, to] || x == [to, from]) (paths dt)) > 0
            then True
            else False
    