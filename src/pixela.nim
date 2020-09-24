import cligen
from commands/graph_command import graph


when isMainModule:
  dispatchMulti(
    [
      graph,
    ],
  )
