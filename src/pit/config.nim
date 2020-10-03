## Configuration control module for pit
import logging
import options
import os
import parsecfg
import "../pixela/api_client"


type
  Config* = ref object
    ## Configurations in pit
    user*: string
    token*: string


const
  ENV_KEY_PITCFG = "PIT_CONFIG"
  ENV_KEY_USER = "PIXELA_USER"
  ENV_KEY_TOKEN = "PIXELA_TOKEN"
  CONFIG_PIXELA_SECTION = "pixela"

var config: Option[Config] = none(Config)


proc findConfigFile(): Option[string] =
  ## Auto find config files
  ## 
  ## Order:
  ## - ``.pit.cfg``
  ## - ``$HOME/.pit.cfg``
  let candicates = @[
    os.getCurrentDir() & os.DirSep & ".pit.cfg",
    os.getHomeDir() & os.DirSep & ".pit.cfg",
  ]
  for c in candicates:
    if c.existsFile():
      return some(c)
  return none(string)


proc initConfig*() =
  ## Create config from local file
  if config.isSome:
    return
  var cfg = Config()

  # Load config values from file
  if existsEnv(ENV_KEY_PITCFG):
    let filepath = getEnv(ENV_KEY_PITCFG)
    info("Load config file from " & filepath)
    let fCfg = parsecfg.loadConfig(filepath)
    cfg.user = fCfg.getSectionValue(CONFIG_PIXELA_SECTION, "user")
    cfg.token = fCfg.getSectionValue(CONFIG_PIXELA_SECTION, "token")
  elif findConfigFile().isSome():
    let filepath = findConfigFile().get()
    echo("Load config file from " & filepath)
    let fCfg = parsecfg.loadConfig(filepath)
    cfg.user = fCfg.getSectionValue(CONFIG_PIXELA_SECTION, "user")
    cfg.token = fCfg.getSectionValue(CONFIG_PIXELA_SECTION, "token")

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
