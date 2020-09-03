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
|  BDTUtils | [BDTUtils.hs](BDTUtils.hs "BDTUtils.hs")  | Utils for BDT type | Types
| DemoGraphs  |  [DemoGraphs.hs](DemoGraphs.hs "DemoGraphs.hs") | Contains demo for Decision tree and neural networks | Graphs, Attribs
| Instances  |  [Instances.hs](Instances.hs "Instances.hs") | Contains instances for G and BDT |  Graph, Attribs, Utils, BDTUtils, Types
| Graph  |  [Graph.hs](Graph.hs "Graph.hs") | Contains typeclass for graph. Some utility functions, too.  |  Attribs
|  Utils | [Utils.hs](Utils.hs "Utils.hs")  | Bunch of helper functions primarily used by Graph module.  | Vertex, Edge
|  Attribs | [Attribs.hs](Attribs.hs "Attribs.hs")  | Attributes for edges, vertices and graph  | None
|  Types | [Types.hs](Types.hs "Types.hs")  | Contains data types for G and BDT  | Attribs

# 2. Concepts explored and used
- MultiParamTypeClasses
- Concrete and non concrete types
- alias using `type`
- classes and instances
- pattern matching in functions


