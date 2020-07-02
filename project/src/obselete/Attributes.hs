module Attributes where

import Label
import Shapes

-- Style of the edge connecting nodes
data RelationshipStyle = Dashed | Solid deriving Show

--  Attributes related to the relationships.
data RelationshipAttrib = Style RelationshipStyle 
                        | Color [Char]
                        | Penwidth Double
                        | Arrowhead RelationshipShape
                        | EdgeLabel EntityLabel deriving Show

-- Attributes of a node
data NodeAttrib = Shape NodeShape 
                | FontName [Char]  
                | NodeLabel EntityLabel deriving Show 