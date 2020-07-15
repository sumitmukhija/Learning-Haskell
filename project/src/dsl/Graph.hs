module Graph where

    import Utils
    import Vertex
    import Edge

    type GraphIdentifier = String
    type EdgeBundle = (VertexIdentifier, VertexIdentifier, EdgeAttributes)
    type VertexBundle = (VertexIdentifier, VertexAttributes)
    type EdgesInGraph = [EdgeBundle]
    type VerticesInGraph = [VertexBundle]
    type GraphAttributes = [GraphAttribute]

    class GraphType g where
        emptyGraph :: g
        attachEdge :: Edge -> g -> g
        attachVertex :: Vertex -> g -> g
        attachAttribute:: GraphAttribute -> g -> g

    data Graph = 
        Graph (Maybe EdgesInGraph) (Maybe VerticesInGraph) (Maybe GraphAttributes) 
        deriving Show
    data GraphAttribute = GraphAttribute String deriving Show

    instance GraphType Graph where
        -- Returns an empty graph with no edges, no vertices & no attributes.
        emptyGraph = Graph Nothing Nothing Nothing

        -- Returns a new graph by adding given edge to the existing edges 
        attachEdge edge (Graph edges vertices attrs) = 
            Graph (Just (addEdgeBundleToExistingEdges edges edge)) vertices attrs
        
        -- Returns a new graph by adding given vertex to the existing vertices 
        attachVertex vertex (Graph edges vertices attrs) = 
            Graph edges (Just (addVertexBundleToExistingVertices vertices vertex)) attrs
        
        -- Returns a new graph by adding given attrubute to the existing attributes
        attachAttribute attribute (Graph edges vertices attrs) =
            Graph edges vertices (Just (addGraphAttribToExistingAttribs attrs attribute))
