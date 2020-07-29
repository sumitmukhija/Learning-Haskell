# Latest iteration

### Changes
- `Graph.hs` now has a single module implementation of the language.
- The vertices are now represented by strings and edges by two strings. Removed classes & data for them
- Previous `Graph.hs` implementation is now in `GraphOld.hs`
- Relevant files at this point - `Graph.hs` and `Attribs.hs`
- working - `vertex`, `edge`, `merge`, getters and setters for vertex and edge


# 1. Modules

| Module  | File   | Description   | Imports |
| --- | --- | --- | --- |
|  Language | [Language.hs](Language.hs "Language.hs")  |  Starting point of the dsl. Puts everything together | Vertex, Edge, Graph, Utils
| Edge  |  [Edge.hs](Edge.hs "Edge.hs") | Contains classes for `EdgeType` and `EdgeAttributeType`. Also contains value constructors for `Edge` and `EdgeAttribute`. Contains `MultiParamTypeClasses`  | Vertex
| Vertex  |  [Vertex.hs](Vertex.hs "Vertex.hs") | Contains classes for `VertexType` and `VertexAttributeType`. Also contains value constructors for `Vertex` and `VertexAttribute`. Contains `MultiParamTypeClasses`  |  --
| Graph  |  [Graph.hs](Graph.hs "Graph.hs") | Contains classes for `GraphType`. Also contains value constructors for `Graph` and `GraphAttribute`. Contains `MultiParamTypeClasses`  |  Vertex, Edge, Utils
|  Utils | [Utils.hs](Utils.hs "Utils.hs")  | Bunch of helper functions primarily used by Graph module.  | Vertex, Edge
|  Attribs | [Attribs.hs](Attribs.hs "Attribs.hs")  | Attributes for edges, vertices and graph  | None
|  Printer | [Printer.hs](Attribs.hs "Attribs.hs")  | Should print the graph  | Graph, Vertex, Edge, Attrib

# 2. Concepts explored and used
- MultiParamTypeClasses
- Concrete and non concrete types
- alias using `type`
- classes and instances
- pattern matching in functions


