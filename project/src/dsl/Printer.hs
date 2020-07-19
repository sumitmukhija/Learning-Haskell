module Printer where
    
    import Graph
    import Vertex
    import Edge
    import Attribs

    data Printer = Printer Graph deriving Show
    
    instance GraphType Printer where
        emptyGraph = Printer (emptyGraph :: Graph)
        attachVertex v (Printer g) = Printer (attachVertex v g)
        attachEdge e (Printer g) = Printer (attachEdge e g)
        attachAttribute ga (Printer g) = Printer (attachAttribute ga g)
    
    graphString (Printer (Graph Nothing Nothing Nothing)) = "graph {}"
    graphString (Printer (Graph vertices edges attribs)) = show (graphHeaderFromAttributes attribs)


    -- Helper functions
    graphHeaderFromAttributes Nothing = [""]
    graphHeaderFromAttributes (Just attrs) = map extractElement attrs
    extractElement (Strict isStrict) = if isStrict == True then "strict" else ""
    extractElement (GraphName name) = name
    extractElement (Directed isDirected) = if isDirected == True then "digraph" else "graph"