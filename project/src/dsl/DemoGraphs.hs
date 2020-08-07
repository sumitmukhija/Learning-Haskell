module DemoGraphs where

    import Graph

    neuralNetworkWithNeurons:: Graph g => Int -> Int -> Int -> g
    neuralNetworkWithNeurons inputNeurons hiddenNeurons outputNeurons=
        neuralNet where 
            input = neuralNetInputLayer inputNeurons 
            hidden = neuralNetHiddenLayer hiddenNeurons 
            output = neuralNetOutputLayer outputNeurons 
            inputToHiddenGraph = connectInputAndHiddenNeurons input hidden
            hiddenToOutputGraph = connectHiddenAndOutputNeurons hidden output
            neuralNet = nnMergeVertices [hiddenToOutputGraph, inputToHiddenGraph]

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
    nnMergeVertices vertices = foldr (\acc x -> merge acc x) (empty) vertices
