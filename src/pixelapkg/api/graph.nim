## Module for grapsh of API
import httpclient
import json
import strutils
import "../api_client"

type
  IDString = string
  Color = enum
    Green = "shibafu",
    Red = "momiji",
    Blue = "sora",
    Yellow = "ichou",
    Purple = "ajisai",
    Black = "kuro",
  NumType = enum
    Int = "int",
    Float = "float",

type Graph* = ref object
  id: IDString
  name: string
  unit: string
  numtype: NumType
  color: Color

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
      numtype: parseEnum[NumType](g["type"].getStr()),
      color: parseEnum[Color](g["color"].getStr()),
    )
    graphs.add(graph)
  return graphs
