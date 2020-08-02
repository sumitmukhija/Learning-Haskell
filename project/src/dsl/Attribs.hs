module Attribs where

    -- Attributes common to multiple entities
    data LabelLocation = Top | Bottom | Center deriving Show
    data Style = Dashed | Black | Invis deriving Show

    -- Vertex related attribs
    data VertexShape = Box | Oval | Plaintext deriving Show
    data VertexAttribute =  VtxShape VertexShape | 
                            VtxArea Float |
                            VtxFillColour String |
                            VtxLabelLoc LabelLocation |
                            VtxStyle Style deriving Show

    -- Edge related attribs
    data EdgeArrowShape = Normal | Dot | Tee | Empty | NoShape deriving Show
    data EdgeDirection = Forward | NoDirection deriving Show

    data EdgeAttribute = EdShape EdgeArrowShape |
                         EdLabelLoc LabelLocation |
                         EdDirection EdgeDirection |
                         EdStyle Style deriving Show

    -- Graph related attribs
    data GraphAttribute = Strict Bool | 
                          Directed Bool | 
                          GraphName String |
                          Landscape Bool deriving Show

    -- String representations
    stringReprForVertexAttrib (VtxShape shape) = "shape="++(show shape)
    stringReprForVertexAttrib (VtxArea area) = "area="++(show area)
    stringReprForVertexAttrib (VtxFillColour colour) = 
        "color="++(show colour)
    stringReprForVertexAttrib (VtxLabelLoc location) = 
        "labelloc="++show ((show location)!!0)
    stringReprForVertexAttrib (VtxStyle style) = 
        "style="++(show style)


    stringReprForEdgeAttrib (EdShape shape) = "shape="++(show shape)
    stringReprForEdgeAttrib (EdLabelLoc location) = "labelloc="++show ((show location)!!0)
    stringReprForEdgeAttrib (EdDirection direction) = "direction="++(show direction)
    stringReprForEdgeAttrib (EdStyle style) =  "style="++(show style)


    stringReprForGraphAttrib (Directed directed) = if directed==True then
                                                        "digraph "
                                                    else
                                                        "graph "
    stringReprForGraphAttrib (GraphName name) = show name
    stringReprForGraphAttrib (Strict isStrict) = if isStrict==True then
                                                    "strict "
                                                else
                                                    ""