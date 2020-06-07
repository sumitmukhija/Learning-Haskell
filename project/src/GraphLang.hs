module GraphLang where
import Label
import Attributes
import Shapes

-- Section represents the type of graph: Graph name isStrict statements
data Graph = Graph [Char] Bool [Statement] 
            | Digraph [Char] Bool [Statement] deriving Show

-- Represents a node: Node name attributes
data Node = Node [Char] [NodeAttrib] deriving Show

-- Represents a relationship between nodes. Relationship from_node to_nodes edge_attribs
data Relationship = Relationship Node [Node] [RelationshipAttrib] deriving Show

-- Represents a rank. Nodes with the same rank are shown in the same column
data Rank = Rank [Node]

-- Represents a statement 
data Statement = CreateNode Node | CreateRelationship Relationship deriving Show

data Subgraph = Subgraph deriving Show
