# st - simple terminal
# See LICENSE file for copyright and license details.
.POSIX:

include config.mk

SRC = st.c x.c $(LIGATURES_C) $(SIXEL_C)
OBJ = $(SRC:.c=.o)

all: st

config.h:
	cp config.def.h config.h

patches.h:
	cp patches.def.h patches.h

.c.o:
	$(CC) $(STCFLAGS) -c $<

st.o: config.h st.h win.h
x.o: arg.h config.h st.h win.h $(LIGATURES_H)

$(OBJ): config.h config.mk patches.h

st: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

install: st
	chmod 777 st
	strip st
	chmod 755 st
	touch -t 202001010000 st
	mv -f st $(DESTDIR)$(PREFIX)/bin
	rm -f st $(OBJ) st-$(VERSION).tar.gz

.PHONY: all clean dist install uninstall
