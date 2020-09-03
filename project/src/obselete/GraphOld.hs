{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
module GraphOld where

    import Utils
    import Vertex
    import Edge
    import Attribs

    -- Alias for commonly used data types
    type GraphIdentifier = String
    type EdgesInGraph = [EdgeBundle]
    type VerticesInGraph = [VertexBundle]
    type GraphAttributes = [GraphAttribute]

    class (VertexType v, EdgeType e v) => GraphType g where
        emptyGraph :: g
        attachEdge :: e -> g -> g
        attachVertex :: v -> g -> g
        attachAttribute:: GraphAttribute -> g -> g

    data Graph = 
        Graph (Maybe EdgesInGraph) (Maybe VerticesInGraph) (Maybe GraphAttributes) 
        deriving Show

    instance GraphType Graph where
        -- Returns an empty graph with no edges, no vertices & no attributes.
        emptyGraph = Graph Nothing Nothing Nothing

        -- Returns a new graph by adding given edge to the existing edges 
        attachEdge edge (Graph edges vertices attrs) = undefined
        --  Graph (Just (addEdgeBundleToExistingEdges edges edge)) vertices attrs

        -- Returns a new graph by adding given vertex to the existing vertices 
        attachVertex vertex (Graph edges vertices attrs) =
            Graph edges (Just (addVertexBundleToExistingVertices vertices vertex)) attrs
            
        -- Returns a new graph by adding given attrubute to the existing attributes
        attachAttribute attribute (Graph edges vertices attrs) =
            Graph edges vertices (Just (addGraphAttribToExistingAttribs attrs attribute))
