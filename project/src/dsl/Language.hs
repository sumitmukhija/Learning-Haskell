module Language where

    -- imports
    import Vertex
    import Edge
    import Graph
    import Utils
    import Attribs

    data Printer = Printer Graph deriving Show

    instance GraphType Printer where
        emptyGraph = Printer (emptyGraph :: Graph)
        attachVertex v (Printer g) = Printer (attachVertex v g)
        attachEdge e (Printer g) = Printer (attachEdge e g)
        attachAttribute ga (Printer g) = Printer (attachAttribute ga g)
    
    graphString (Printer (Graph Nothing Nothing Nothing)) = "graph {}"
    graphString (Printer (Graph vertices edges attribs)) = "graph!"

    -- Test elements 
    v1 = vertex "Inventory" [VNone] :: Vertex
    v2 = vertex "Store" [VNone] :: Vertex
    v3 = vertex "Customer" [VNone] :: Vertex

    e1 = edge v1 v2 [EdgeAttribute "EA-1"] :: Edge
    e2 = edge v2 v3 [EdgeAttribute "EA-2"] :: Edge
    e3 = edge v3 v2 [EdgeAttribute "EA-2"] :: Edge
    
    g1 = emptyGraph :: Graph
