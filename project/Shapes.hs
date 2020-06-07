module Shapes where

-- Shape of the node
data NodeShape = Record | Plaintext | Plain | Trapezium 
                | Parallelogram | House | Triangle 
                | Point | Egg | Circle | Box 
                | DiamondNode | Ellipse | Polygon 
                | Oval | Pentagon | DoubleCircle 
                | Hexagon | Septagon | Octagon 
                | DoubleOctagon | Tripleoctagon | Invtriangle
                | Invtrapezium | Invhouse | Mdiamond 
                | Msquare | Mcircle | Rect 
                | Rectangle | Square | Star 
                | None | Underline | Cylinder 
                | Note | Tab | Folder
                | Box3D | Component | Promoter
                | CDS | Terminator | UTR 
                | Primersite | Restrictionsite | Fivepoverhang
                | Threepoverhang | Noverhang | Assembly
                | Signature | Insulator | Ribosite
                | Rnastab | Proteasesite | Proteinstab
                | Rpromoter | Rarrow | Larrow 
                | Lpromoter deriving Show 

-- Shape of the arrow head. Applicable to dirgraph relations
data RelationshipShape = BoxArrow | Crow | Curve | ICurve 
                        | DiamondEdge | Dot |Inv | Normal 
                        | Tee | Vee | NoArrow deriving Show
