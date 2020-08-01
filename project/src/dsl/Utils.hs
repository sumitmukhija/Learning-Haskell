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
