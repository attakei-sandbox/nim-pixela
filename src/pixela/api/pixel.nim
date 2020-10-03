## Module for pixel of API
import httpclient
import json
import "../api"
import "./graph"

type
  DateString* = string
  QuantityString* = string
  PixelRequest* = ref object
    graphID: IDString
    date: DateString
    quantity: QuantityString


proc newPixelRequest*(
    graphID: IDString,
    date: DateString,
    quantity: QuantityString,
  ): PixelRequest =
  ## Generate pixel record object
  return PixelRequest(
    graphID: graphID,
    date: date,
    quantity: quantity,
  )


proc postPixel*(client: ApiClient, req: PixelRequest): bool =
  let url = "/graphs/" & req.graphID
  let body = newJObject()
  body["date"] = newJString(req.date)
  body["quantity"] = newJString(req.quantity)
  let data = client.request(HttpPost, url, $body)
  result = data["isSuccess"].getBool()
  if not result:
    echo(data["message"].getStr())
