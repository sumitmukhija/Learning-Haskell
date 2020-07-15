# 1. Modules

| Module  | File   | Description   | Imports |
| ------------ | ------------ | ------------ |
|  Language | [Language.hs](Language.hs "Language.hs")  |  Starting point of the dsl. Puts everything together | Vertex, Edge, Graph, Utils
| Edge  |  [Edge.hs](Edge.hs "Edge.hs") | Contains classes for `EdgeType` and `EdgeAttributeType`. Also contains value constructors for `Edge` and `EdgeAttribute`. Contains `MultiParamTypeClasses`  | Vertex
| Vertex  |  [Vertex.hs](Vertex.hs "Vertex.hs") | Contains classes for `VertexType` and `VertexAttributeType`. Also contains value constructors for `Vertex` and `VertexAttribute`. Contains `MultiParamTypeClasses`  |  --
| Graph  |  [Graph.hs](Graph.hs "Graph.hs") | Contains classes for `GraphType`. Also contains value constructors for `Graph` and `GraphAttribute`. Contains `MultiParamTypeClasses`  |  Vertex, Edge, Utils
|  Utils | [Utils.hs](Utils.hs "Utils.hs")  | Bunch of helper functions primarily used by Graph module.  | Vertex, Edge

# 2. Concepts explored and used
- MultiParamTypeClasses
- Concrete and non concrete types
- alias using `type`
- classes and instances
- pattern matching in functions