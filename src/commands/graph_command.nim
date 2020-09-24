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
