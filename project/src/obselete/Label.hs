module Label where 
-- Represents label. Can be used for node or for graph
data LabelLocation = Top | Bottom deriving Show
data EntityLabel = Label [Char] deriving Show
