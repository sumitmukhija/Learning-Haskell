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
