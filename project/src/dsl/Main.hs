module Main (main) where

    import Graph 
    import Utils
    import Attribs
    import Instances
    import DemoGraphs
    
    decisionTreeExample = (decisionTree "width <= 0.8" "Setosa" "length <= 4.95") ::G
    neuralNetworkExample = (neuralNetworkWithNeurons 2 4 2) :: G

    bdtex = BDTNode ("root", []) 
            ((BDTNode ("left", []) (BDTNode ("subleft", []) (EmptyBDT,[]) (EmptyBDT,[]), []) (EmptyBDT,[])), []) 
            ((BDTNode ("right", []) (EmptyBDT,[]) (EmptyBDT,[])), []) 

    main = return ()

    