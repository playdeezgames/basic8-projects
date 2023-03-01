IN_PLAY_LOOP:
    map room("layer1"),0,0
	spr dude("spr"), dude.x, dude.y
	gosub IN_PLAY_INPUT
	sync
goto IN_PLAY_LOOP

IN_PLAY_INPUT:
	if key CODE_UP then
		dude.y=dude.y-1
	endif
	if key CODE_DOWN then
		dude.y=dude.y+1
	endif
	if key CODE_LEFT then
		dude.x=dude.x-1
	endif
	if key CODE_RIGHT then
		dude.x=dude.x+1
	endif
return