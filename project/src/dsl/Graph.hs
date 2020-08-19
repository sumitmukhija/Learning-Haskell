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
        empty:: g
        merge:: g -> g -> g
        setGraphAttribute:: GraphAttribute -> g -> g
        getGraphAttributes:: g -> [GraphAttribute]
        getGraphEdges:: g -> [((String,String),[EdgeAttribute])]
        getGraphVertices:: g -> [(String, [VertexAttribute])]

    -- Utility functions
    numberOfVertices:: Graph g => g -> Int
    numberOfVertices g = length $ (getGraphVertices g)
    
    numberOfEdges:: Graph g => g -> Int
    numberOfEdges g = length $ (getGraphEdges g)

    connectedNodes:: Graph g => g -> String -> [String]
    connectedNodes g start = adjacentNodes where
        es = getGraphEdges g
        adjacentNodes = 
            [ vb | ((va, vb), _) <- es, va == start] ++ 
            [ va | ((va, vb), _) <- es, vb == start] 

    hasLoop:: Graph g => g -> Bool
    hasLoop g = loopInGraph where
        es = getGraphEdges g
        loopInGraph = length [va | ((va, vb), _) <- es, va == vb] > 0

    prettyPrint:: Graph g => g -> IO ()
    prettyPrint g = putStrLn prettyPrintedGraph where
        vs = getGraphVertices g
        es = getGraphEdges g
        printedVertices = 
            "\nVertices:\n\n" ++ unlines ["- " ++ vId | (vId, _) <- vs]
        printedEdges = 
            "\nEdges between :\n\n" ++ 
            unlines ["- " ++ v1 ++" and " ++ v2 | ((v1, v2), _) <- es]
        prettyPrintedGraph = printedVertices ++ printedEdges

    mergeMultipleGraphs:: Graph g => [g] -> g
    mergeMultipleGraphs graphs = foldr (\acc x -> merge acc x) (empty) graphs

    generateDOTFile:: Graph g => g -> IO ()
    generateDOTFile g = putStrLn ((unlines (graphAttributesToString (getGraphAttributes g) ++ 
                                        verticesToString (getGraphVertices g) ++ 
                                        edgesToString (getGraphEdges g) (isGraphDirected (getGraphAttributes g)))
                                        ++"}"))
        
    isGraphDirected graphAttrs = 
        if length [attr | attr <- graphAttrs, attr == (Directed True)] > 0
            then True
            else False

    verticesToString vs = 
        ["\""++vtx ++ "\"  [" ++ (vertexAttributesToString vAts) ++ "]" | 
            (vtx, vAts) <- vs]
    
    vertexAttributesToString vAttrs = 
        concat [stringReprForVertexAttrib vAttr | vAttr <- vAttrs]

    edgesToString es isDirected = 
        if isDirected == True then directedEdgesToString es
        else nondirectedEdgesToString es
    
    directedEdgesToString es = 
        ["\""++ v1 ++"\"" ++ " -> " ++ "\"" ++ v2 ++ "\"" ++ " ["++ 
            (edgeAttributesToString eAts) ++"]"
            | ((v1, v2), eAts) <- es ]
    
    nondirectedEdgesToString es = ["\"" ++ v1 ++"\"" ++ " -- " ++ "\""++ v2 ++"\"" ++ " ["++ 
            (edgeAttributesToString eAts) ++"]"
            | ((v1, v2), eAts) <- es ]
    
        
    edgeAttributesToString eAttrs = 
        concat [stringReprForEdgeAttrib eAttr ++ "," | eAttr <- eAttrs]
    
    graphAttributesToString [] = 
        [unwords ["graph G{"]]
    graphAttributesToString grfAtrs = 
        [unwords [(strictGraph grfAtr) ++ (directedGraph grfAtr) | (grfAtr) <- grfAtrs]]

    strictGraph (Strict isStrict) = if isStrict == True then "strict " else ""
    strictGraph _ = ""

    directedGraph  (Directed directed) = 
        if directed == True then "digraph G{" else "graph G{"
    directedGraph _ = "" 
