{-# LANGUAGE AllowAmbiguousTypes #-}
module Utils where

    import Vertex
    import Edge

    -- Adds a vertex bundle to the existing vertices. Uses vertexBundleFromVertex in this module
    addVertexBundleToExistingVertices Nothing vertex = 
        [vertexBundleFromVertex vertex]
    addVertexBundleToExistingVertices (Just vertices) vertex = 
        vertices ++ [vertexBundleFromVertex vertex]

    -- Adds a graph attribute to existing Graph attributes.
    addGraphAttribToExistingAttribs Nothing attrib = [attrib]
    addGraphAttribToExistingAttribs (Just attribs) attrib = attribs ++ [attrib]

    -- Adds an edge bundle to the existing edges. Uses edgeBundleFromEdge in this module
    addEdgeBundleToExistingEdges:: (EdgeType e v) => Maybe [EdgeBundle] -> e -> [EdgeBundle]
    addEdgeBundleToExistingEdges Nothing edge = undefined
    addEdgeBundleToExistingEdges (Just edges) edge = undefined
