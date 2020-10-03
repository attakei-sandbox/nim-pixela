import cligen
import "./pit/commands/graph_command"
import "./pit/commands/pixel_command"
import "./pit/config"


when isMainModule:
  config.initConfig()
  dispatchMultiGen(
    ["graph"],
    [
      graph_command.list,
      mergeNames = @["graph list"],
    ],
    [
      graph_command.create,
      mergeNames = @["graph create"],
    ],
  )
  dispatchMultiGen(
    ["pixel"],
    [
      pixel_command.post,
      mergeNames = @["pixel post"],
    ],
  )
  dispatchMulti(
    ["multi", usage = clUseMultiPerlish],
    [
      graph,
      doc = "Control graph",
      stopWords = @["list", "create"],
    ],
    [
      pixel,
      doc = "Control pixel",
      stopWords = @["post"],
    ],
  )
