module Language where

    -- imports
    import Vertex
    import Edge
    import Graph
    import Utils
    import Attribs
    import Printer

    -- Test elements 
    v1 = vertex "Inventory" (Just [VtxFillColour "red"]) :: Vertex
    v2 = vertex "Store" (Just [VtxLabelLoc Top]) :: Vertex
    v3 = vertex "Customer" Nothing :: Vertex

    e1 = edge v1 v2 (Just [EdShape Dot]) :: Edge
    e2 = edge v2 v3 (Just [EdShape NoShape]) :: Edge
    e3 = edge v3 v2 (Just [EdStyle Dashed]) :: Edge
    
    g1 = emptyGraph :: Graph
