module Attribs where

    -- Attributes common to multiple entities
    data LabelLocation = Top | Bottom | Center deriving (Show, Eq)
    data Style = Dashed | Black | Invis deriving (Show, Eq)

    -- Vertex related attribs
    data VertexShape = Box | Oval | Plaintext deriving (Show, Eq)
    data VertexAttribute =  VtxShape VertexShape | 
                            VtxArea Float |
                            VtxFillColour String |
                            VtxLabelLoc LabelLocation |
                            VtxStyle Style deriving (Show, Eq)

    -- Edge related attribs
    data EdgeArrowShape = Normal | Dot | Tee | Empty | NoShape deriving (Show, Eq)
    data EdgeDirection = Forward | NoDirection deriving (Show, Eq)

    data EdgeAttribute = EdShape EdgeArrowShape |
                         EdLabelLoc LabelLocation |
                         EdLabel String |
                         EdDirection EdgeDirection |
                         EdStyle Style deriving (Show, Eq)

    -- Graph related attribs
    data GraphAttribute = Strict Bool | 
                          Directed Bool | 
                          GraphName String |
                          Landscape Bool deriving (Show, Eq)

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
    stringReprForEdgeAttrib (EdLabel text) =  "label="++(show text)
