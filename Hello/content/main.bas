import "keycodes.bas"
import "gamestates.bas"

room = LOAD_RESOURCE("new_map.map")
layer1 = room(1)

dude = DICT()
dude("spr") = LOAD_RESOURCE("new_sprite.sprite")
dude.x=76
dude.y=60

MAIN_LOOP:
	map room, 0 , 0
	text 0,0,"ohai",RGBA(0,0,0,255)
	sync
GOTO MAIN_LOOP

import "inplaystate.bas"