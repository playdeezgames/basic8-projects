ROOM_ROWS=15
ROOM_COLUMNS=15
ROOM_CELL_WIDTH = 8
ROOM_CELL_HEIGHT = 8
ROOM_MAPS = LIST()
ROOM_CHAMBERS = LIST()
DEF BLIT_MAP(FROM_MAP,TO_MAP,L,TRANSPARENT_TILE)
    FOR X=0 TO ROOM_COLUMNS-1
        FOR Y=0 TO ROOM_ROWS-1
            T=MGET FROM_MAP,L,X,Y
            IF T<>TRANSPARENT_TILE THEN
                MSET TO_MAP,L,X,Y,T
            ENDIF
        NEXT Y
    NEXT X
ENDDEF
DEF IS_ROOM_CHAMBER(MX,MY)
    RETURN GET(ROOM_CHAMBERS,MX+MY*MAZE_COLUMNS)
ENDDEF
DEF GET_ROOM_MAP(COLUMN,ROW)
    RETURN GET(ROOM_MAPS,COLUMN+ROW*MAZE_COLUMNS)
ENDDEF
DEF PLACE_ROOM_DOORS()
    FOR MX=0 TO MAZE_COLUMNS-1
        FOR MY=0 TO MAZE_ROWS-1
            EXIT_COUNT=GET_MAZE_CELL_EXITS(MX,MY)
            IF EXIT_COUNT=1 THEN
                D=0
                WHILE NOT MAZE_CELL_DOORS(MX,MY,D)
                    D=D+1
                WEND
                IF IS_ROOM_CHAMBER(MX,MY) THEN
                    FM=CHAMBERDOOR_MAPS(D)
                ELSE
                    FM=PASSAGEWAYDOOR_MAPS(D)
                ENDIF
                TM=GET_ROOM_MAP(MX,MY)
                BLIT_MAP(FM,TM,1,239)
                NX=STEP_X(D,MX,MY)
                NY=STEP_Y(D,MX,MY)
                D=OPPOSITE_DIRECTION(D)
                IF IS_ROOM_CHAMBER(NX,NY) THEN
                    FM=CHAMBERDOOR_MAPS(D)
                ELSE
                    FM=PASSAGEWAYDOOR_MAPS(D)
                ENDIF
                TM=GET_ROOM_MAP(NX,NY)
                BLIT_MAP(FM,TM,1,239)
            ENDIF
        NEXT MY
    NEXT MX
ENDDEF
DEF GENERATE_ROOMS()
    CLEAR(ROOM_MAPS)
    FOR ROW=0 TO MAZE_ROWS-1
        FOR COLUMN=0 TO MAZE_COLUMNS-1
            TEMP=0
            FOR DIR=DIRECTION_FIRST TO DIRECTION_LAST
                IF MAZE_CELL_DOORS(COLUMN,ROW,DIR) THEN
                    TEMP=BOR(TEMP,SHL(1,DIR))
                ENDIF
            NEXT DIR
            EXIT_COUNT=GET_MAZE_CELL_EXITS(COLUMN,ROW)
            IS_CHAMBER=FALSE
            IF EXIT_COUNT=1 THEN
                IS_CHAMBER=TRUE
            ELSEIF EXIT_COUNT=2 THEN
                IF RND(0,99)<50 THEN
                    IS_CHAMBER=TRUE
                ENDIF
            ELSEIF EXIT_COUNT=3 THEN
                IF RND(0,99)<75 THEN
                    IS_CHAMBER=TRUE
                ENDIF
            ELSE
                IF RND(0,99)<25 THEN
                    IS_CHAMBER=TRUE
                ENDIF
            ENDIF
            IF IS_CHAMBER THEN
                ROOM_MAP=CLONE(CHAMBER_MAPS(TEMP))
            ELSE
                ROOM_MAP=CLONE(PASSAGEWAY_MAPS(TEMP))
            ENDIF
            PUSH(ROOM_CHAMBERS,IS_CHAMBER)
            PUSH(ROOM_MAPS,ROOM_MAP)
        NEXT COLUMN
    NEXT ROW
    PLACE_ROOM_DOORS()
ENDDEF
DEF GET_ROOM_TILE(MX,MY,X,Y)
    MP=GET_ROOM_MAP(MX,MY)
    RETURN MGET MP,1,X,Y
ENDDEF