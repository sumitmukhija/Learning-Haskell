module Language where
    
    class GraphDSL g where
        vertex:: [Char] -> g
        edge::  [Char] -> [Char] -> g

    data Graph = Vertex [Char] | Edge [Char] [Char] deriving Show
    data Printer = Printer [Char] deriving Show

    instance GraphDSL Graph where
        vertex s = Vertex s
        edge a b = Edge a b
    
    instance GraphDSL Printer where
        vertex s = vgraphtxt ((vertex s) :: Graph)
        edge a b = vgraphtxt ((edge a b) :: Graph)

    vgraphtxt:: Graph -> Printer 
    vgraphtxt (Vertex name) = Printer ("graph {"++name++"}")
    vgraphtxt (Edge a b) = Printer ("graph { "++a++" - " ++b++"}")
    vgraphtxt _ = Printer "graph {}"