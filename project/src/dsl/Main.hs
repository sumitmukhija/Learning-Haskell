module Main (main) where

    import Graph 
    import Utils
    import Attribs
    import Instances
    import DemoGraphs

    --  vertices, edges, etc to try in GHCi
    vs = [("A", [VtxShape Box]), ("B", [VtxArea 2.8, VtxShape Box])]
    vs2 = [("A", [VtxArea 2.1]), ("C", [])]
    va = VtxArea 1.0
    vb = VtxShape Box
    es = [(("A", "B"), [EdShape Dot])]
    es2 = [(("A", "B"), [EdLabelLoc Top])]
    ea = EdDirection Forward
    g = vertex "A" 
    ga = [(Strict True), (Directed True)]
    ge = edge "C" "D"
    g1 = setVertexAttribute "A" va (g::G)
    g2 = setEdgeAttribute "C" "D" ea (ge::G)
    t = VtxLabelLoc Top


    main = return ()

    