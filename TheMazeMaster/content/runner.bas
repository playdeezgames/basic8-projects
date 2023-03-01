def create_maze_cell()
    result = DICT()
    result.neighbors=LIST(NIL,NIL,NIL,NIL)
    result.doors=LIST(NIL,NIL,NIL,NIL)
    return result
enddef

def create_maze(columns, rows)
print "START CREATING MAZE!";
    result = DICT()
    result.columns=columns
    result.rows=rows
    result.cells=LIST()
    while len(result.cells)<result.columns*result.rows
        PUSH(result.cells, create_maze_cell())
    wend
print "FINISH CREATING MAZE!";
    return result
enddef

mazeData = create_maze(8,8)

def update(delta)
enddef

def run()
    drv = driver()
    update_with(drv, call(update))
enddef

