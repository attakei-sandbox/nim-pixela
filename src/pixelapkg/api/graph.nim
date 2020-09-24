## Module for grapsh of API
import httpclient
import json
import "../api_client"

type Graph* = ref object
  id: string
  name: string
  unit: string
  numtype: string
  color: string

proc `$`*(g: Graph): string =
  return g.id & " =\t" & g.name

proc getGraphs*(client: ApiClient): seq[Graph] =
  let data: JsonNode = client.request(HttpGet, "/graphs")
  var graphs: seq[Graph] = @[]
  for g in data["graphs"]:
    let graph = Graph(
      id: g["id"].getStr(),
      name: g["name"].getStr(),
      unit: g["unit"].getStr(),
      numtype: g["type"].getStr(),
      color: g["color"].getStr(),
    )
    graphs.add(graph)
  return graphs
