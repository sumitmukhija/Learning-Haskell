module Main (main) where

    import Graph 
    import Utils
    import Attribs
    import Instances
    import DemoGraphs
    
    decisionTreeExample = (decisionTree "width <= 0.8" "Setosa" "length <= 4.95") ::G
    neuralNetworkExample = (neuralNetworkWithNeurons 2 4 2) :: G

    main = return ()

    