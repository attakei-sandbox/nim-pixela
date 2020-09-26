## Module for grapsh of API
import httpclient
import json
import strutils
import "../api_client"

type
  IDString* = string
  Color* = enum
    Green = "shibafu",
    Red = "momiji",
    Blue = "sora",
    Yellow = "ichou",
    Purple = "ajisai",
    Black = "kuro",
  QuantityType* = enum
    Int = "int",
    Float = "float",

type Graph* = ref object
  id: IDString
  name: string
  unit: string
  qtype: QuantityType
  color: Color

proc `$`*(g: Graph): string =
  return g.id & " =\t" & g.name


proc newGraph*(id: IDString, name: string, unit: string, qtype: QuantityType, color: Color): Graph =
  return Graph(
    id: id,
    name: name,
    unit: unit,
    qtype: qtype,
    color: color,
  )


proc getGraphs*(client: ApiClient): seq[Graph] =
  let data: JsonNode = client.request(HttpGet, "/graphs")
  var graphs: seq[Graph] = @[]
  for g in data["graphs"]:
    let graph = Graph(
      id: g["id"].getStr(),
      name: g["name"].getStr(),
      unit: g["unit"].getStr(),
      qtype: parseEnum[QuantityType](g["type"].getStr()),
      color: parseEnum[Color](g["color"].getStr()),
    )
    graphs.add(graph)
  return graphs


proc postGraph*(client: ApiClient, graph: Graph): bool =
  let body = newJObject()
  body["id"] = newJString(graph.id)
  body["name"] = newJString(graph.name)
  body["unit"] = newJString(graph.unit)
  body["type"] = newJString($graph.qtype)
  body["color"] = newJString($graph.color)
  let data = client.request(HttpPost, "/graphs", $body)
  result = data["isSuccess"].getBool()
  if not result:
    echo(data["message"].getStr())
