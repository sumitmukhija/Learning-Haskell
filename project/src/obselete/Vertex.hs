{-# LANGUAGE MultiParamTypeClasses #-}
module Vertex where

    import Attribs

    type VertexIdentifier = String
    type VertexAttributes = [VertexAttribute]
    type VertexBundle = (VertexIdentifier, Maybe VertexAttributes)

    class VertexType v where
        vertex:: VertexIdentifier -> (Maybe VertexAttributes) -> v
        vertexBundleFromVertex:: v -> VertexBundle
        edgeIdentifierFromVertices:: v -> v -> String
    
    class VertexType v => VertexAttributeType vat v where
        setVertexAttribute :: v -> vat -> v
        getVeretxAttributes :: v -> Maybe [vat]

    data Vertex = Vertex VertexIdentifier (Maybe VertexAttributes) deriving Show

    instance VertexType Vertex where
        vertex identifier attributes = Vertex identifier attributes
        vertexBundleFromVertex (Vertex identifier attributes) = 
            (identifier, attributes)
        edgeIdentifierFromVertices (Vertex id1 _) (Vertex id2 _) = id1++"-"++id2

    instance VertexAttributeType VertexAttribute Vertex where 
        setVertexAttribute (Vertex identifier Nothing) attr = 
            (vertex identifier (Just [attr]))
        setVertexAttribute (Vertex identifier (Just attrs)) attr =
            (vertex identifier (Just (attrs ++ [attr])))
        getVeretxAttributes (Vertex _ attrs) = attrs
