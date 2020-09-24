import os
import pixelapkg/api_client
import pixelapkg/api/graph as graph_api


proc initApiClient(): ApiClient =
  var username = getEnv("PIXELA_USER")
  var token = getEnv("PIXELA_TOKEN")
  return newApiClient(userName, token)


proc graph(list: bool = false): int =
  result = 0
  let apiClient = initApiClient()
  if list:
    var graphs = apiClient.getGraphs()
    echo("List of graphs")
    for g in graphs:
      echo("\t", g)
    return


when isMainModule:
  import cligen
  dispatchMulti([
    graph,
  ])
