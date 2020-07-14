module Alias where

    import Attributes

    -- To identify different vertices and edges
    type VertexIdentifier = String
    type EdgeIdentifier = String

    -- To create data Graph
    type GraphVertex = (VertexIdentifier, VertexAttributes)
    type GraphEdge = (VertexIdentifier, VertexIdentifier, EdgeAttributes)
    type GraphVertices = [GraphVertex]
    type GraphEdges = [GraphEdge]

    -- Plural form of the individual attribute
    type VertexAttributes = [VertexAttribute]
    type EdgeAttributes = [EdgeAttribute]
    type GraphAttributes = [GraphAttribute]
