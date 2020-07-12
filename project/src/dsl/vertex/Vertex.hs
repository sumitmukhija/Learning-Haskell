module Vertex where

    class VertexType v where
        vertex:: String -> v

    data Vertex = Vertex String deriving Show

    instance VertexType Vertex where
        vertex name = Vertex name
