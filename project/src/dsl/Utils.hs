module Utils where

    import Vertex
    import Edge
    
    -- Takes a vertex value and returns vertex shaped as VertexBundle (Graph.hs)
    vertexBundleFromVertex (Vertex identifier attributes) = (identifier, attributes)

    -- Takes an edge value and returns edge shaped as EdgeBundle (Graph.hs)
    edgeBundleFromEdge (Edge (Vertex id1 _) (Vertex id2 _) eId eAttrs) = (id1, id2, eAttrs)

    -- Adds a vertex bundle to the existing vertices. Uses vertexBundleFromVertex in this module
    addVertexBundleToExistingVertices:: 
        Maybe [(VertexIdentifier, (Maybe VertexAttributes))] -> 
            Vertex -> [(VertexIdentifier, (Maybe VertexAttributes))]
    addVertexBundleToExistingVertices Nothing vertex = 
        [vertexBundleFromVertex vertex]
    addVertexBundleToExistingVertices (Just vertices) vertex = 
        vertices ++ [vertexBundleFromVertex vertex]

    -- Adds a graph attribute to existing Graph attributes.
    addGraphAttribToExistingAttribs Nothing attrib = [attrib]
    addGraphAttribToExistingAttribs (Just attribs) attrib = attribs ++ [attrib]

    -- Adds an edge bundle to the existing edges. Uses edgeBundleFromEdge in this module
    addEdgeBundleToExistingEdges Nothing edge = [edgeBundleFromEdge edge]
    addEdgeBundleToExistingEdges (Just edges) edge = edges ++ [edgeBundleFromEdge edge]
