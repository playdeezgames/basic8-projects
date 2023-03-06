DEF ROLL_DICE(D,M)
    R=0
    WHILE D>0 AND R<M
        D=D-1
        IF RND(1,6)=6 THEN
            R=R+1
        ENDIF
    WEND
    RETURN R
ENDDEF