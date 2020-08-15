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

-- Example 2 - Decision Tree
    leftSubtree root left = edge root left
 
    rightSubtree root right = merge (edge root right) (rightSubtreeLevel2 right)

    rightSubtreeLevel2 root = merge (edge root "length <= 5.05") (rightSubtreeLevel3 root)
        
    rightSubtreeLevel3 root = merge (rightSubtreeLevel3Right root) (rightSubtreeLevel3Left root) 

    rightSubtreeLevel3Left root = merge (merge (edge "Width <= 1.65" "Virginica") (edge root "Width <= 1.65")) 
                                    (merge (edge "Width <= 1.65" "Versicolor") (edge root "Width <= 1.65"))

    rightSubtreeLevel3Right root = (edge "length <= 5.05" "Virginica")

    colorLeafNodes tree = coloredTree where 
        vertices = getGraphVertices tree
        leafNodes = 
            [setVertexAttribute v (VtxFillColour "green") tree| (v, _) <- vertices, 
            v == "Virginica" || v == "Versicolor" || v == "Setosa"]
        coloredTree = mergeMultipleGraphs leafNodes
        
    getCompleteTree root left right = merge (leftSubtree root left) (rightSubtree root right) 

    applyLabels tree = labelsApplied where
        rootSitosa = setEdgeAttribute "width <= 0.8" "Setosa" (EdLabel "True") tree
        subtree1 = setEdgeAttribute "width <= 0.8" "length <= 4.95" (EdLabel "False") rootSitosa
        subtree2 = setEdgeAttribute "length <= 4.95" "Width <= 1.65" (EdLabel "True") subtree1
        subtree3 = setEdgeAttribute "length <= 4.95" "length <= 5.05" (EdLabel "False") subtree2
        subtree4 = setEdgeAttribute "length <= 5.05" "Virginica" (EdLabel "True or False") subtree3
        subtree5 = setEdgeAttribute "Width <= 1.65" "Virginica" (EdLabel "False") subtree4
        subtree6 = setEdgeAttribute "Width <= 1.65" "Versicolor" (EdLabel "True") subtree5
        labelsApplied = subtree6

    decisionTree root left right = applyLabels (colorLeafNodes (getCompleteTree root left right))
    