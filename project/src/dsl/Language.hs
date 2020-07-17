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
    v1 = vertex "Inventory" (Just [VtxFillColour "red"]) :: Vertex
    v2 = vertex "Store" (Just [VtxLabelLoc Top]) :: Vertex
    v3 = vertex "Customer" Nothing :: Vertex

    e1 = edge v1 v2 (Just [EdShape Dot]) :: Edge
    e2 = edge v2 v3 (Just [EdShape NoShape]) :: Edge
    e3 = edge v3 v2 (Just [EdStyle Dashed]) :: Edge
    
    g1 = emptyGraph :: Graph
