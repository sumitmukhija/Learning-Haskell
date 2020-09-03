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

    degreeOfNode node (BDTNode (root, rootAttr) (left, lEdgeAttrs) (right, rEdgeAttrs)) 
        = if root == node
            then degreeOfRootNode (BDTNode (root, rootAttr) (left, lEdgeAttrs) (right, rEdgeAttrs))
          else
              degreeOfRootNode (left) + degreeOfRootNode (right)

    edgesForDT EmptyBDT = [(("",""), [])]
    edgesForDT (BDTNode (root, _) (left, rtlAtr) (right, rtrAtr)) = 
        [((root, rootNode(left)), rtlAtr),((root, rootNode(right)), rtrAtr)] 
        ++ (edgesForDT left) ++ (edgesForDT right)

    filterValidConnectedEdges tree = filteredEdges where 
        listOfAllEdges = edgesForDT tree
        filteredEdges = filter (\((x,y), z) -> (x,y) /= ("","") && y /= "" && x /= y) listOfAllEdges 


    canJoin t1 t2 = 
        rootNode(t2) `elem` [ x | (x, y) <- (verticesForDT t1)] &&
        (degreeOfNode (rootNode(t2)) t1) < 2

    joinTrees EmptyBDT t2 = EmptyBDT
    joinTrees (BDTNode (root, rootAttr) (left, lEdgeAttrs) (right, rEdgeAttrs)) t2 = 
        if root == rootNode(t2) && left == EmptyBDT then
            insertLeft (BDTNode (root, rootAttr) (left, lEdgeAttrs) (right, rEdgeAttrs)) t2
        else
            if root == rootNode(t2) && right == EmptyBDT then
                insertRight (BDTNode (root, rootAttr) (left, lEdgeAttrs) (right, rEdgeAttrs)) t2
            else 
                BDTNode (root, rootAttr) ((joinTrees left t2),[]) ((joinTrees right t2),[])
    