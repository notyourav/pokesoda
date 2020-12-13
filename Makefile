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
		graphics/graphics1.asm	\
		src/rom7.asm				\
		graphics/graphics2.asm

OBJS = $(SRCS:.asm=.obj)


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

$(TARGET).out: src/splash.asm $(OBJS)
	$(LK88) $(LKFLAGS) -o $@

%.obj: %.asm
	$(CC88) $(CFLAGS) -Tc-v -c -v -o $@ $<

src/splash.asm: src/splash.png
	$(PY) tools/splash.py

.PHONY: clean
clean:
	rm -f $(OBJS)
	rm -f $(TARGET).out $(TARGET).abs $(TARGET).map $(TARGET).hex
	rm -f $(TARGET).min
	rm -f $(COMPILED_ASM)
	rm -f src/splash.asm
