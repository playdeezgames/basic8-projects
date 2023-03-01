import "directions.bas"

CLASS maze_door
ENDCLASS

CLASS maze_cell
    VAR neighbors=LIST(NIL,NIL,NIL,NIL)
    VAR doors=LIST(NIL,NIL,NIL,NIL)
ENDCLASS

CLASS maze
    VAR columns=0
    VAR rows=0
    VAR cells=LIST()
    DEF get_cell(c,r)
        IF c<0 OR r<0 OR c>ME.columns OR r>ME.rows THEN
            RETURN NIL
        ENDIF
        RETURN GET(ME.cells,c+r*ME.columns)
    ENDDEF
    DEF init(c,r)
        ME.columns=c
        ME.rows=r
        CLEAR(ME.cells)
        WHILE LEN(ME.cells)<ME.columns*ME.rows
            PUSH(ME.cells,NEW(maze_cell))
        WEND
        FOR c=0 TO ME.columns-1
            FOR r=0 TO ME.rows-1
                cell = ME.get_cell(c,r)
                FOR d=0 TO 3
                    nc=c+GET(delta_column,d)
                    nr=r+GET(delta_row,d)
                    
                NEXT d
            NEXT r
        NEXT c
    ENDDEF
ENDCLASS

mazeData = NEW(maze)
mazeData.init(8,8)

def update(delta)
enddef

def run()
    drv = driver()
    update_with(drv, call(update))
enddef

