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
        setGraphAttribute:: GraphAttribute -> g -> g
        getGraphAttributes:: g -> [GraphAttribute]
        getGraphEdges:: g -> [((String,String),[EdgeAttribute])]
        getGraphVertices:: g -> [(String, [VertexAttribute])]

    data G = G  [(String, [VertexAttribute])]
                [((String,String),[EdgeAttribute])]
                [GraphAttribute] deriving Show
        
    data DotRepr = DotRepr String
    
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
        merge (G xvs xes xattrs) (G yvs yes yattrs) = 
            G zvs zes zattrs where 
                zvs = xvs ++ yvs
                zes = xes ++ yes
                zattrs = xattrs ++ yattrs
        setGraphAttribute ga (G vs es gAttr) = 
            G vs es gAttr' where 
                gAttr' = gAttr ++ [ga]
        getGraphAttributes (G _ _ gAttr) = 
            gAttr
        getGraphVertices (G v _ _ ) = v
        getGraphEdges (G _ e _ ) = e


 
-- Helper entities
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
            error ("Error setting vertex attribute. Vertex with id "
            ++vtxId++" does not exist in the graph.")
        else
            appendVertexAttribute (pairs!!0) vtxAttr

    updateEdges vtx1 vtx2 eAttr eList= do
        let tuples = filterEdge vtx1 vtx2 eList
        if length tuples == 0 then
            error ("Error setting edge attribute. An edge between the vertices '"
            ++vtx1++"' and '"++vtx2++"' does not exist.")
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

    verticesToString vs = do
        let vtxString = ""
        [vtx ++ " " ++ (vertexAttributesToString vAts) | (vtx, vAts) <- vs]

    vertexAttributesToString vAttrs = do
        show [stringReprForVertexAttrib vAttr | vAttr <- vAttrs]

    
--  vertices, edges, etc to try in GHCi
    vs = [("A", [VtxShape Box]), ("B", [VtxArea 2.8, VtxShape Box])]
    va = VtxArea 1.0
    vb = VtxShape Box
    es = [(("A", "B"), [EdShape Dot])]
    ea = EdDirection Forward
    g = vertex "A" 
    ge = edge "C" "D"
    g1 = setVertexAttribute "A" va (g::G)
    g2 = setEdgeAttribute "C" "D" ea (ge::G)
    t = VtxLabelLoc Top
    