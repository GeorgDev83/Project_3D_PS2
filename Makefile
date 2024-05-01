EE_BIN  = cube.PS2.elf
EE_BIN_STRIPPED = cube.PS2.strip.elf
EE_BIN_PACKED = SLES_528.05
EE_SRCS = main.c
#$(wildcard ./source/*.c)
EE_OBJS = $(EE_SRCS:.c=.o)

EE_INCS     = -I$(PS2SDK)/ports/include -I./include -I$(PS2DEV)/gsKit/include
EE_LDFLAGS  = -L$(PS2SDK)/ports/lib -L$(PS2DEV)/gsKit/lib
EE_LIBS     = -ldraw -lmath3d -ldmakit -lgskit -lgskit_toolkit

EE_CXXFLAGS += -DPS2 -w -O3
#EE_CXXFLAGS += -DDEBUG

all:#$(EE_BIN)
	$(MAKE) $(EE_BIN_PACKED)

$(EE_BIN_STRIPPED): $(EE_BIN)
	echo "Stripping ..."
	$(EE_STRIP) -o $@ $<

$(EE_BIN_PACKED): $(EE_BIN_STRIPPED)
	echo "Compressing ..."
	ps2-packer -v $< $@

clean:
	rm -f $(EE_OBJS) $(EE_BIN) $(EE_BIN_STRIPPED) $(EE_BIN_PACKED)

include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal
