{-# LANGUAGE MultiParamTypeClasses #-}
module Vertex where

    import Attribs

    type VertexIdentifier = String
    type VertexAttributes = [VertexAttribute]

    class VertexType v where
        vertex:: VertexIdentifier -> VertexAttributes -> v
    
    class VertexType v => VertexAttributeType vat v where
        setVertexAttribute :: v -> vat -> v
        getVeretxAttributes :: v -> [vat]

    data Vertex = Vertex VertexIdentifier VertexAttributes deriving Show

    instance VertexType Vertex where
        vertex identifier attributes = Vertex identifier attributes

    instance VertexAttributeType VertexAttribute Vertex where 
        setVertexAttribute (Vertex identifier attrs) attr =
            (vertex identifier (attrs ++ [attr]))
        getVeretxAttributes (Vertex _ attrs) = attrs
