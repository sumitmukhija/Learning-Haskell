module Instances where

    import Graph
    import Attribs
    import Utils

    data G = G  [(String, [VertexAttribute])]
                [((String,String),[EdgeAttribute])]
                [GraphAttribute] deriving Show
        
    data DotRepr = DotRepr String

    instance Graph G where
        -- Vertex
        vertex vtxId = G [(vtxId, [])] [] []
        setVertexAttribute vtxId vtxAttr (G vs es as)=
            G vs' es as where 
                vs' = updateVertices vtxId vtxAttr vs
        getVertexAttributes vtxId (G vs _ _) = do
            let pairs = filterVertex vtxId vs
            if length pairs == 0 then undefined
            else extractAttributesFromNonEmptyVertex pairs

        -- Edge
        edge vtx1 vtx2 = G [(vtx1, []), (vtx2, [])] [((vtx1, vtx2), [])] []
        setEdgeAttribute vtx1 vtx2 eAttr (G vs es as)=
            G vs es' as where 
                es' = updateEdges vtx1 vtx2 eAttr es
        getEdgeAttributes vtx1 vtx2 (G _ es _) = do
            let tuples = filterEdge vtx1 vtx2 es
            if length tuples == 0 then undefined
            else extractAttributesFromNonEmptyEdge tuples

        -- Graph
        empty = G [] [] []
        merge (G xvs xes xattrs) (G yvs yes yattrs) = 
            G zvs zes zattrs where 
                zvs = mergeVertices xvs yvs
                zes = mergeEdges xes yes
                zattrs = xattrs ++ yattrs
        setGraphAttribute ga (G vs es gAttr) = 
            G vs es gAttr' where 
                gAttr' = gAttr ++ [ga]
        getGraphAttributes (G _ _ gAttr) = 
            gAttr
        getGraphVertices (G v _ _ ) = v
        getGraphEdges (G _ e _ ) = e

        -- Misc
        numberOfVertices (G vs _ _) = length vs
        numberOfEdges (G _ es _) = length es
        connectedNodes (G _ es _) startingNode = 
            getConnectedNodes es startingNode
    
    generateDOT (G vs es as) = unlines (graphAttributesToString as ++ 
                                        verticesToString vs ++ 
                                        edgesToString es)

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
    