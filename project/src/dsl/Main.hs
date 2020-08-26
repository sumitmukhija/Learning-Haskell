module Main (main) where

    import Graph 
    import Utils
    import Attribs
    import Instances
    import DemoGraphs
    import BDTUtils
    import Types
    
--     decisionTreeExample = (decisionTree "width <= 0.8" "Setosa" "length <= 4.95") :: BDT
    neuralNetworkExample = (neuralNetworkWithNeurons 2 4 2) :: G

    e1 = BDTNode ("A", []) (BDTNode ("B", []) (EmptyBDT,[]) (EmptyBDT,[]), []) (EmptyBDT,[])
    e2 = BDTNode ("A", []) (EmptyBDT,[]) (BDTNode ("C", []) (EmptyBDT,[]) (EmptyBDT,[]), [])

    bdtex = BDTNode ("root", []) 
            ((BDTNode ("left", []) (BDTNode ("subleft", []) (EmptyBDT,[]) (EmptyBDT,[]), []) (EmptyBDT,[])), []) 
            ((BDTNode ("right", []) (EmptyBDT,[]) (EmptyBDT,[])), []) 

    main = return ()

    