module BDTUtils where
        -- BDT utility

    import Types

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

    left EmptyBDT = EmptyBDT
    left (BDTNode (root, _) (left, _) (_, _)) = left

    right EmptyBDT = EmptyBDT
    right (BDTNode (root, _) (_, _) (right, _)) = right

    insertLeft (BDTNode rootBundle leftBundle rightBundle) left = 
        BDTNode rootBundle (left,[]) rightBundle
    
    insertRight (BDTNode rootBundle leftBundle rightBundle) right = 
        BDTNode rootBundle leftBundle (right, [])


    degreeOfRootNode EmptyBDT = 0
    degreeOfRootNode (BDTNode (root, _) (EmptyBDT, _) (EmptyBDT, _)) = 0
    degreeOfRootNode (BDTNode (root, _) (EmptyBDT, _) (r, _)) = 1
    degreeOfRootNode (BDTNode (root, _) (l, _) (EmptyBDT, _)) = 1
    degreeOfRootNode (BDTNode (root, _) (l, _) (r, _)) = 2

    getConnectedEdgesForDT EmptyBDT = [(("",""), [])]
    getConnectedEdgesForDT (BDTNode (root, _) (left, rtlAtr) (right, rtrAtr)) = 
        [((root, rootNode(left)), rtlAtr),((root, rootNode(right)), rtrAtr)] 
        ++ (getConnectedEdgesForDT left) ++ (getConnectedEdgesForDT right)

    filterValidConnectedEdges tree = filteredEdges where 
        listOfAllEdges = getConnectedEdgesForDT tree
        filteredEdges = filter (\((x,y), z) -> (x,y) /= ("","") && y /= "") listOfAllEdges

    canMerge t1 t2 = (rootNode(t1) == rootNode(t2)) && (degreeOfRootNode(t1) + degreeOfRootNode(t2) <= 2)

    combine t1 t2 = 
        if left(t2) /= EmptyBDT then
            if left(t1) == EmptyBDT then
                insertLeft t1 (left t2)
            else
                if right(t1) == EmptyBDT then
                    insertRight t1 (left t2)
                else 
                    t1
        else
            if right(t2) /= EmptyBDT && left(t1) == EmptyBDT then
                insertLeft t1 (right t2)
            else
                if right(t2) /= EmptyBDT && right(t1) == EmptyBDT then 
                    insertRight t1 (right t2)
                else t1
