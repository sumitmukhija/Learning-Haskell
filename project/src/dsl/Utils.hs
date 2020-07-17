module Utils where

    import Vertex
    import Edge
    
    -- Takes a vertex value and returns vertex shaped as GraphVertices (alias)
    vertexBundleFromVertex (Vertex identifier attributes) = (identifier, attributes)

    edgeBundleFromEdge (Edge (Vertex id1 _) (Vertex id2 _) eId eAttrs) = (id1, id2, eAttrs)

    addVertexBundleToExistingVertices:: 
        Maybe [(VertexIdentifier, (Maybe VertexAttributes))] -> 
            Vertex -> [(VertexIdentifier, (Maybe VertexAttributes))]
    addVertexBundleToExistingVertices Nothing vertex = 
        [vertexBundleFromVertex vertex]
    addVertexBundleToExistingVertices (Just vertices) vertex = 
        vertices ++ [vertexBundleFromVertex vertex]

    addGraphAttribToExistingAttribs Nothing attrib = [attrib]
    addGraphAttribToExistingAttribs (Just attribs) attrib = attribs ++ [attrib]

    addEdgeBundleToExistingEdges Nothing edge = [edgeBundleFromEdge edge]
    addEdgeBundleToExistingEdges (Just edges) edge = edges ++ [edgeBundleFromEdge edge]
