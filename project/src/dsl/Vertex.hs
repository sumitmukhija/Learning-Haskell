{-# LANGUAGE MultiParamTypeClasses #-}
module Vertex where

    import Attribs

    type VertexIdentifier = String
    type VertexAttributes = [VertexAttribute]

    class VertexType v where
        vertex:: VertexIdentifier -> (Maybe VertexAttributes) -> v
    
    class VertexType v => VertexAttributeType vat v where
        setVertexAttribute :: v -> vat -> v
        getVeretxAttributes :: v -> Maybe [vat]

    data Vertex = Vertex VertexIdentifier (Maybe VertexAttributes) deriving Show

    instance VertexType Vertex where
        vertex identifier attributes = Vertex identifier attributes

    instance VertexAttributeType VertexAttribute Vertex where 
        
        setVertexAttribute (Vertex identifier Nothing) attr = 
            (vertex identifier (Just [attr]))
        setVertexAttribute (Vertex identifier (Just attrs)) attr =
            (vertex identifier (Just (attrs ++ [attr])))
        getVeretxAttributes (Vertex _ attrs) = attrs
