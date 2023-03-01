import "directions.bas"
import "maze.bas"

'mazeData = NEW(maze)
'mazeData.init(8,8)
'mazeData.dump()
'mazeData.generate()

display_map = LOAD_RESOURCE("maze.map")

def update(delta)
    MAP display_map,0,0
enddef

def run()
    drv = driver()
    update_with(drv, call(update))
enddef

