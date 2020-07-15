module Language where

    -- imports
    import Vertex
    import Edge
    import Graph
    import Utils

    -- data Graph = Graph GraphVertices GraphEdges GraphAttributes deriving Show

    -- Test elements 
    v1 = vertex "Inventory" [VertexAttribute "Placeholder-1"] :: Vertex
    v2 = vertex "Store" [VertexAttribute "Placeholder-2"] :: Vertex
    v3 = vertex "Customer" [VertexAttribute "Placeholder-3"] :: Vertex

    e1 = edge v1 v2 [EdgeAttribute "EA-1"] :: Edge
    e2 = edge v2 v3 [EdgeAttribute "EA-2"] :: Edge
    e3 = edge v3 v2 [EdgeAttribute "EA-2"] :: Edge
    
    g1 = emptyGraph :: Graph
