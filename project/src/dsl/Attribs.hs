module Attribs where

    data LabelLocation = Top | Bottom | Center deriving Show
    data Style = Dashed | Black | Invis deriving Show


    data VertexShape = Box | Oval | Plaintext deriving Show
    data VertexAttribute =  VtxShape VertexShape | 
                            VtxArea Float |
                            VtxFillColour String |
                            VtxLabelLoc LabelLocation |
                            VtxStyle Style deriving Show

    data EdgeArrowShape = Normal | Dot | Tee | Empty | NoShape deriving Show
    data EdgeDirection = Forward | NoDirection deriving Show

    data EdgeAttribute = EdShape EdgeArrowShape |
                         EdLabelLoc LabelLocation |
                         EdDirection EdgeDirection |
                         EdStyle Style deriving Show


