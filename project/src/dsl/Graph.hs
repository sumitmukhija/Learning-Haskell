module Graph where

    import Attribs

    class Graph g where
        -- Vertex
        vertex:: String -> g
        setVertexAttribute:: String -> VertexAttribute -> g -> g
        getVertexAttributes:: String -> g -> [VertexAttribute]
        
        -- Edge
        edge:: String -> String -> g
        setEdgeAttribute:: String -> String -> EdgeAttribute -> g -> g
        getEdgeAttributes:: String -> String -> g -> [EdgeAttribute]
    
        -- Graph
        merge:: g -> g -> g

    data G = G  [(String, [VertexAttribute])]
                [((String,String),[EdgeAttribute])]
                [GraphAttribute] deriving Show
    
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
        edge vtx1 vtx2 = G [] [((vtx1, vtx2), [])] []
        setEdgeAttribute vtx1 vtx2 eAttr (G vs es as)=
            G vs es' as where 
                es' = updateEdges vtx1 vtx2 eAttr es
        getEdgeAttributes vtx1 vtx2 (G _ es _) = do
            let tuples = filterEdge vtx1 vtx2 es
            if length tuples == 0 then undefined
            else extractAttributesFromNonEmptyEdge tuples


        -- Graph
        merge (G xvs xes xattrs) (G yvs yes yattrs) = 
            G zvs zes zattrs where 
                zvs = xvs ++ yvs
                zes = xes ++ yes
                zattrs = xattrs ++ yattrs
    

-- Helper functions

    vs = [("A", [VtxShape Box]), ("B", [VtxShape Box])]
    va = VtxArea 1.0
    vb = VtxShape Box
    es = [(("A", "B"), [EdShape Dot])]
    ea = EdDirection Forward
    g = vertex "A" 
    ge = edge "C" "D"
    g1 = setVertexAttribute "A" va (g::G)
    g2 = setEdgeAttribute "C" "D" ea (ge::G)

    appendVertexAttribute vertexPair vtxAttr = do
        let (vtx, vAts) = vertexPair
        let vAts' = vAts ++ [vtxAttr]
        let pair = (vtx, vAts')
        return pair
    
    appendEdgeAttribute edgeTuple edgAttr = do
        let ((v1, v2), eAts) = edgeTuple
        let eAts' = eAts ++ [edgAttr]
        let tuple = ((v1,v2), eAts')
        return tuple

    filterVertex vtxId vtxList= 
        [(vtx, vAts) | (vtx, vAts) <- vtxList, vtx == vtxId]
    
    filterEdge vtx1 vtx2 eList= 
        [((v1, v2), eAts) | ((v1, v2), eAts) <- eList, v1 == vtx1, v2 == vtx2]

    updateVertices vtxId vtxAttr vtxList= do
        let pairs = filterVertex vtxId vtxList
        if length pairs == 0 then
            -- TODO:
            undefined
        else
            appendVertexAttribute (pairs!!0) vtxAttr

    updateEdges vtx1 vtx2 eAttr eList= do
        let tuples = filterEdge vtx1 vtx2 eList
        if length tuples == 0 then
            -- TODO:
            undefined
        else
            appendEdgeAttribute (tuples!!0) eAttr
    
    getAttributesFromPair pair= do
        let (_ , attributes) = pair
        return attributes

    extractAttributesFromNonEmptyVertex vtxList=do
        let (_, vAttrs) = vtxList!!0
        return vAttrs!!0
    
    extractAttributesFromNonEmptyEdge eList=do
        let (_ , eAttrs) = eList!!0
        return eAttrs!!0