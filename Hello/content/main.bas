import "keycodes.bas"

dude = DICT()
dude("spr") = LOAD_RESOURCE("new_sprite.sprite")
dude.x=76
dude.y=60

game_loop:
	spr dude("spr"), dude.x, dude.y
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
	sync
goto game_loop
