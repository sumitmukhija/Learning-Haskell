module Language where

    data Graph = Vertex [Char] | Edge Graph Graph deriving Show
    data Printer = Printer [Char] deriving Show

    class GraphDSL g where
        vertex:: [Char] -> g
        edge::  [Char] -> [Char] -> g

    instance GraphDSL Graph where
        vertex s = Vertex s
        edge a b = Edge (Vertex a) (Vertex b)
    
    instance GraphDSL Printer where
        vertex s = vgraphtxt ((vertex s) :: Graph)
        edge a b = vgraphtxt ((edge a b) :: Graph)

    vgraphtxt:: Graph -> Printer 
    vgraphtxt (Vertex name) = Printer ("graph {"++name++"}")
    vgraphtxt (Edge (Vertex a) (Vertex b)) = Printer ("graph { "++a++" - " ++b++"}")
    vgraphtxt _ = Printer "graph {}"