## Pixe.la HTTP Client module
import httpclient
import json


const ENDPOINT_BASE = "https://pixe.la/v1"


type ApiClient* = ref object of RootObj
  ## Client object
  user: string
  token: string


proc newApiClient*(user: string, token: string): ApiClient =
  ## Create new api-client object.
  return ApiClient(user: user, token: token)

proc request*(apiClient: ApiClient, httpMethod: HttpMethod, path: string): JsonNode =
  let httpClient = newHttpClient()
  httpClient.headers.add("X-USER-TOKEN", apiClient.token)
  let url = ENDPOINT_BASE & "/users/" & apiClient.user & path
  let resp = httpClient.request(url, httpMethod = httpMethod)
  return parseJson(resp.body())
