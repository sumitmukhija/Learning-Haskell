module Attribs where

    data VertexShape = Box | Oval | Plaintext deriving Show
    data VertexLabelLocation = Top | Bottom | Center deriving Show

    data VertexAttribute = VNone | VShape VertexShape | 
                        VArea Float |
                        VFillColor String |
                        VLabelLoc VertexLabelLocation deriving Show