import "./core"
import "../pixelapkg/api/graph"


proc graph*(list: bool = false): int =
  result = 0
  let apiClient = initApiClient()
  if list:
    var graphs = apiClient.getGraphs()
    echo("List of graphs")
    for g in graphs:
      echo("\t", g)
    return
