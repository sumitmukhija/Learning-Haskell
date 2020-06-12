
# PyDot to Haskell

### Pydot Observations:
- Used a collection of attributes for each element (node, graph, edge, cluster)
- `class frozendict` takes a dict and makes it non-editable
- `dot_keywords` is a list of  `'graph', 'subgraph', 'digraph', 'node', 'edge', 'strict'`
- `id_re_*` are regular expressions html, num, alpha num etc.
- Has two input sources - string, file path
- In the method `graph_from_edges` an initialiser `Dot` is called with `graph_type = 'digraph'|'graph'`. This is assigned to `graph`. Following this, from the list of edges, each edge tupple's 0th element and 1st element is checked to be string. Each edge element (0 and 1) is then appeneded to the `node_prefix`. An initialiser `Edge` is invoked with `src` and `dst`. The edge is added to the `graph`
- A class `Common` is inherited by classes `Node`, `Egde`, `Graph`, 

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


