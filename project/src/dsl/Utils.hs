module Utils where

    import Attribs
    
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
        let vtxListWithoutVtx = removeVertexFromExistingVertexList vtxId vtxList
        if length pairs == 0 then
            error ("Error setting vertex attribute. Vertex with id "
            ++vtxId++" does not exist in the graph.")
        else
            vtxListWithoutVtx ++ (appendVertexAttribute (pairs!!0) vtxAttr)

    removeVertexFromExistingVertexList vtxId vtxList = 
        [(vtx, vAts) | (vtx, vAts) <- vtxList, vtx /= vtxId]

    updateEdges vtx1 vtx2 eAttr eList= do
        let tuples = filterEdge vtx1 vtx2 eList
        let edgeListWithoutSelectedEdge = removeEdgeFromExistingEdgeList vtx1 vtx2 eList
        if length tuples == 0 then
            error ("Error setting edge attribute. An edge between the vertices '"
            ++vtx1++"' and '"++vtx2++"' does not exist.")
        else
            edgeListWithoutSelectedEdge ++ appendEdgeAttribute (tuples!!0) eAttr
    
    removeEdgeFromExistingEdgeList vtx1 vtx2 es = 
        [((v1, v2), eAts) | ((v1, v2), eAts) <- es, (v1, v2) /= (vtx1, vtx2)]
    
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
        [vtx ++ "  [" ++ (vertexAttributesToString vAts) ++ "]" | 
            (vtx, vAts) <- vs]

    vertexAttributesToString vAttrs = 
        concat [stringReprForVertexAttrib vAttr | vAttr <- vAttrs]

    edgesToString es = [v1 ++ " -> " ++ v2 ++ " ["++ 
            (edgeAttributesToString eAts) ++"]"
            | ((v1, v2), eAts) <- es ]
        
    edgeAttributesToString eAttrs = do
        concat [stringReprForEdgeAttrib eAttr ++ "," | eAttr <- eAttrs]
    
    -- TODO: BUG!!
    graphAttributesToString [] = [unwords ["graph G"]]
    graphAttributesToString grfAtrs = do
        [unwords [stringReprForGraphAttrib grfAtr | (grfAtr) <- grfAtrs]]

    mergeEachVertexPair vtxPair [] = undefined
    mergeEachVertexPair vtxPair ys = do
        let (vtxX, vtxAttrX) = vtxPair
        let [(vtxY, vtxAttrY)] = filterVertex vtxX ys
        (vtxX, vtxAttrX ++ vtxAttrY)
        
    mergeEachEdgeTuple edgeTuple ys = do
        let ((vtxX1, vtxX2), eAttrX) = edgeTuple
        let [(_ , eAttrY)] = filterEdge vtxX1 vtxX2 ys
        ((vtxX1, vtxX2), eAttrX ++ eAttrY)

    mergeVertices xs ys  =  (mergeCommonVertices xs ys) ++ 
                            (nonCommonVertices xs ys) ++ 
                            (nonCommonVertices ys xs)
    
    commonVertices xs ys = filter(\(vx, vax) -> vx `elem` (map fst ys)) xs

    mergeCommonVertices xs ys =  
        map (\vtxPair -> mergeEachVertexPair vtxPair ys) 
        (commonVertices xs ys)

    nonCommonVertices l1 l2 = filter(\(vx, vax) -> vx `notElem` (map fst l1)) l2

    mergeEdges xs ys =  (mergeCommonEdges xs ys) ++ 
                        (nonCommonEdges xs ys) ++
                        (nonCommonEdges ys xs)

    commonEdges xs ys = filter(\((vx1, vx2), eax) -> (vx1, vx2) `elem` (map fst ys)) xs

    mergeCommonEdges xs ys =
        map (\edgeTuple -> mergeEachEdgeTuple edgeTuple ys)
        (commonEdges xs ys)
    
    nonCommonEdges l1 l2 = filter(\((vx1, vx2), eax) -> (vx1, vx2) `notElem` (map fst l1)) l2

    getConnectedNodes es start = 
        [ vb | ((va, vb), _) <- es, va == start] ++ [ va | ((va, vb), _) <- es, vb == start] 

    getIsReachable es start end = 
        undefined