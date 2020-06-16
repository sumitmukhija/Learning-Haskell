-- Module that attempts to emulate Pydot in Haskell
module Pydot where

import qualified Data.Map as M

data GraphType = Graph | Digraph deriving Show
data Edge = Edge [Char] [Char] deriving Show
data Dot = Dot GraphType [Edge] deriving Show

-- Representation of states
edge_state =  M.fromList([("c->d", [])])
graph_state = M.fromList([("Edges", edge_state)])

edge_list = [("A", "B"), ("C", "D")]
node_prefix = ""
directed = False

-- PYDOT: Equivalent to method graph from edges
-- https://github.com/pydot/pydot/blob/master/pydot.py#L304
-- @desc Creates graph from given edges
-- @steps
-- 1. Decides the type of graph & creates a Dot instance
-- 2. For each pair in edge_list, create Edge instance with concat node_prefix
-- 3. Add each Edge instance to graph
-- 4. Return graph/Dot instance
graphFromEdges:: [([Char], [Char])] -> [Char] -> Bool -> Dot
graphFromEdges edge_list node_prefix isDirected = 
    Dot (getGraphType False) (createEdgesFromListOfPoints edge_list node_prefix)

-- TODO://
-- PyDOT: Equivalent to method add edge
-- https://github.com/pydot/pydot/blob/master/pydot.py#L1238
-- @desc Adds edge to the graph
-- @steps
-- 1. Get edge points
-- 2. Check if edge points are in dictionary's edges. Append or Create
-- 3. Set sequence
-- 4. Set parent graph
-- addEdge (Edge src dest)  

-- Helper functions
-- Determines the root of the dot file. Can be one between `Graph` or `Digraph`
getGraphType:: Bool -> GraphType
getGraphType isDirected = if isDirected == True then Digraph else Graph

-- Creates a LIST of edges from ONE list of source-dest pairs
createEdgesFromListOfPoints:: [([Char], [Char])] -> [Char] -> [Edge]
createEdgesFromListOfPoints edge_list prefix = [edgeFromSrcDst (prefix++src) (prefix++dst) | (src, dst) <- edge_list]

-- Returns SINGLE edge from source and destination strings
edgeFromSrcDst:: [Char] -> [Char] -> Edge
edgeFromSrcDst src dst = Edge src dst

-- @Unused. Returns SINGLE edge from ONE source and destination tuple
edgeFromPair:: ([Char],[Char]) -> Edge
edgeFromPair (src,dst) = Edge src dst

-- Add ONE list of edges to graph
-- addListOfEdgesToGraph:: [Edge] -> [Edge]
-- addListOfEdgesToGraph edges = [addEdge edge | edge <- edges]
