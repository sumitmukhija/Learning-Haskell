{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies #-}
module Vertex where

    type VertexIdentifier = String

    class VertexType v where
        vertex:: VertexIdentifier -> [VertexAttribute] -> v
    
    class VertexType v => VertexAttributeType vat v where
        setVertexAttribute :: v -> vat -> v
        getVeretxAttributes :: v -> [vat]


    data Vertex = Vertex VertexIdentifier [VertexAttribute] deriving Show
    data VertexAttribute = VertexAttribute String deriving Show

    instance VertexType Vertex where
        vertex identifier attributes = Vertex identifier attributes

    instance VertexAttributeType VertexAttribute Vertex where 
        setVertexAttribute (Vertex identifier attrs) attr =
            (vertex identifier (attrs ++ [attr]))  :: Vertex
        
        getVeretxAttributes (Vertex identifier attrs) = attrs
