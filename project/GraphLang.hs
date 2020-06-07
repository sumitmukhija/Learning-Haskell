module GraphLang where
import Label
import Attributes
import Shapes

-- Section represents the type of graph.
data Graph = Graph [Char] Bool [Statement] 
            | Digraph [Char] Bool [Statement] deriving Show

-- Represents a node
data Node = Node [NodeAttrib] deriving Show

-- Represents a relationship between nodes
data Relationship = Relationship Node [Node] [RelationshipAttrib] deriving Show

-- Represents a rank. Nodes with the same rank are shown in the same column
data Rank = Rank [Node]

-- Represents a statement 
data Statement = Statement deriving Show
