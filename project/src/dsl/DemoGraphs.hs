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

    -- a::Graph g => g
    -- a = edge splitByLegthToVirginica vrg
    -- b::Graph g => g
    -- b = edge splitByWidthToLeaves vrs
    -- c:: Graph g => g
    -- c = edge splitByWidthToLeaves vrg
    -- d:: Graph g => g
    -- d = merge b c -- w <=1.65

    a::Graph g => g
    a = edge rt splitByLengthToFurtherSplits
    b::Graph g => g
    b = edge rt set
    c::Graph g => g
    c = merge a b

    d::Graph g => g
    d = edge splitByLengthToFurtherSplits splitByLegthToVirginica

    e:: Graph g => g
    e = edge splitByLengthToFurtherSplits splitByWidthToLeaves

    f:: Graph g => g
    f = merge c d

    g:: Graph g => g
    g = merge f e

    h:: Graph g => g
    h = edge splitByLegthToVirginica vrg

    i :: Graph g => g
    i = edge splitByWidthToLeaves vrg

    j:: Graph g => g
    j = edge splitByWidthToLeaves vrs

    k:: Graph g => g
    k = merge i j

    l:: Graph g => g
    l = merge g k

    m::Graph g => g
    m = merge l h