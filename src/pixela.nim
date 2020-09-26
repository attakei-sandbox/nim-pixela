import cligen
import commands/graph_command


when isMainModule:
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
  dispatchMulti(
    ["multi", usage = clUseMultiPerlish],
    [
      graph,
      doc = "Control graph",
      stopWords = @["list", "create"],
    ],
  )
