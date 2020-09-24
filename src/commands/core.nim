import os
import "../pixelapkg/api_client"


proc initApiClient*(): ApiClient =
  var username = getEnv("PIXELA_USER")
  var token = getEnv("PIXELA_TOKEN")
  return newApiClient(userName, token)
