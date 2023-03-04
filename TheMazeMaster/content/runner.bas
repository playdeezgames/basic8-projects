'UTILITY
IMPORT "keycodes.bas"
'RENDERABLES
IMPORT "displaymap.bas"
IMPORT "PASSAGEWAYS.BAS"
IMPORT "PASSAGEWAYDOORS.BAS"
IMPORT "CHAMBERS.BAS"
IMPORT "CHAMBERDOORS.BAS"
IMPORT "CREATURESPRITES.BAS"
'DATA
IMPORT "directions.bas"
IMPORT "maze.bas"
IMPORT "TILES.BAS"
IMPORT "ROOM.BAS"
IMPORT "CREATURETYPES.BAS"
IMPORT "CREATURES.BAS"
IMPORT "PLAYER.BAS"
IMPORT "GAME.BAS"
'MACHINE
IMPORT "STATEMACHINE.BAS"

DEF RUN()
    DRV = DRIVER()
    UPDATE_WITH(DRV, CALL(STATE_MACHINE_UPDATE))
ENDDEF

