import "../pixelapkg/api/graph"
import "../pit/config"


proc list*(): int =
  ## List registered graphs.
  result = 0
  let apiClient = getConfig().initApiClient()
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
    timezone: string = "UTC",
  ): int =
  ## Create new graph
  let graph = newGraph(id, name, unit, qtype, color, timezone)
  let apiClient = getConfig().initApiClient()
  let resp = apiClient.postGraph(graph)
  if resp:
    echo "Added new post"
  else:
    echo "Failure"
