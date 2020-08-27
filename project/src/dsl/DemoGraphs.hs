module DemoGraphs where

    import Graph
    import Attribs


-- Example 1 - Single hidden layer Neural Network
    neuralNetworkWithNeurons:: Graph g => Int -> Int -> Int -> g
    neuralNetworkWithNeurons inputNeurons hiddenNeurons outputNeurons=
        neuralNet where 
            input = neuralNetInputLayer inputNeurons 
            hidden = neuralNetHiddenLayer hiddenNeurons 
            output = neuralNetOutputLayer outputNeurons 
            inputToHiddenGraph = connectInputAndHiddenNeurons input hidden
            hiddenToOutputGraph = connectHiddenAndOutputNeurons hidden output
            merged = nnMergeVertices [hiddenToOutputGraph, inputToHiddenGraph]
            neuralNet = setGraphAttribute (Directed True) merged

    connectInputAndHiddenNeurons:: Graph g => g -> g -> g
    connectInputAndHiddenNeurons inputLayer hiddenLayer = 
            inputToHiddenGraph where
                inputNeurons = getGraphVertices inputLayer
                hiddenNeurons = getGraphVertices hiddenLayer
                inputToHiddenEdges = 
                    [(edge i h) | (i, _) <- inputNeurons, (h, _) <- hiddenNeurons]
                inputToHiddenGraph = nnMergeVertices inputToHiddenEdges
    
    connectHiddenAndOutputNeurons:: Graph g => g -> g -> g
    connectHiddenAndOutputNeurons hiddenLayer outputLayer = 
            hiddenToOutputGraph where
                hiddenNeurons = getGraphVertices hiddenLayer
                outputNeurons = getGraphVertices outputLayer
                hiddenToOutputEdges = 
                    [(edge h o) | (h, _) <- hiddenNeurons, (o, _) <- outputNeurons]
                hiddenToOutputGraph = nnMergeVertices hiddenToOutputEdges

    neuralNetInputLayer noOfNeurons = 
        nnMergeVertices (nnGetNVerticesOfKind noOfNeurons "input")

    neuralNetHiddenLayer noOfNeurons = 
        nnMergeVertices (nnGetNVerticesOfKind noOfNeurons "hidden")

    neuralNetOutputLayer noOfNeurons = 
        nnMergeVertices (nnGetNVerticesOfKind noOfNeurons "output")

    nnGetNVerticesOfKind n kind = [vertex (nnGetVertex kind a)| a <- [1..n]]

    nnGetVertex entity number = entity ++ " "++ (show number)

    nnMergeVertices vertices = mergeMultipleGraphs vertices

    -- Example 2 Decision Tree

    vrg = "Virginica"
    vrs = "Versicolor"
    set = "Setosa"

    splitByWidthToLeaves:: String
    splitByWidthToLeaves = "width <= 1.65"

    rt = "width < 0.8"

    splitByLegthToVirginica = "length <= 5.05"

    splitByLengthToFurtherSplits = "length <= 4.95"

    rootLevelOne::Graph g => g
    rootLevelOne = merge (edge rt splitByLengthToFurtherSplits) (edge rt set)

    leftLevelTwo::Graph g => g
    leftLevelTwo = edge splitByLengthToFurtherSplits splitByLegthToVirginica

    rightLevelTwo:: Graph g => g
    rightLevelTwo = edge splitByLengthToFurtherSplits splitByWidthToLeaves

    subtreeLevelOne:: Graph g => g
    subtreeLevelOne = merge rootLevelOne leftLevelTwo

    subtreeLevelTwo:: Graph g => g
    subtreeLevelTwo = merge subtreeLevelOne rightLevelTwo

    leftToLeafVirginca:: Graph g => g
    leftToLeafVirginca = edge splitByLegthToVirginica vrg

    rightToLeafVirginca :: Graph g => g
    rightToLeafVirginca = edge splitByWidthToLeaves vrg

    rightToLeafVersi:: Graph g => g
    rightToLeafVersi = edge splitByWidthToLeaves vrs

    rightBottomSubtree:: Graph g => g
    rightBottomSubtree = merge rightToLeafVirginca rightToLeafVersi

    midSubtree:: Graph g => g
    midSubtree = merge subtreeLevelTwo rightBottomSubtree

    decisionTreeExample ::Graph g => g
    decisionTreeExample = merge midSubtree leftToLeafVirginca