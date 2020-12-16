TOOLCHAIN_DIR := tools/toolchain
TARGET = soda

SHA1 := $(shell { command -v sha1sum || command -v shasum; } 2>/dev/null) -c

HAS_WINE := $(shell wine --version 2>/dev/null)
HAS_WINE64 := $(shell wine64 --version 2>/dev/null)

ifdef HAS_WINE
	WINE := wine
	SREC_CAT := srec_cat
	POKEMINID := PokeMiniD
	POKEFLASH := pokeflash
    PY := python3
else ifdef HAS_WINE64
	WINE := wine64
	SREC_CAT := srec_cat
	POKEMINID := PokeMiniD
	POKEFLASH := pokeflash
    PY := python3
else
	WINE :=
	POKEMINID := $(TOOLCHAIN_DIR)/bin-windows/PokeMiniD
	SREC_CAT := $(TOOLCHAIN_DIR)/bin-windows/srec_cat
	POKEFLASH := $(TOOLCHAIN_DIR)/bin-windows/pokeflash
    PY := py -3
endif


# Linking order

SRCS :=	src/ram.asm					\
		src/rom0.asm				\
		src/rom1.asm				\
		src/rom2.asm				\
		src/rom3.asm				\
		graphics/graphics1.asm		\
		src/rom7.asm				\
		graphics/graphics2.asm

OBJS = $(SRCS:.asm=.obj)


IMGSRCS :=  src/splash.png

TILEMAPS := graphics/eeprom_font.png        \
            graphics/eeprom_dialogues.png   \
            graphics/name_entry.png         \
            graphics/unk_dialogues.png      \
            graphics/datetime.png           \
            graphics/034800-035000.png      \
            graphics/inside.png             \
            graphics/outside.png            \
            graphics/036c00-037180.png      \
            graphics/dialogue_font.png      \
            graphics/059c00-05a900.png      \
            graphics/title_screen.png       \
            graphics/065200-065700.png      \
            graphics/tree_frame0.png        \
            graphics/tree_frame1.png        \
            graphics/garden_frame0.png      \
            graphics/garden_frame1.png      \
            graphics/more_faces.png         \
            graphics/even_more_faces.png    \
            graphics/068f00-069700.png      \
            graphics/levels.png             \
            graphics/copyright.png

SPRITES :=  graphics/settings.png           \
            graphics/021000-021700.png      \
            graphics/021700.png             \
            graphics/numbers.png            \
            graphics/dialogue.png           \
            graphics/torchic.png            \
            graphics/treecko.png            \
            graphics/mudkip.png             \
            graphics/torchic_closeup.png    \
            graphics/treecko_closeup.png    \
            graphics/mudkip_closeup.png     \
            graphics/other_mons.png         \
            graphics/menu.png               \
            graphics/faces.png              \
            graphics/torchic_additional.png \
            graphics/treecko_additional.png \
            graphics/mudkip_additional.png  \
            graphics/misc.png

CONVERTED_IMGS = $(IMGSRCS:.png=.asm)
CONVERTED_TILES = $(TILEMAPS:.png=.tiles)
CONVERTED_SPRITES = $(SPRITES:.png=.sprites)

# Tools

C88_DIR := $(TOOLCHAIN_DIR)/c88tools/bin
AS88 := $(WINE) $(C88_DIR)/as88.exe 
C88 := $(WINE) $(C88_DIR)/c88.exe
CC88 := $(WINE) $(C88_DIR)/cc88.exe
LC88 := $(WINE) $(C88_DIR)/lc88.exe
LK88 := $(WINE) $(C88_DIR)/lk88.exe 


# Flags

CFLAGS += -g -I$(TOOLCHAIN_DIR)/include
LCFLAGS += -e -d pokemini -M
LKFLAGS += $(OBJS)
ASFLAGS += -v


# Steps

.SUFFIXES:

.PHONY: all, run, assembly
all: $(TARGET).min
	$(shell dd conv=notrunc if=baserom.min of=$(TARGET).min count=1 bs=8448)
	@$(SHA1) pokesoda.sha1

assembly: $(COMPILED_ASM)

run: $(TARGET).min
	$(POKEMINID) $<

flash: $(TARGET).min
	$(POKEFLASH) /w $<

%.min: %.hex
	$(SREC_CAT) $< -o $@ -binary

%.hex %.map: %.out
	$(LC88) $(LCFLAGS) -f2 -o $@ $<

%.abs %.map: %.out
	$(LC88) $(LCFLAGS) -o $@ $<

$(TARGET).out: $(CONVERTED_IMGS) $(CONVERTED_TILES) $(CONVERTED_SPRITES) $(OBJS)
	$(LK88) $(LKFLAGS) -o $@

%.obj: %.asm
	$(CC88) $(CFLAGS) -Tc-v -c -v -o $@ $<

src/splash.asm: src/splash.png
	$(PY) tools/splash.py

%.tiles: %.png
	$(PY) tools/graphics.py t $< $@
    
%.sprites: %.png
	$(PY) tools/graphics.py s $< $@

.PHONY: clean
clean:
	rm -f $(OBJS)
	rm -f $(TARGET).out $(TARGET).abs $(TARGET).map $(TARGET).hex
	rm -f $(TARGET).min
	rm -f $(COMPILED_ASM)
	rm -f $(CONVERTED_IMGS) $(CONVERTED_TILES) $(CONVERTED_SPRITES)
