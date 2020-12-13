    include "src/audio/bgm.inc"

bgm0:
	DB 0F0h

bgm1:
	DB 0F0h
	
	include "src/audio/bgm_break.asm"

	include "src/audio/bgm_settings.asm"
	
    include "src/audio/bgm_menu.asm"

	include "src/audio/bgm_itembox.asm"

	include "src/audio/bgm_help.asm"
	
	include "src/audio/bgm_connect.asm"

	include "src/audio/bgm_pokeselect.asm"

	include "src/audio/bgm_title.asm"

    include "src/audio/bgm_unk.asm"