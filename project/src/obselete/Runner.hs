-- File to run test graphs

module Runner where 
import Label
import Shapes
import Attributes
import GraphLang

-- Test elements
n1_atr = [Shape Egg]
n1 = Node "Inventory" n1_atr

n2_atr = [Shape Box]
n2 = Node "Store" n2_atr

r1 = Relationship n1 [n2] []

s1 = CreateNode n1
s2 = CreateNode n2
s3 = CreateRelationship r1

g = Digraph "Inventory to store - " False [s1,s2,s3]