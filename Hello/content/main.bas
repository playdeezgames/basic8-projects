import "test.bas"
import "keycodes.bas"

dude = DICT()
dude("spr") = LOAD_RESOURCE("new_sprite.sprite")
dude.x=76
dude.y=60
print CODE_UP;

game_loop:
	if key CODE_UP then
		print "up";
	else
		print "-";
	endif
	sync
goto game_loop
