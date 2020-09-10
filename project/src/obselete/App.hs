module App where
    
    -- Represents Graph element for DOT. 
    -- Currently has root graph/digraph. Vertex, Edge 
    data GraphElement = Graph Bool [Char] | Vertex [Char] | Edge [Char] [Char] Bool  deriving Show
    
    -- Represennts Graph representation for DOT.
    -- Takes in a string and returns printer data
    data GraphPrinter = GraphPrinter [Char] deriving Show

    class DSL el where 
        graph:: Bool -> [Char] -> el
        vertex:: [Char] -> el
        edge:: [Char] -> [Char] -> Bool -> el
        
    instance DSL GraphElement where
        graph isDirected name = Graph isDirected name
        vertex name = Vertex name
        edge from to isGraphDirected = Edge from to isGraphDirected
    
    instance DSL GraphPrinter where
        graph isDirected name = 
            if isDirected == True then GraphPrinter ("digraph "++ name) 
            else GraphPrinter ("graph "++ name)
        vertex name = getPrinterVertexFromElement (Vertex name)
        edge from to isGraphDirected = getPrinterEdgeFromElement (Edge from to isGraphDirected) 

    -- Utility functions
    
    -- Takes a vertex and returns a GraphPrinter equivalent for the vertex  
    getPrinterVertexFromElement:: GraphElement -> GraphPrinter
    getPrinterVertexFromElement (Vertex vertexName) = GraphPrinter vertexName

    -- Takes an edge and returns a GraphPrinter equivalent for the edge with from, to & the nature of graph
    getPrinterEdgeFromElement:: GraphElement -> GraphPrinter
    getPrinterEdgeFromElement (Edge from to isGraphDirected) = 
        if isGraphDirected == True then GraphPrinter (from ++ " -> " ++ to) 
        else GraphPrinter (from ++ " - " ++ to)

    -- The two below are constants for the starting and ending braces.
    startGraph = "{"
    endGraph = "}"
    
    -- A directed test graph with name Store. In the form of GraphPrinter
    testGraph:: GraphPrinter 
    testGraph = graph True "Store"

    -- A test edge from vertex inventory to shelves. The bool signifies directional graph. In the form of graph printer.
    testEdge:: GraphPrinter
    testEdge = edge "Inventory" "Shelves" True

    -- The brings all the test elements together along with start & end graph.
    -- produces `digraph Store{Inventory -> Shelves}`
    outcomeGraph = stringFromPrinter testGraph ++ startGraph ++ stringFromPrinter testEdge ++ endGraph

    -- Auxilary function to get string from a GraphPrinter
    stringFromPrinter:: GraphPrinter -> [Char]
    stringFromPrinter (GraphPrinter str) = str
