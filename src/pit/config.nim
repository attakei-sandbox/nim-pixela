## Configuration control module for pit
import options
import os
import "../pixelapkg/api_client"


type
  Config* = ref object
    ## Configurations in pit
    user*: string
    token*: string


const
  ENV_KEY_USER = "PIXELA_USER"
  ENV_KEY_TOKEN = "PIXELA_TOKEN"


var config: Option[Config] = none(Config)


proc initConfig*() =
  ## Create config from local file
  if config.isSome:
    return
  var cfg = Config()
  # Find values from environments.
  if os.existsEnv(ENV_KEY_USER):
    cfg.user = getEnv(ENV_KEY_USER)
  if os.existsEnv(ENV_KEY_TOKEN):
    cfg.token = getEnv(ENV_KEY_TOKEN)
  # Check stored
  if cfg.user == "" or cfg.token == "":
    raise newException(ValueError, "Cofnig must not be blank")

  config = some(cfg)


proc getConfig*(): Config =
  if config.isSome:
    return config.get()


proc initApiClient*(config: Config): ApiClient =
  return newApiClient(config.user, config.token)
