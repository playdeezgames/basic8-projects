CLASS Thingie
ENDCLASS
subject = LIST()
t1 = NEW(Thingie)
t2 = NEW(Thingie)
PUSH(subject,t1)
PUSH(subject,t2)
PRINT LEN(subject);
PRINT EXISTS(subject,t1);

drv = driver()

def update(delta)
enddef

update_with(drv, call(update))
