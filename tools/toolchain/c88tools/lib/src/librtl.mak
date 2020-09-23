#
# librtl.mak
# module definitions for lib\librtl.a
#
ASFLAGS = -I$(SRCDIRSEP) -O -Ml
CFLAGS  = -I$(SRCDIRSEP) -Ml

TARGOBJ += $(OBJDIRSEP)shrui.obj
$(OBJDIRSEP)shrui.obj: $(SRCDIRSEP)shrui.asm  
	$(AS) $(SRCDIRSEP)shrui.asm -o $(OBJDIRSEP)shrui.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)shrsi.obj
$(OBJDIRSEP)shrsi.obj: $(SRCDIRSEP)shrsi.asm  
	$(AS) $(SRCDIRSEP)shrsi.asm -o $(OBJDIRSEP)shrsi.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)shlxi.obj
$(OBJDIRSEP)shlxi.obj: $(SRCDIRSEP)shlxi.asm  
	$(AS) $(SRCDIRSEP)shlxi.asm -o $(OBJDIRSEP)shlxi.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)divsc.obj
$(OBJDIRSEP)divsc.obj: $(SRCDIRSEP)divsc.asm  
	$(AS) $(SRCDIRSEP)divsc.asm -o $(OBJDIRSEP)divsc.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)divui.obj
$(OBJDIRSEP)divui.obj: $(SRCDIRSEP)divui.asm  
	$(AS) $(SRCDIRSEP)divui.asm -o $(OBJDIRSEP)divui.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)divsi.obj
$(OBJDIRSEP)divsi.obj: $(SRCDIRSEP)divsi.asm  
	$(AS) $(SRCDIRSEP)divsi.asm -o $(OBJDIRSEP)divsi.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)mulxi.obj
$(OBJDIRSEP)mulxi.obj: $(SRCDIRSEP)mulxi.asm  
	$(AS) $(SRCDIRSEP)mulxi.asm -o $(OBJDIRSEP)mulxi.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)divul.obj
$(OBJDIRSEP)divul.obj: $(SRCDIRSEP)divul.asm  
	$(AS) $(SRCDIRSEP)divul.asm -o $(OBJDIRSEP)divul.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)divsl.obj
$(OBJDIRSEP)divsl.obj: $(SRCDIRSEP)divsl.asm  
	$(AS) $(SRCDIRSEP)divsl.asm -o $(OBJDIRSEP)divsl.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)mulxl.obj
$(OBJDIRSEP)mulxl.obj: $(SRCDIRSEP)mulxl.asm  
	$(AS) $(SRCDIRSEP)mulxl.asm -o $(OBJDIRSEP)mulxl.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)shrul.obj
$(OBJDIRSEP)shrul.obj: $(SRCDIRSEP)shrul.asm  
	$(AS) $(SRCDIRSEP)shrul.asm -o $(OBJDIRSEP)shrul.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)shrsl.obj
$(OBJDIRSEP)shrsl.obj: $(SRCDIRSEP)shrsl.asm  
	$(AS) $(SRCDIRSEP)shrsl.asm -o $(OBJDIRSEP)shrsl.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)shlxl.obj
$(OBJDIRSEP)shlxl.obj: $(SRCDIRSEP)shlxl.asm  
	$(AS) $(SRCDIRSEP)shlxl.asm -o $(OBJDIRSEP)shlxl.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)andxl.obj
$(OBJDIRSEP)andxl.obj: $(SRCDIRSEP)andxl.asm  
	$(AS) $(SRCDIRSEP)andxl.asm -o $(OBJDIRSEP)andxl.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)orxl.obj
$(OBJDIRSEP)orxl.obj: $(SRCDIRSEP)orxl.asm  
	$(AS) $(SRCDIRSEP)orxl.asm -o $(OBJDIRSEP)orxl.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)xorxl.obj
$(OBJDIRSEP)xorxl.obj: $(SRCDIRSEP)xorxl.asm  
	$(AS) $(SRCDIRSEP)xorxl.asm -o $(OBJDIRSEP)xorxl.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)cmpul.obj
$(OBJDIRSEP)cmpul.obj: $(SRCDIRSEP)cmpul.asm  
	$(AS) $(SRCDIRSEP)cmpul.asm -o $(OBJDIRSEP)cmpul.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)cmpsl.obj
$(OBJDIRSEP)cmpsl.obj: $(SRCDIRSEP)cmpsl.asm  
	$(AS) $(SRCDIRSEP)cmpsl.asm -o $(OBJDIRSEP)cmpsl.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)negxl.obj
$(OBJDIRSEP)negxl.obj: $(SRCDIRSEP)negxl.asm  
	$(AS) $(SRCDIRSEP)negxl.asm -o $(OBJDIRSEP)negxl.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)blcps.obj
$(OBJDIRSEP)blcps.obj: $(SRCDIRSEP)blcps.asm  
	$(AS) $(SRCDIRSEP)blcps.asm -o $(OBJDIRSEP)blcps.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)blcph.obj
$(OBJDIRSEP)blcph.obj: $(SRCDIRSEP)blcph.asm  
	$(AS) $(SRCDIRSEP)blcph.asm -o $(OBJDIRSEP)blcph.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)blcphh.obj
$(OBJDIRSEP)blcphh.obj: $(SRCDIRSEP)blcphh.asm  
	$(AS) $(SRCDIRSEP)blcphh.asm -o $(OBJDIRSEP)blcphh.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)icr.obj
$(OBJDIRSEP)icr.obj: $(SRCDIRSEP)icr.asm  
	$(AS) $(SRCDIRSEP)icr.asm -o $(OBJDIRSEP)icr.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)icl.obj
$(OBJDIRSEP)icl.obj: $(SRCDIRSEP)icl.asm  
	$(AS) $(SRCDIRSEP)icl.asm -o $(OBJDIRSEP)icl.obj $(ASFLAGS) 

