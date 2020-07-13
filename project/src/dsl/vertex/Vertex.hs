module Vertex where

    import Alias

    class VertexType v where
        vertex:: String -> v

    data Vertex = Vertex VertexIdentifier deriving Show

    instance VertexType Vertex where
        vertex identifier = Vertex identifier
