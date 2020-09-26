import "./core"
import "../pixelapkg/api/graph"


proc list*(): int =
  ## List registered graphs.
  result = 0
  let apiClient = initApiClient()
  var graphs = apiClient.getGraphs()
  echo("List of graphs")
  for g in graphs:
    echo("\t", g)

proc create*(
    id: IDString, 
    name: string,
    unit: string,
    qtype: QuantityType,
    color: Color,
  ): int =
  ## Create new graph
  let graph = newGraph(id, name, unit, qtype, color)
  let apiClient = initApiClient()
  let resp = apiClient.postGraph(graph)
  if resp:
    echo "Added new post"
  else:
    echo "Failure"
