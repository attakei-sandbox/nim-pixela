import cligen
import commands/graph_command


when isMainModule:
  dispatchMultiGen(
    ["graph"],
    [
      graph_command.list, doc = "List registered graphs",
    ],
  )
  dispatchMulti(
    ["multi", usage = clUseMultiPerlish],
    [
      graph, doc = "Control graph",
    ],
  )
