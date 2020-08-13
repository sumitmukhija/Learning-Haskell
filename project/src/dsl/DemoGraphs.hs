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

    neuralNetInputLayer:: Graph g => Int -> g
    neuralNetInputLayer noOfNeurons = 
        nnMergeVertices (nnGetNVerticesOfKind noOfNeurons "input")

    neuralNetHiddenLayer:: Graph g => Int -> g
    neuralNetHiddenLayer noOfNeurons = 
        nnMergeVertices (nnGetNVerticesOfKind noOfNeurons "hidden")

    neuralNetOutputLayer:: Graph g => Int -> g
    neuralNetOutputLayer noOfNeurons = 
        nnMergeVertices (nnGetNVerticesOfKind noOfNeurons "output")

    nnGetNVerticesOfKind:: Graph g => Int -> String -> [g]
    nnGetNVerticesOfKind n kind = [vertex (nnGetVertex kind a)| a <- [1..n]]

    nnGetVertex:: String -> Int -> String
    nnGetVertex entity number = entity ++ " "++ (show number)

    nnMergeVertices:: Graph g => [g] -> g
    nnMergeVertices vertices = mergeMultipleGraphs vertices

-- Example 2 - Decision Tree
    decisionTreeExample :: Graph g => g 
    decisionTreeExample = (rootNode "petal width <= 0.8")

    rootToLevelOne:: Graph g => g
    rootToLevelOne = mergeMultipleGraphs ([(rootNode "petal width <= 0.8")] ++ levelOneNodes)

    levelOneNodes:: Graph g => [g]
    levelOneNodes = [(leafNode "Setosa"), (nonRootNode "petal size <= 4.95")]

    levelTwoNodes:: Graph g => [g]
    levelTwoNodes = [(nonRootNode "petal size <= 1.65"), (nonRootNode "petal size <= 5.05")]

    rootNode:: Graph g => String -> g
    rootNode split = treeNodeWithSplit split True

    nonRootNode:: Graph g => String -> g
    nonRootNode split = treeNodeWithSplit split False

    leafNode:: Graph g => String -> g
    leafNode classification = vertex classification

    treeNodeWithSplit:: Graph g => String -> Bool -> g
    treeNodeWithSplit splitCondition isRoot = vertex splitCondition

