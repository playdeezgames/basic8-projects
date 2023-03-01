import "directions.bas"

CLASS maze_door
    VAR state=FALSE
    DEF is_open()
        return ME.state
    ENDDEF
    DEF set_open(o)
        ME.state=o
    ENDDEF
ENDCLASS

CLASS maze_cell
    VAR neighbors=LIST(NIL,NIL,NIL,NIL)
    VAR doors=LIST(NIL,NIL,NIL,NIL)
    DEF set_neighbor(d,n)
        SET(ME.neighbors,d,n)
    ENDDEF
    DEF get_neighbor(d)
        GET(ME.neighbors,d)
    ENDDEF
    DEF set_door(d,dr)
        SET(ME.doors,d,dr)
    ENDDEF
    DEF get_door(d)
        GET(ME.doors,d)
    ENDDEF
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
            print "("+STR(c)+","+STR(r)+")";
                cell = ME.get_cell(c,r)
                FOR d=0 TO 3
                    nc=c+GET(delta_column,d)
                    nr=r+GET(delta_row,d)
                    IF nc>=0 AND nc<ME.columns AND nr>=0 AND nr<ME.rows THEN
                        neighbor = ME.get_cell(nc,nr)
                        cell.set_neighbor(d,neighbor)
                        neighbor.set_neighbor(GET(opposite_directions,d),cell)
                        door = NEW(maze_door)
                        cell.set_door(d,door)
                        neighbor.set_neighbor(GET(opposite_directions,d),door)
                    ENDIF
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

