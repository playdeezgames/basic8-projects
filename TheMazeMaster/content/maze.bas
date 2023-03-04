MAZE_COLUMNS=8
MAZE_ROWS=8
MAZE_CELL_OUTSIDE=0
MAZE_CELL_FRONTIER=1
MAZE_CELL_INSIDE=2

DIM MAZE_CELL_DOORS(MAZE_COLUMNS,MAZE_ROWS,DIRECTION_COUNT)
DIM MAZE_CELL_STATES(MAZE_COLUMNS,MAZE_ROWS)

DEF GET_MAZE_CELL_EXITS(MX,MY)
    C=0
    FOR DIR=DIRECTION_FIRST TO DIRECTION_LAST
        IF MAZE_CELL_DOORS(MX,MY,DIR) THEN
            C=C+1
        ENDIF
    NEXT DIR
    RETURN C
ENDDEF
DEF CLEAR_MAZE()
    FOR COLUMN=0 TO MAZE_COLUMNS-1
        FOR ROW=0 TO MAZE_ROWS-1
            MAZE_CELL_STATES(COLUMN,ROW)=MAZE_CELL_OUTSIDE
            FOR DIR=DIRECTION_FIRST TO DIRECTION_LAST
                MAZE_CELL_DOORS(COLUMN,ROW,DIR)=FALSE
            NEXT DIR
        NEXT ROW
    NEXT COLUMN
ENDDEF
DEF IS_MAZE_GENERATED()
    FOR COLUMN=0 TO MAZE_COLUMNS-1
        FOR ROW=0 TO MAZE_ROWS-1
            IF MAZE_CELL_STATES(COLUMN,ROW) <> MAZE_CELL_INSIDE THEN
                RETURN FALSE
            ENDIF
        NEXT ROW
    NEXT COLUMN
    RETURN TRUE
ENDDEF
DEF GENERATE_MAZE()
    CLEAR_MAZE()
    COLUMN=RND(0,MAZE_COLUMNS-1)
    ROW=RND(0,MAZE_ROWS-1)
    MAZE_CELL_STATES(COLUMN,ROW)=MAZE_CELL_INSIDE
    FOR DIR=DIRECTION_FIRST TO DIRECTION_LAST
        NEXT_COL=STEP_X(DIR,COLUMN,ROW)
        NEXT_ROW=STEP_Y(DIR,COLUMN,ROW)
        IF NEXT_COL>=0 AND NEXT_ROW>=0 AND NEXT_COL<MAZE_COLUMNS AND NEXT_ROW<MAZE_ROWS THEN
            MAZE_CELL_STATES(NEXT_COL,NEXT_ROW)=MAZE_CELL_FRONTIER
        ENDIF
    NEXT DIR
    DO
        DO
            COLUMN=RND(0,MAZE_COLUMNS-1)
            ROW=RND(0,MAZE_ROWS-1)
        UNTIL MAZE_CELL_STATES(COLUMN,ROW)=MAZE_CELL_FRONTIER
        DIM CANDIDATES(DIRECTION_COUNT)
        FOR DIR=DIRECTION_FIRST TO DIRECTION_LAST
            CANDIDATES(DIR)=FALSE
            NEXT_COL=STEP_X(DIR,COLUMN,ROW)
            NEXT_ROW=STEP_Y(DIR,COLUMN,ROW)
            IF NEXT_COL>=0 AND NEXT_ROW>=0 AND NEXT_COL<MAZE_COLUMNS AND NEXT_ROW<MAZE_ROWS THEN
                IF MAZE_CELL_STATES(NEXT_COL,NEXT_ROW)=MAZE_CELL_INSIDE THEN
                    CANDIDATES(DIR)=TRUE
                ENDIF
            ENDIF
        NEXT DIR
        DO
            DIR=RND(DIRECTION_FIRST,DIRECTION_LAST)
        UNTIL CANDIDATES(DIR)=TRUE
        MAZE_CELL_STATES(COLUMN,ROW)=MAZE_CELL_INSIDE
        MAZE_CELL_DOORS(COLUMN,ROW,DIR)=TRUE
        NEXT_COL=STEP_X(DIR,COLUMN,ROW)
        NEXT_ROW=STEP_Y(DIR,COLUMN,ROW)
        MAZE_CELL_DOORS(NEXT_COL,NEXT_ROW,OPPOSITE_DIRECTION(DIR))=TRUE
        FOR DIR=DIRECTION_FIRST TO DIRECTION_LAST
            NEXT_COL=STEP_X(DIR,COLUMN,ROW)
            NEXT_ROW=STEP_Y(DIR,COLUMN,ROW)
            IF NEXT_COL>=0 AND NEXT_ROW>=0 AND NEXT_COL<MAZE_COLUMNS AND NEXT_ROW<MAZE_ROWS THEN
                IF MAZE_CELL_STATES(NEXT_COL,NEXT_ROW)=MAZE_CELL_OUTSIDE THEN
                    MAZE_CELL_STATES(NEXT_COL,NEXT_ROW)=MAZE_CELL_FRONTIER
                ENDIF
            ENDIF
        NEXT DIR
    UNTIL IS_MAZE_GENERATED()
ENDDEF