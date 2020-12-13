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
else ifdef HAS_WINE64
	WINE := wine64
	SREC_CAT := srec_cat
	POKEMINID := PokeMiniD
	POKEFLASH := pokeflash
else
	WINE :=
	POKEMINID := $(TOOLCHAIN_DIR)/bin-windows/PokeMiniD
	SREC_CAT := $(TOOLCHAIN_DIR)/bin-windows/srec_cat
	POKEFLASH := $(TOOLCHAIN_DIR)/bin-windows/pokeflash
endif

ASM_SOURCES = src/soda.asm
ASM_BUILDDIR = build/src

C88_DIR := $(TOOLCHAIN_DIR)/c88tools/bin
C88 := $(WINE) $(C88_DIR)/c88.exe
CC88 := $(WINE) $(C88_DIR)/cc88.exe
LC88 := $(WINE) $(C88_DIR)/lc88.exe

LDFLAGS += -Mc
CFLAGS += -Mc

LDFLAGS += -cl -v
CFLAGS += -g -I$(TOOLCHAIN_DIR)/include
LCFLAGS += -e -d pokemini -M

OBJS += $(C_SOURCES:.c=.obj)
OBJS += $(ASM_SOURCES:.asm=.obj)
COMPILED_ASM = $(C_SOURCES:.c=.c.asm)

#$(shell mkdir -p $(C_BUILDDIR) $(ASM_BUILDDIR) $(DATA_ASM_BUILDDIR))

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

$(TARGET).out: $(OBJS)
	$(CC88) $(LDFLAGS) -o $@ $^

%.c.asm: %.c
	$(C88) $(CFLAGS) -v -o $@ $<

%.obj: %.asm
	$(CC88) $(CFLAGS) -Tc-v -c -v -o $@ $<

%.obj: %.c
	$(CC88) $(CFLAGS) -Tc-v -c -v -o $@ $<


.PHONY: clean
clean:
	rm -f $(OBJS)
	rm -f $(TARGET).out $(TARGET).abs $(TARGET).map $(TARGET).hex
	rm -f $(TARGET).min
	rm -f $(COMPILED_ASM)
