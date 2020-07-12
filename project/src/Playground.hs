module Playground where

    class GraphEdge a where
        edge:: Vertex -> Vertex -> IsDirected -> a
    
    class GraphVertex a where 
        vertex:: NodeIdentifier -> a
    
    class GraphPrinter a where
        -- printEdge:: (GraphEdge b) => b -> a
        -- printVertex:: (GraphVertex b) => b -> a
        printEdge:: Edge -> a
        printVertex:: Vertex -> a
    
    type NodeIdentifier = String
    type IsDirected = Maybe Bool

    data Vertex = Vertex NodeIdentifier deriving Show
    data Edge = Edge Vertex Vertex IsDirected deriving Show
    data Printer = Printer String deriving Show

    instance GraphEdge Edge where
        edge vtx1 vtx2 directed = Edge vtx1 vtx2 directed
        edge vtx1 vtx2 Nothing = Edge vtx1 vtx2 (Just False)

    instance GraphVertex Vertex where 
        vertex name = Vertex name

    instance GraphPrinter Printer where
        printEdge (Edge (Vertex a) (Vertex b) directed) = 
            if directed == (Just True) 
                then Printer ("digraph {"++a++"->"++b++"}") 
                else Printer ("graph {"++a++"--"++b++"}")
        printVertex (Vertex name) = Printer ("graph {"++name++"}")
        
        
    -- Test elements
    testVertices = [(vertex "A" :: Vertex), 
                    (vertex "B" :: Vertex), 
                    (vertex "C" :: Vertex)]
    testEdges = [(edge (testVertices!!0) (testVertices!!1) (Just True)) :: Edge,
                 (edge (testVertices!!1) (testVertices!!2) (Nothing)) :: Edge
                ]
        
    -- Follow up questions
    -- line 10,11
    -- Line 16 Maybe?
    -- Line 24 redundant
    -- Line 32-34 - graph/digraph 
    -- Correct way -> instance GraphEdge Printer where.. instance GraphVertex Printer where..