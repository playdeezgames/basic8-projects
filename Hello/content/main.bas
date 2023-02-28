import "keycodes.bas"
import "gamestates.bas"

dude = DICT()
dude("spr") = LOAD_RESOURCE("new_sprite.sprite")
dude.x=76
dude.y=60

MAIN_LOOP:
	if CURRENT_STATE=STATE_IN_PLAY then
		gosub IN_PLAY_LOOP
	endif
GOTO MAIN_LOOP

import "inplaystate.bas"