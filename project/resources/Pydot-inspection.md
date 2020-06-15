
# PyDot to Haskell

### Pydot Observations:
- Used a collection of attributes for each element (node, graph, edge, cluster)
- `class frozendict` takes a dict and makes it non-editable
- `dot_keywords` is a list of  `'graph', 'subgraph', 'digraph', 'node', 'edge', 'strict'`
- `id_re_*` are regular expressions html, num, alpha num etc.
- Has two input sources - string, file path
- In the method `graph_from_edges` an initialiser `Dot` is called with `graph_type = 'digraph'|'graph'`. This is assigned to `graph`. Following this, from the list of edges, each edge tupple's 0th element and 1st element is checked to be string. Each edge element (0 and 1) is then appeneded to the `node_prefix`. An initialiser `Edge` is invoked with `src` and `dst`. The edge is added to the `graph`
- A class `Common` is inherited by classes `Node`, `Egde`, `Graph`
- A class for `Error`

## Node
- class `Node` represents graph's node with name and attributes. Default value for name is ''. Attributes is a variable arg list. 
- An `obj_dict` is a representation of state of an element.
- An `obj_dict` contains attributes (dict), type (string), parent_graph, parent_node_list, sequence, name, port
- Not sure what port is? https://math.stackexchange.com/a/2597225 

### Edge
- Class edge takes src, dst - Both can be node objects or node strings.
- A var `points` is a tuple of src & dst node names. This is later added to the `obj_dict`
- self.create_attribute_methods?
-  What's the need for `__hash__`?
- `__eq__` compares two edges. If the parent graph is directed, arcs linking node A to B are considered equal and A->B != B->A
- `quote_if_necessary` is a helper function that adds quotes to the name of a node/graph/edge or the value of an attribute if necessary
- `get_parent_graph` returns the immediate parent graph and `get_parent_graph().get_top_graph()` gets the root graph type ('graph', 'digraph').
- `get_parent_graph` in common
- `get_top_graph` in Graph
- In string representation the graph type determines between `--` or `->`


### Graph
- init with name, type (graph/digraph), suppress_disconnected - false default - remove from the graph any disconnected nodes. simplify - avoid displaying equal edges, strict=False,
- The `obj_dict` for Graph has dicts for nodes, edges and subgraphs. 
- Also sets `self.obj_dict['current_child_sequence'] = 1` & `self.set_parent_graph(self)` ?
- Has a collection of `set_<entity>_default` functions.
- The graph is represented by node. Line 975, `set_graph_default` -- `self.add_node(Node('graph', **attrs))`
- `set_node_defaults` adds a node as default. `self.add_node(Node('node', **attrs))`
- `set_edge_defaults` adds `self.add_node( Node('edge', **attrs) )`
- All the `get_<entity>_default` functions follow a similar approach. 
  - **a**. First, they `get_node` with defaults ('graph', 'node', 'edge')
  - **b**. Result from **a**. is then Type checked  `isinstance( <entity>_nodes, (list, tuple)):`
  - **c**. if **b** is not true, return from **a**'s attributes are returned.
  - **d** else return [x.get_attributes() for x in **a**'s result ]
- `get_next_sequence_number` is `self.obj_dict['current_child_sequence'] + 1` where is it used? -- while adding node
- `del_node` deletes a node given its name and index. If index is None, all nodes with the name will be deleted. Index is the sequence number from the pt. above
- `get_node` Retrieves a node with name
- `get_nodes` and `get_nodes_list` returns the list of children nodes
- `add_edge`, `del_edge`, `add_subgraph`, `get_parent_graph`

### Subgraph 
- Inherits from `Graph`
- `init` with `(self, graph_name='', obj_dict=None, suppress_disconnected=False, simplify=False, **attrs):`

### Cluster
- Inherits from `Graph`
- `self.obj_dict['type'] = 'subgraph'; self.obj_dict['name'] = quote_if_necessary('cluster_'+graph_name)`

### Dot
- class Dot inherits from Graph
- Handles general representation

![PyDot](https://github.com/sumitmukhija/Learning-Haskell/tree/master/project/classes.png)

### Mapping APIs

|  Pydot        |  Description  |  arguments  | Haskell
| -------------    |:-------------:|:-------------:| ---------|
| `call_graphviz` | (`111`) Triggers a process with args, env, working directory| None | -
| `needs_quotes` | (`211`) Triggers a process with args, env, working directory| string `s` | -
| `graph_from_dot_data` | (`273`) Load graphs from DOT description | string `s` | -
| `graph_from_dot_file` | (`285`) Load graphs from DOT file | path p | -
| `graph_from_edges` | (`304`) Creates graph from a list of edges. The edge list has to be a list of tuples representing the nodes connected by the edge. | `edge_list`, `node_prefix=''`, `directed=False` | -
| `graph_from_adjancency_matrix` | (`339`) Creates a basic graph out of an adjacency matrix. The matrix has to be a list of rows of values representing an adjacency matrix.| `matrix, node_prefix= u'', directed=False` | TODO
| `graph_from_incidence_matrix` | (`376`) Creates a basic graph out of an incidence matrix. The matrix has to be a list of rows of values representing an incidence matrix. | path p | TODO


