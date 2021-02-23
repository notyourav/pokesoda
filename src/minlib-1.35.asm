minlib_reset_audio_registers:

	LD BR,#20h ; 3b2b
	LD EP,#00h ; 3b2d

	LD [BR:TMR3_CTRL_L],#(TMR_16BIT | TMR_RESET)
	LD [BR:TMR3_CTRL_H],#00h ; 3b33

	AND [BR:AUD_CTRL],#0FFh^3
	AND [BR:AUD_VOL],#0FFh^3
	OR [BR:AUD_VOL],#3

	AND [BR:TMR1_OSC],#0DFh ; 3b3f
	OR [BR:TMR1_OSC],#20h ; 3b42
	LD [BR:TMR3_SCALE],#08h ; 3b45
	LD [BR:TMR3_OSC],#00h ; 3b48
	AND [BR:TMR2_SCALE],#0Fh ; 3b4b
	OR [BR:TMR2_SCALE],#0D0h ; 3b4e
	AND [BR:TMR2_OSC],#0FDh ; 3b51

	AND [BR:IRQ_PRI1],#0C0h ; 3b54
	OR [BR:IRQ_PRI1],#20h ; 3b57

	AND [BR:IRQ_ENA1],#IRQ1_PRC_COMPLETE
	OR [BR:IRQ_ENA1],#IRQ1_TIM2_HI_UF

	AND [BR:TMR2_CTRL_L],#0FFh^TMR_16BIT
	LD [BR:TMR2_PRE_H],#0FFh ; 3b63
	LD [BR:TMR2_CTRL_H],#(TMR_ENABLE | TMR_RESET)

	CARL loc_0x003FE1 ; 3b69

	LD A,#03h ; 3b6c
	LD [mn_bgm_vol],A ; 3b6e
	LD [mn_sfx_vol],A ; 3b72

	RET

; ---------------------- ; 3b76
loc_0x003B77:

	LD BR,#20h ; 3b77
	LD EP,#00h ; 3b79
	AND [BR:IRQ_ENA1],#0DFh ; 3b7c

	LD A,[BR:AUD_VOL] ; 3b7f
	AND A,#0FFh^3
	LD [BR:AUD_VOL],A ; 3b83

	RET

; ---------------------- ; 3b85
loc_0x003B86:

	LD BR,#20h ; 3b86
	LD EP,#00h ; 3b88
	OR [BR:IRQ_ENA1],#IRQ1_TIM2_HI_UF

	RET

; ---------------------- ; 3b8e
loc_0x003B8F:

	LD BR,#20h ; 3b8f
	LD EP,#00h ; 3b91
    
	LD A,[mn_current_bgm] ; 3b94
	LD [mn_bgm_tmp],A ; 3b98
    
	LD A,#00h ; 3b9c
	LD [mn_current_bgm],A ; 3b9e
    
	LD A,[BR:71h] ; 3ba2
	AND A,#0FCh ; 3ba4
	LD [BR:71h],A ; 3ba6
    
	RET
    
; ---------------------- ; 3ba8
loc_0x003BA9:

	LD BR,#20h ; 3ba9
	LD EP,#00h ; 3bab
    
	LD A,[mn_bgm_tmp] ; 3bae
	LD [mn_current_bgm],A ; 3bb2
    
	LD A,#00h ; 3bb6
	LD [mn_bgm_tmp],A ; 3bb8
    
	RET
    
; ---------------------- ; 3bb8
IRQ_Timer2HI_Underflow:

	PUSH ALE ; 3bbd
	
	; disable the interrupt from firing again
	LD BR,#20h ; 3bbf
	LD EP,#00h ; 3bc1
	LD [BR:27h],#20h ; 3bc4

	; branch if pending sfx is odd?
	LD A,[mn_pending_sfx] ; 3bc7
	BIT A,#0FFh ; 3bcb
	JRS NZ,loc_0x003C10 ; 3bcd

	LD A,[mn_current_sfx] ; 3bcf
	BIT A,#0FFh ; 3bd3
	JRL NZ,loc_0x003C36 ; 3bd5

loc_0x003BD8:

	LD A,[mn_bgm_tmp] ; 3bd8
	BIT A,#0FFh ; 3bdc
	JRS NZ,loc_0x003BF5 ; 3bde

	LD A,[mn_pending_bgm] ; 3be0
	BIT A,#0FFh ; 3be4
	JRL NZ,loc_0x003CAE ; 3be6

	LD A,[mn_current_bgm] ; 3be9
	BIT A,#0FFh ; 3bed
	JRL NZ,loc_0x003D18 ; 3bef

	POP ALE ; 3bf2

	RETE

; ---------------------- ; 3bf4
loc_0x003BF5:

	POP ALE ; 3bf5

	RETE

; ---------------------- ; 3bf7
loc_0x003BF8:

	LD A,[mn_sfx_page] ; 3bf8
	LD XP,A ; 3bfc
	LD A,#00h ; 3bfe
	LD [mn_pending_sfx],A ; 3c00
	LD [u8_14fc],A ; 3c04

	JRS loc_0x003C36

; ---------------------- ; 3c08
loc_0x003C0A:

	LD A,[mn_sfx_page] ; 3c0a
	JRS loc_0x003C4E

; ---------------------- ; 3c0e
loc_0x003C10:

	LD [mn_current_sfx],A ; 3c10
	CP A,#0FFh ; 3c14
	JRS Z,loc_0x003BF8 ; 3c16

	LD L,#02h ; 3c18
	MLT ; 3c1a

	LD A,[mn_sfx_table_page] ; 3c1c
	LD XP,A ; 3c20
	LD IX,#6A77h ; 3c22
	ADD IX,HL ; 3c25
	LD BA,[IX] ; 3c27
	LD [mn_sfx_index],BA ; 3c29

	LD A,#00h ; 3c2c
	LD [mn_pending_sfx],A ; 3c2e
	LD [u8_14fc],A ; 3c32

loc_0x003C36:

	LD A,[u8_14fc] ; 3c36
	CP A,#00h ; 3c3a
	JRL NZ,loc_0x003C8A ; 3c3c

	AND [BR:48h],#0FBh ; 3c3f
	LD A,[mn_current_sfx] ; 3c42
	CP A,#0FFh ; 3c46
	JRS Z,loc_0x003C0A ; 3c48

	LD A,[mn_sfx_table_page] ; 3c4a

loc_0x003C4E:

	LD XP,A ; 3c4e
	LD IX,[mn_sfx_index] ; 3c50
	LD A,[IX] ; 3c53
	CP A,#0FFh ; 3c54
	JRS Z,loc_0x003C96 ; 3c56

	AND A,[mn_sfx_vol] ; 3c58
	LD B,[BR:71h] ; 3c5b
	AND B,#0FCh ; 3c5d
	ADD A,B ; 3c60
	LD [BR:71h],A ; 3c61

	ADD IX,#0001h ; 3c63
	LD A,[IX] ; 3c66
	DEC A ; 3c67
	LD [u8_14fc],A ; 3c68

	ADD IX,#0001h ; 3c6c
	LD BA,[IX] ; 3c6f
	LD [BR:4Ah],A ; 3c71
	LD [BR:4Bh],B ; 3c73

	ADD IX,#0002h ; 3c75
	LD BA,[IX] ; 3c78
	LD [BR:4Ch],A ; 3c7a
	LD [BR:4Dh],B ; 3c7c

	ADD IX,#0002h ; 3c7e
	LD [mn_sfx_index],IX ; 3c81
	OR [BR:48h],#06h ; 3c84

	JRL loc_0x003BD8

; ---------------------- ; 3c87
loc_0x003C8A:

	LD A,[u8_14fc] ; 3c8a
	DEC A ; 3c8e
	LD [u8_14fc],A ; 3c8f

	JRL loc_0x003BD8

; ---------------------- ; 3c93
loc_0x003C96:

	; enable timer 3 control LO
	AND [BR:48h],#0FBh ; 3c96

	LD A,#00h ; 3c99
	LD [mn_current_sfx],A ; 3c9b
	LD [u8_14fc],A ; 3c9f
	LD [mn_sfx_index],A ; 3ca3
	LD [mn_sfx_index + 1],A ; 3ca7

	JRL loc_0x003BD8

; ---------------------- ; 3cab
loc_0x003CAE:

	LD [mn_current_bgm],A ; 3cae
	LD L,#02h ; 3cb2
	MLT ; 3cb4

	LD A,[mn_bgm_table_page] ; 3cb6
	LD YP,A ; 3cba
	LD IY,#minlib_bgm_table ; 3cbc
	ADD IY,HL ; 3cbf
	LD BA,[IY] ; 3cc1
	LD [mn_bgm_index],BA ; 3cc3

	LD A,#00h ; 3cc6
	LD [mn_effect],A ; 3cc8
	LD [u8_14e4],A ; 3ccc
	LD [mn_multiplier],A ; 3cd0
	LD [mn_waveform],A ; 3cd4
	LD [u8_14e7],A ; 3cd8
	LD [mn_notelen_counter],A ; 3cdc
	LD [u8_14e9],A ; 3ce0
	LD [u8_14ea],A ; 3ce4
	LD [u8_14eb],A ; 3ce8
	LD [u8_14ec],A ; 3cec
	LD [u8_14ed],A ; 3cf0
	LD [u8_14ee],A ; 3cf4
	LD [u8_14ef],A ; 3cf8
	LD [u8_14f0],A ; 3cfc
	LD [u8_14f1],A ; 3d00
	LD [u8_14f2],A ; 3d04
	LD [u8_14f3],A ; 3d08
	LD [mn_pending_bgm],A ; 3d0c
	LD [mn_loop_begin],A ; 3d10
	LD [mn_loop_begin + 1],A ; 3d14

loc_0x003D18:

	LD A,[mn_bgm_table_page] ; 3d18
	LD YP,A ; 3d1c
	LD A,[mn_notelen_counter] ; 3d1e
	CP A,#00h ; 3d22
	JRL NZ,loc_0x003EEE ; 3d24

	LD A,[mn_current_sfx] ; 3d27
	BIT A,#0FFh ; 3d2b
	JRS NZ,loc_0x003D32 ; 3d2d

	; disable Timer 3
	AND [BR:48h],#0FBh ; 3d2f

loc_0x003D32:

	LD A,[u8_14ee] ; 3d32
	AND A,#0CEh ; 3d36
	LD [u8_14ee],A ; 3d38

	LD A,#00h ; 3d3c
	LD [u8_14ed],A ; 3d3e
	LD IY,[mn_bgm_index] ; 3d42

loc_0x003D45:

	LD A,[IY] ; 3d45
	BIT A,#80h ; 3d46
	JRL NZ,loc_0x003E24 ; 3d48
	
	; increase note index 
	ADD IY,#0001h ; 3d4b
	LD [mn_bgm_index],IY ; 3d4e
	LD L,#02h ; 3d51
	MLT ; 3d53

	LD IY,#minlib_frequency_table ; 3d55
	ADD IY,HL ; 3d58
	LD BA,[IY] ; 3d5a
	CP BA,#0000h ; 3d5c
	JRL Z,loc_0x003DF3 ; 3d5f

	LD HL,BA ; 3d62
	LD A,[mn_current_sfx] ; 3d64
	BIT A,#0FFh ; 3d68
	JRS NZ,loc_0x003D70 ; 3d6a

	; set timer 3 preset LO/HI
	LD [BR:4Ah],L ; 3d6c
	LD [BR:4Bh],H ; 3d6e

loc_0x003D70:

	LD [u8_14ef],L ; 3d70
	LD [u8_14f0],H ; 3d74
	LD H,#00h ; 3d78
	LD L,[mn_waveform] ; 3d7a
	LD IY,#minlib_waveform_lookup ; 3d7e
	LD A,[mn_bgm_vol] ; 3d81
	BIT A,#80h ; 3d85
	JRL NZ,loc_0x003E1E ; 3d87

	LD A,[IY+L] ; 3d8a
	LD L,B ; 3d8c
	DIV ; 3d8d
	LD B,L ; 3d8f
	LD L,[BR:4Ah] ; 3d90
	DIV ; 3d92
	LD A,L ; 3d94

loc_0x003D95:

	LD HL,[u8_14ef] ; 3d95
	SUB HL,BA ; 3d98
	LD A,[mn_current_sfx] ; 3d9a
	BIT A,#0FFh ; 3d9e
	JRS NZ,loc_0x003DA6 ; 3da0

	LD [BR:4Ch],L ; 3da2
	LD [BR:4Dh],H ; 3da4

loc_0x003DA6:

	LD [u8_14f1],L ; 3da6
	LD [u8_14f2],H ; 3daa
	LD L,[mn_multiplier] ; 3dae
	LD B,[mn_notelen] ; 3db2
	LD IY,#minlib_mn_notelen_lookup ; 3db6
	LD A,#09h ; 3db9

	MLT ; 3dbb

	ADD IY,HL ; 3dbd
	LD L,B ; 3dbf
	LD A,[IY+L] ; 3dc0
	DEC A ; 3dc2
	LD [mn_notelen_counter],A ; 3dc3

	LD A,[mn_effect] ; 3dc7
	BIT A,#0FFh ; 3dcb
	JRS Z,loc_0x003DDC ; 3dcd

	LD A,[mn_notelen_counter] ; 3dcf
	LD B,[u8_14f3] ; 3dd3
	SUB A,B ; 3dd7
	LD [u8_14ea],A ; 3dd8

loc_0x003DDC:

	LD A,[mn_current_sfx] ; 3ddc
	BIT A,#0FFh ; 3de0
	JRS NZ,loc_0x003DF0 ; 3de2

	; mute audio?
	LD A,[BR:71h] ; 3de4
	AND A,#0FCh ; 3de6
	OR A,[mn_bgm_vol] ; 3de8
	LD [BR:71h],A ; 3deb

	; enable Timer 3
	OR [BR:48h],#06h ; 3ded

loc_0x003DF0:

	POP ALE ; 3df0

	RETE

; ---------------------- ; 3df2
loc_0x003DF3:
	LD A,[mn_current_sfx] ; 3df3
	BIT A,#0FFh ; 3df7
	JRS NZ,loc_0x003E03 ; 3df9

	LD A,[BR:71h] ; 3dfb
	AND A,#0FCh ; 3dfd
	ADD A,#00h ; 3dff
	LD [BR:71h],A ; 3e01

loc_0x003E03:

	LD L,[mn_multiplier] ; 3e03
	LD B,[mn_notelen] ; 3e07
	LD IY,#minlib_mn_notelen_lookup ; 3e0b
	LD A,#09h ; 3e0e

	MLT ; 3e10

	ADD IY,HL ; 3e12
	LD L,B ; 3e14
	LD A,[IY+L] ; 3e15
	DEC A ; 3e17
	LD [mn_notelen_counter],A ; 3e18

	JRS loc_0x003DF0

; ---------------------- ; 3e1c
loc_0x003E1E:

	LD BA,#0014h ; 3e1e
	JRL loc_0x003D95

; ---------------------- ; 3e21
loc_0x003E24:

	BIT A,#70h ; 3e24
	JRS Z,loc_0x003E45 ; 3e26

	BIT A,#30h ; 3e28
	JRS Z,loc_0x003E51 ; 3e2a

	BIT A,#20h ; 3e2c
	JRS Z,loc_0x003E5D ; 3e2e

	BIT A,#10h ; 3e30
	JRS Z,loc_0x003E93 ; 3e32

	BIT A,#40h ; 3e34
	JRL NZ,loc_0x003EB8 ; 3e36

	AND A,#0Fh ; 3e39
	LD [mn_multiplier],A ; 3e3b

	ADD IY,#0001h ; 3e3f
	JRL loc_0x003D45

; ---------------------- ; 3e42
loc_0x003E45:

	AND A,#0Fh ; 3e45
	LD [mn_notelen],A ; 3e47

	ADD IY,#0001h ; 3e4b
	JRL loc_0x003D45

; ---------------------- ; 3e4e
loc_0x003E51:

	AND A,#0Fh ; 3e51
	LD [mn_waveform],A ; 3e53

	ADD IY,#0001h ; 3e57
	JRL loc_0x003D45

; ---------------------- ; 3e5a
loc_0x003E5D:

	LD [mn_effect],A ; 3e5d

	PUSH IY ; 3e61

	; obtain index
	AND A,#0Fh ; 3e62
	LD L,#03h ; 3e64
	MLT ; 3e66

	LD IY,#VIBRATO_TABLE ; 3e68
	ADD IY,HL ; 3e6b
	LD A,[IY] ; 3e6d

	; set vibrato
	LD [u8_14f3],A ; 3e6e
	ADD IY,#0001h ; 3e72
	LD A,[IY] ; 3e75
	LD [u8_14eb],A ; 3e76

	ADD IY,#0001h ; 3e7a
	LD A,[IY] ; 3e7d
	LD [u8_14ec],A ; 3e7e

	LD A,[u8_14ee] ; 3e82
	OR A,#04h ; 3e86
	LD [u8_14ee],A ; 3e88

	POP IY ; 3e8c

	ADD IY,#0001h ; 3e8d
	JRL loc_0x003D45

; ---------------------- ; 3e90
loc_0x003E93:

	PUSH IY ; 3e93

	AND A,#0Fh ; 3e94
	LD [u8_14e4],A ; 3e96

	LD L,[u8_14e4] ; 3e9a
	LD IY,#minlib_unknown_lookup_3 ; 3e9e
	LD B,[IY+L] ; 3ea1
	LD [u8_14e9],B ; 3ea3

	LD A,[u8_14ee] ; 3ea7
	OR A,#02h ; 3eab
	LD [u8_14ee],A ; 3ead

	POP IY ; 3eb1

	ADD IY,#0001h ; 3eb2
	JRL loc_0x003D45

; ---------------------- ; 3eb5
loc_0x003EB8:

	AND A,#0Fh ; 3eb8

	; what volume level?
	CP A,#00h ; 3eba
	JRS Z,VolumeSet0 ; 3ebc

	CP A,#01h ; 3ebe
	JRS Z,VolumeSet1 ; 3ec0

	CP A,#02h ; 3ec2
	JRS Z,VolumeSet2 ; 3ec4

VolumeSet1:

	LD [mn_loop_begin],IY ; 3ec6
	LD A,[u8_14ee] ; 3ec9
	OR A,#08h ; 3ecd
	LD [u8_14ee],A ; 3ecf

	ADD IY,#0001h ; 3ed3
	JRL loc_0x003D45

; ---------------------- ; 3ed6
VolumeSet2:

	LD IY,[mn_loop_begin] ; 3ed9
	LD [mn_bgm_index],IY ; 3edc

	JRL loc_0x003D45

; ---------------------- ; 3edf

VolumeSet0:

	; mute audio
	LD A,[BR:71h] ; 3ee2
	AND A,#0FCh ; 3ee4
	LD [BR:71h],A ; 3ee6

	CARL loc_0x00400B ; 3ee8

	POP ALE ; 3eeb

	RETE

; ---------------------- ; 3eed
loc_0x003EEE:

	LD A,[u8_14ee] ; 3eee
	BIT A,#02h ; 3ef2
	JRS Z,loc_0x003F02 ; 3ef4

	LD A,[mn_notelen_counter] ; 3ef6
	LD B,[u8_14e9] ; 3efa
	CP A,B ; 3efe
	CARL Z,loc_0x003F5D ; 3eff

loc_0x003F02:

	LD A,[u8_14ee] ; 3f02
	BIT A,#04h ; 3f06
	JRS Z,loc_0x003F17 ; 3f08

	LD A,[mn_notelen_counter] ; 3f0a
	LD B,[u8_14ea] ; 3f0e
	INC B ; 3f12
	CP A,B ; 3f13
	CARL C,loc_0x003F7E ; 3f14

loc_0x003F17:

	LD A,[u8_14ee] ; 3f17
	BIT A,#30h ; 3f1b
	JRS Z,loc_0x003F4D ; 3f1d

	BIT A,#20h ; 3f1f
	JRS Z,loc_0x003F43 ; 3f21

	; playing sound mn_effect?
	LD A,[mn_current_sfx] ; 3f23
	BIT A,#0FFh ; 3f27
	JRS NZ,loc_0x003F43 ; 3f29

	LD L,[u8_14ef] ; 3f2b
	LD H,[u8_14f0] ; 3f2f
	LD A,[u8_14f1] ; 3f33
	LD B,[u8_14f2] ; 3f37

	; set timer 3 preset LO
	LD [BR:4Ah],L ; 3f3b
	; set timer 3 preset HI
	LD [BR:4Bh],H ; 3f3d
	; set timer 3 pivot LO
	LD [BR:4Ch],A ; 3f3f
	; set timer 3 pivot HI
	LD [BR:4Dh],B ; 3f41

loc_0x003F43:

	LD A,[u8_14ee] ; 3f43
	AND A,#0CFh ; 3f47
	LD [u8_14ee],A ; 3f49

loc_0x003F4D:

	LD A,[mn_notelen_counter] ; 3f4d
	CP A,#0FEh ; 3f51
	JRS Z,loc_0x003F5A ; 3f53

	DEC A ; 3f55
	LD [mn_notelen_counter],A ; 3f56

loc_0x003F5A:

	POP ALE ; 3f5a

	RETE

; ---------------------- ; 3f5c
loc_0x003F5D:

	LD A,[mn_current_sfx] ; 3f5d
	BIT A,#0FFh ; 3f61
	JRS NZ,loc_0x003F73 ; 3f63

	LD A,[BR:71h] ; 3f65
	CP A,#00h ; 3f67
	JRS Z,loc_0x003F73 ; 3f69

	LD A,[BR:71h] ; 3f6b
	AND A,#0FCh ; 3f6d
	ADD A,#01h ; 3f6f
	LD [BR:71h],A ; 3f71

loc_0x003F73:

	LD A,[u8_14ee] ; 3f73
	OR A,#10h ; 3f77
	LD [u8_14ee],A ; 3f79

	RET

; ---------------------- ; 3f7d
loc_0x003F7E:

	LD A,[u8_14ed] ; 3f7e
	INC A ; 3f82
	LD [u8_14ed],A ; 3f83

	LD L,[u8_14ef] ; 3f87
	LD H,[u8_14f0] ; 3f8b
	LD A,[u8_14f1] ; 3f8f
	LD B,[u8_14f2] ; 3f93
	LD IX,HL ; 3f97
	LD IY,BA ; 3f99
	LD L,H ; 3f9b
	LD A,[u8_14ec] ; 3f9c
	MLT ; 3fa0

	PUSH HL ; 3fa2

	LD L,B ; 3fa3
	MLT ; 3fa4
	LD BA,HL ; 3fa6

	PUSH BA ; 3fa8

	LD A,[u8_14ed] ; 3fa9
	LD B,[u8_14eb] ; 3fad
	BIT A,B ; 3fb1
	JRS NZ,loc_0x003FD9 ; 3fb2

	POP BA ; 3fb4
	POP HL ; 3fb5

	ADD IX,HL ; 3fb6
	ADD IY,BA ; 3fb8

loc_0x003FBA:

	LD BA,IX ; 3fba
	LD [u8_14ef],A ; 3fbc
	LD [u8_14f0],B ; 3fc0

	LD BA,IY ; 3fc4
	LD [u8_14f1],A ; 3fc6
	LD [u8_14f2],B ; 3fca

	LD A,[u8_14ee] ; 3fce
	OR A,#20h ; 3fd2
	LD [u8_14ee],A ; 3fd4

	RET

; ---------------------- ; 3fd8
loc_0x003FD9:

	POP BA ; 3fd9
	POP HL ; 3fda

	SUB IX,HL ; 3fdb
	SUB IY,BA ; 3fdd
	JRS loc_0x003FBA

; ---------------------- ; 3fdf
loc_0x003FE1:

	PUSH IP

	; zero out 14E0 - 150A
	LD XP,#00h
	LD IX,#14E0h
	LD L,#00h
	LD A,#00h

loc_0x003FEC:

	LD [IX+L], A

	INC L 
	CP L,#2Ah
	JRS NZ,loc_0x003FEC

	POP IP

	RET

; ---------------------- ; 3ff5
loc_0x003FF6:

	PUSH IP ; 3ff6
    
	; zero out 14E0 - 1503
	LD XP,#00h ; 3ff7
	LD IX,#14E0h ; 3ffa
	LD L,#00h ; 3ffd
	LD A,#00h ; 3fff
    
loc_0x004001:

	LD [IX+L],A ; 4001
    
	INC L ; 4003
	CP L,#23h ; 4004
	JRS NZ,loc_0x004001 ; 4007
    
	POP IP ; 4009
    
	RET
; ---------------------- ; 4003
loc_0x00400B:

	PUSH IP ; 400b

	LD XP,#00h ; 400c
	LD IX,#14E0h ; 400f
	LD L,#00h ; 4012
	LD A,#00h ; 4014

loc_0x004016:

	LD [IX+L],A ; 4016
	INC L ; 4018
	CP L,#1Ah ; 4019
	JRS NZ,loc_0x004016 ; 401c

	POP IP ; 401e

	RET

; ---------------------- ; 401f
loc_0x004020:

	LD BR,#20h ; 4020
	LD EP,#00h ; 4022
    
	LD [BR:48h],#00h ; 4025
	LD [BR:49h],#02h ; 4028
	AND [BR:70h],#0FCh ; 402b
	AND [BR:71h],#0FCh ; 402e
	OR [BR:71h],#03h ; 4031
	AND [BR:19h],#0DFh ; 4034
	OR [BR:19h],#20h ; 4037
	LD [BR:1Ch],#80h ; 403a
	LD [BR:1Dh],#00h ; 403d
	AND [BR:20h],#0C0h ; 4040
	OR [BR:20h],#02h ; 4043
	AND [BR:23h],#80h ; 4046
	OR [BR:23h],#02h ; 4049
    
	CARL loc_0x003FF6 ; 404c
    
	LD SC,#0Fh ; 404f
    
	RET
; ---------------------- ; 4051
loc_0x004052:

	LD BR,#20h ; 4052
	LD EP,#00h ; 4054
    
	LD A,#0F0h ; 4057
	LD [BR:4Bh],A ; 4059
    
	LD A,[u8_1506] ; 405b
	LD XP,A ; 405f
	LD IX,[u16_14ff] ; 4061
	LD A,[IX] ; 4064
	XOR A,#0FFh ; 4065
	LD [BR:4Dh],A ; 4067
    
	OR [BR:49h],#06h ; 4069
	ADD IX,#0001h ; 406c
	LD [u16_14f8],IX ; 406f
    
loc_0x004072:

	LD IX,[u16_14f8] ; 4072
	LD IY,[u16_14ff] ; 4075
	LD BA,[u16_1501] ; 4078
    
	ADD BA,IY ; 407b
    
	CP BA,IX ; 407d
	JRS NZ,loc_0x004072 ; 407f
    
	AND [BR:49h],#0FBh ; 4081
    
	RET
; ---------------------- ; 4083
do_irq_timer3hi_underflow:

	PUSH A ; 4085
	PUSH BR ; 4087
	PUSH IX ; 4088

	LD BR,#20h ; 4089
	LD EP,#00h ; 408b
	LD [BR:27h],#02h ; 408e

	LD A,[u8_1506] ; 4091
	LD XP,A ; 4095
	LD IX,[u16_14f8] ; 4097
	LD A,[IX] ; 409a
	XOR A,#0FFh ; 409b
	LD [BR:4Dh],A ; 409d

	ADD IX,#0001h ; 409f
	LD [u16_14f8],IX ; 40a2

	POP IX ; 40a5
	POP BR ; 40a6
	POP A ; 40a7

	RETE

; ---------------------- ; 40a9
loc_0x0040AA:

	PUSH SC ; 40aa

	LD SC,#80h ; 40ab
	OR [BR:60h],#0Ch ; 40ad
	AND [BR:61h],#0F7h ; 40b0

	CARL loc_0x004158 ; 40b3
	CARL loc_0x0041EA ; 40b6

	CARL loc_0x0041B0 ; 40b9
	JRL NC,loc_0x00414C ; 40bc

	CARL loc_0x004187 ; 40bf
	JRL NC,loc_0x00414C ; 40c2

	CARL loc_0x004158 ; 40c5
	CARL loc_0x0041F4 ; 40c8

	CARL loc_0x0041B0 ; 40cb
	JRL NC,loc_0x00414C ; 40ce

	AND [BR:60h],#0FBh ; 40d1

loc_0x0040D4:

	PUSH HL ; 40d4

	LD L,#08h ; 40d5

loc_0x0040D7:

	CARL loc_0x0041FE ; 40d7

	RL B ; 40da
	DEC L ; 40dc
	JRS NZ,loc_0x0040D7 ; 40dd

	CPL B ; 40df
	LD [IY],B ; 40e1
	INC IY ; 40e2

	POP HL ; 40e3
	DEC HL ; 40e4
	JRS Z,loc_0x0040F6 ; 40e5

	POP SC ; 40e7
	PUSH SC ; 40e8

	LD SC,#80h ; 40e9
	OR [BR:60h],#04h ; 40eb

	CARL loc_0x0041EA ; 40ee

	AND [BR:60h],#0FBh ; 40f1

	JRS loc_0x0040D4

; ---------------------- ; 40f4
loc_0x0040F6:

	OR [BR:60h],#04h ; 40f6

	CARL loc_0x0041F4 ; 40f9

	JRL loc_0x004143

; ---------------------- ; 40fc
loc_0x0040FF:

	PUSH SC ; 40ff

	LD SC,#80h ; 4100
	OR [BR:60h],#0Ch ; 4102
	AND [BR:61h],#0F7h ; 4105

	CARL loc_0x004158 ; 4108
	CARL loc_0x0041EA ; 410b

	CARL loc_0x0041B0 ; 410e
	JRL NC,loc_0x00414C ; 4111

loc_0x004114:

	POP SC ; 4114
	PUSH SC ; 4115
	LD SC,#80h ; 4116

	OR [BR:60h],#04h ; 4118
	CARL loc_0x004187 ; 411b
	JRL NC,loc_0x00414C ; 411e

loc_0x004121:

	LD A,[IY] ; 4121
	CARL loc_0x004196 ; 4122
	JRL NC,loc_0x00414C ; 4125

	INC IY ; 4128
	INC IX ; 4129
	DEC HL ; 412a

	PUSH SC ; 412b

	JRS Z,loc_0x004137 ; 412c

	LD BA,IX ; 412e
	BIT A,#1Fh ; 4130
	JRS Z,loc_0x004137 ; 4132

	POP SC ; 4134

	JRS loc_0x004121

; ---------------------- ; 4135
loc_0x004137:

	CARL loc_0x00417A ; 4137
	CARL loc_0x0041BA ; 413a

	POP SC ; 413d
	JRS NZ,loc_0x004114 ; 413e

	OR [BR:60h],#04h ; 4140

loc_0x004143:

	CARL loc_0x00417A ; 4143

	AND [BR:60h],#0F3h ; 4146

	POP SC ; 4149

	XOR A,A ; 414a

	RET

; ---------------------- ; 414b
loc_0x00414C:

	CARL loc_0x00417A ; 414c

	AND [BR:60h],#0F3h ; 414f

	LD A,#01h ; 4152
	POP SC ; 4154
	AND SC,#0FEh ; 4155

	RET

; ---------------------- ; 4157
loc_0x004158:

	OR [BR:61h],#04h ; 4158
	OR [BR:61h],#08h ; 415b
	AND [BR:61h],#0FBh ; 415e
	AND [BR:61h],#0F7h ; 4161

	CARL loc_0x0041F4 ; 4164
	CARL loc_0x0041EA ; 4167
	CARL loc_0x0041F4 ; 416a
	CARL loc_0x0041EA ; 416d
	CARL loc_0x0041EA ; 4170
	CARL loc_0x0041EA ; 4173
	CARL loc_0x0041EA ; 4176

	RET

; ---------------------- ; 4179
loc_0x00417A:

	AND [BR:61h],#0FBh ; 417a
	OR [BR:61h],#08h ; 417d
	OR [BR:61h],#04h ; 4180
	AND [BR:61h],#0F7h ; 4183

	RET

; ---------------------- ; 4186
loc_0x004187:

	LD BA,IX ; 4187
	LD A,B ; 4189
	CARL loc_0x004196 ; 418a
	JRL NC,loc_0x004195 ; 418d

	LD BA,IX ; 4190
	CARL loc_0x004196 ; 4192

loc_0x004195:

	RET

; ---------------------- ; 4195
loc_0x004196:

	LD B,#08h ; 4196

loc_0x004198:

	RLC A ; 4198
	JRS C,loc_0x0041A1 ; 419a

	AND [BR:61h],#0FBh ; 419c
	JRS loc_0x0041A4

; ---------------------- ; 419f
loc_0x0041A1:

	OR [BR:61h],#04h ; 41a1

loc_0x0041A4:

	OR [BR:61h],#08h ; 41a4
	AND [BR:61h],#0F7h ; 41a7
	DJR NZ,loc_0x004198 ; 41aa

	CARL loc_0x0041B0 ; 41ac

	RET

; ---------------------- ; 41af
loc_0x0041B0:

	AND [BR:60h],#0FBh ; 41b0

	CARL loc_0x0041FE ; 41b3

	OR [BR:60h],#04h ; 41b6

	RET

; ---------------------- ; 41b9
loc_0x0041BA:

	PUSH IX ; 41ba

	LD IX,#0000h ; 41bb

loc_0x0041BE:

	OR [BR:60h],#04h ; 41be

	CARL loc_0x004158 ; 41c1
	CARL loc_0x0041EA ; 41c4

	AND [BR:60h],#0FBh ; 41c7

	CARL loc_0x0041FE ; 41ca
	JRS C,loc_0x0041E8 ; 41cd

	INC IX ; 41cf
	CP IX,#0025h ; 41d0
	JRS NZ,loc_0x0041BE ; 41d3

	OR [BR:60h],#04h ; 41d5

	CARL loc_0x00417A ; 41d8

	ADD SP,#0006h ; 41db
	AND [BR:60h],#0F3h ; 41df

	LD A,#02h ; 41e2

	POP SC ; 41e4
	AND SC,#0FEh ; 41e5

	RET

; ---------------------- ; 41e7
loc_0x0041E8:

	POP IX ; 41e8

	RET

; ---------------------- ; 41e9
loc_0x0041EA:

	AND [BR:61h],#0FBh ; 41ea
	OR [BR:61h],#08h ; 41ed
	AND [BR:61h],#0F7h ; 41f0

	RET

; ---------------------- ; 41f3
loc_0x0041F4:

	OR [BR:61h],#04h ; 41f4
	OR [BR:61h],#08h ; 41f7
	AND [BR:61h],#0F7h ; 41fa

	RET

; ---------------------- ; 41fd
loc_0x0041FE:

	OR [BR:61h],#08h ; 41fe
	BIT [BR:61h],#04h ; 4201

	LD A,SC ; 4204
	RRC A ; 4206

	AND [BR:61h],#0F7h ; 4208

	RET

; ---------------------- ; 420b
loc_0x00420C:

	PUSH B ; 420c

	LD YP,#00h ; 420e
	LD IY,SP ; 4211
	LD HL,#0001h ; 4213
	CARL loc_0x0040AA ; 4216

	POP B ; 4219

	RET

; ---------------------- ; 421b
loc_0x00421C:

	PUSH B ; 421c

	LD YP,#00h ; 421e
	LD IY,SP ; 4221
	LD HL,#0001h ; 4223
	CARL loc_0x0040FF ; 4226

	POP B ; 4229

	RET

; ---------------------- ; 422b
loc_0x00422C:

	LD BR,#20h ; 422c
	LD EP,#00h ; 422e

	OR [BR:60h],#10h ; 4231
	AND [BR:61h],#0EFh ; 4234

	XOR A,A ; 4237

	LD [u8_150a],A ; 4238
	LD [u8_150b],A ; 423c
	LD [u8_150c],A ; 4240

	RET

; ---------------------- ; 4244
global loc_0x004245
loc_0x004245:

	LD BR,#20h ; 4245
	LD EP,#00h ; 4247
    
	LD A,[u8_150b] ; 424a
    
	RET
; ---------------------- ; 424d
loc_0x00424F:

	LD BR,#20h ; 424f
	LD EP,#00h ; 4251

	LD [u8_150b],B ; 4254

	AND A,#0Fh ; 4258
	LD L,A ; 425a
	LD H,#00h ; 425b
	LD XP,#00h ; 425d
	LD IX,#unk_lookup ; 4260
	ADD HL,IX ; 4263
	LD IX,HL ; 4265
	LD A,[IX] ; 4267
	LD [u8_150a],A ; 4268

	LD A,[u8_150b] ; 426c
	AND A,A ; 4270
	JRL NZ,loc_0x004283 ; 4271

	OR [BR:60h],#10h ; 4274
	AND [BR:61h],#0EFh ; 4277

	XOR A,A ; 427a
	LD [u8_150a],A ; 427b
	LD [u8_150b],A ; 427f

loc_0x004283:

	XOR A,A ; 4283
	LD [u8_150c],A ; 4284

	RET

; ---------------------- ; 4288
unk_lookup:
	DB 00h ; 4289
	ASCII "Y`gov~" ; 428a
	DB 85h, 8Ch, 94h, 9Bh, 0A3h, 0AAh, 0B1h, 0B9h ; 4290
	DB 0C0h
; ---------------------- ; 4298
handle32hz:

	; 20:00
	LD BR,#20h
	LD EP,#00h

	LD A,[u8_150b]
	AND A, A
	JRS Z, handle32hz_done

	DEC A
	LD [u8_150b], A
	JRL Z, loc_0x0042C4

	LD B, [u8_150a]
	LD A, [u8_150c]
	ADD A, B
	LD [u8_150c], A
	JRS NC, loc_0x0042C4

	OR [BR:60h],#10h
	OR [BR:61h],#10h

	JRS handle32hz_done

loc_0x0042C4:

	OR [BR:60h],#10h
	AND [BR:61h],#0EFh

handle32hz_done:

	RET

; ---------------------- ; 42ca
loc_0x0042CB:

	LD BR,#20h ; 42cb
	LD EP,#00h ; 42cd
	LD IX,#0000h ; 42d0
	LD YP,#00h ; 42d3
	LD IY,#eeprom_buffer ; 42d6
	LD HL,#0004h ; 42d9
	CARL loc_0x0040AA ; 42dc
	JRL NZ,loc_0x004698 ; 42df

	LD A,[eeprom_buffer] ; 42e2
	CP A,#47h ; 42e6
	JRL NZ,loc_0x0045A1 ; 42e8

	LD A,[eeprom_buffer + 1] ; 42eb
	CP A,#42h ; 42ef
	JRL NZ,loc_0x0045A1 ; 42f1

	LD A,[eeprom_buffer + 2] ; 42f4
	CP A,#4Dh ; 42f8
	JRL NZ,loc_0x0045A1 ; 42fa

	LD A,[eeprom_buffer + 3] ; 42fd
	CP A,#4Eh ; 4301
	JRL NZ,loc_0x0045A1 ; 4303

	LD IX,#0004h ; 4306

loc_0x004309:

	LD YP,#00h ; 4309
	LD IY,#eeprom_buffer ; 430c
	LD HL,#0012h ; 430f

	PUSH IX ; 4312
	CARL loc_0x0040AA ; 4313
	POP IX ; 4316

	JRL NZ,loc_0x004698 ; 4317

	CARL loc_0x004662 ; 431a
	AND A,A ; 431d
	JRL Z,loc_0x004335 ; 431e

	CARL loc_0x004689 ; 4321

	LD YP,#00h ; 4324
	LD IY,#eeprom_buffer ; 4327
	LD HL,#0012h ; 432a

	PUSH IX ; 432d
	CARL loc_0x0040FF ; 432e
	POP IX ; 4331
	JRL NZ,loc_0x004698 ; 4332

loc_0x004335:

	ADD IX,#0012h ; 4335
	CP IX,#0070h ; 4338
	JRL NZ,loc_0x004309 ; 433b

	RET

; ---------------------- ; 433e
loc_0x00433F:

	LD BR,#20h ; 433f
	LD EP,#00h ; 4341
    
	CP A,#06h ; 4344
	JRL NC,loc_0x00469B ; 4346
    
	PUSH IX ; 4349
	PUSH IP ; 434a
    
	LD L,#12h ; 434b
	MLT ; 434d
    
	ADD HL,#0004h ; 434f
	LD IX,HL ; 4352
    
	LD YP,#00h ; 4354
	LD IY,#eeprom_buffer ; 4357
    
	LD HL,#0012h ; 435a
	CARL loc_0x0040AA ; 435d
    
	POP IP ; 4360
	POP IX ; 4361
    
	JRL NZ,loc_0x004698 ; 4362
    
	PUSH IX ; 4365
	PUSH IP ; 4366
    
	CARL loc_0x004662 ; 4367
    
	AND A,A ; 436a
	JRL Z,loc_0x004371 ; 436b
    
	CARL loc_0x004689 ; 436e
    
loc_0x004371:

	POP IP ; 4371
	POP IX ; 4372
    
	LD B,#10h ; 4373
	LD HL,#eeprom_buffer ; 4375
    
loc_0x004378:

	LD A,[HL] ; 4378
	LD [IX],A ; 4379
    
	INC IX ; 437a
	INC HL ; 437b
    
	DEC B ; 437c
	LD A,B ; 437d
	AND A,A ; 437e
    
	JRL NZ,loc_0x004378 ; 437f
    
	LD A,[eeprom_buffer] ; 4382
	AND A,A ; 4386
    
	JRL Z,loc_0x0046A1 ; 4387
    
	JRL loc_0x004696
    
; ---------------------- ; 438a
loc_0x00438D:

	LD BR,#20h ; 438d
	LD EP,#00h ; 438f
    
	CP A,#06h ; 4392
	JRL NC,loc_0x00469B ; 4394
    
	LD [152Eh],A ; 4397
    
	PUSH IX ; 439b
	PUSH IP ; 439c
    
	LD L,#12h ; 439d
	MLT ; 439f
	ADD HL,#0004h ; 43a1
    
	LD A,L ; 43a4
	LD [152Fh],A ; 43a5
    
	LD A,H ; 43a9
	LD [1530h],A ; 43aa
    
	LD IX,HL ; 43ae
    
	LD YP,#00h ; 43b0
	LD IY,#eeprom_buffer ; 43b3
    
	LD HL,#0012h ; 43b6
	CARL loc_0x0040AA ; 43b9
    
	POP IP ; 43bc
	POP IX ; 43bd
    
	JRL NZ,loc_0x004698 ; 43be
    
	PUSH IX ; 43c1
	PUSH IP ; 43c2
    
	CARL loc_0x004662 ; 43c3
    
	AND A,A ; 43c6
	JRL Z,loc_0x0043CD ; 43c7
    
	CARL loc_0x004689 ; 43ca
    
loc_0x0043CD:

	POP IP ; 43cd
	POP IX ; 43ce
    
	LD A,[eeprom_buffer] ; 43cf
	AND A,A ; 43d3
	JRL Z,loc_0x0043F0 ; 43d4
    
	PUSH IX ; 43d7
    
	LD HL,#eeprom_buffer ; 43d8
    
loc_0x0043DB:

	CP [HL],[IX] ; 43db
	JRL NZ,loc_0x0043EB ; 43dd
    
	INC HL ; 43e0
	INC IX ; 43e1
    
	CP HL,#eeprom_buffer + 4 ; 43e2
	JRL NZ,loc_0x0043DB ; 43e5
    
	JRL loc_0x0043EF
    
; ---------------------- ; 43e8
loc_0x0043EB:

	POP IX ; 43eb
    
	JRL loc_0x00469E
    
; ---------------------- ; 43ec
loc_0x0043EF:

	POP IX ; 43ef
    
loc_0x0043F0:

	LD B,#10h ; 43f0
	LD HL,#eeprom_buffer ; 43f2
    
loc_0x0043F5:

	LD A,[IX] ; 43f5
	LD [HL],A ; 43f6
    
	INC IX ; 43f7
	INC HL ; 43f8
    
	DEC B ; 43f9
	LD A,B ; 43fa
	AND A,A ; 43fb
    
	JRL NZ,loc_0x0043F5 ; 43fc
    
	CARL loc_0x004673 ; 43ff
    
	LD XP,#00h ; 4402
	LD IX,#eeprom_buffer + 16 ; 4405
    
	LD A,L ; 4408
	LD [IX],A ; 4409
    
	INC IX ; 440a
    
	LD A,H ; 440b
	LD [IX],A ; 440c
    
	LD A,[152Fh] ; 440d
	LD L,A ; 4411
    
	LD A,[1530h] ; 4412
	LD H,A ; 4416
    
	LD IX,HL ; 4417
    
	LD YP,#00h ; 4419
	LD IY,#eeprom_buffer ; 441c
    
	LD HL,#0012h ; 441f
	CARL loc_0x0040FF ; 4422
    
	JRL NZ,loc_0x004698 ; 4425
    
	CARL loc_0x004689 ; 4428
    
	LD A,[152Eh] ; 442b
	LD L,#05h ; 442f
	MLT ; 4431
    
	LD H,L ; 4433
	LD L,#82h ; 4434
	LD IX,HL ; 4436
    
	ADD HL,#0500h ; 4438
	LD BA,HL ; 443b
    
loc_0x00443D:

	PUSH B ; 443d
	PUSH A ; 443f
    
	LD YP,#00h ; 4441
	LD IY,#eeprom_buffer ; 4444
    
	LD HL,#0010h ; 4447
	CARL loc_0x0040FF ; 444a
    
	POP A ; 444d
	POP B ; 444f
    
	JRL NZ,loc_0x004698 ; 4451
    
	ADD IX,#0010h ; 4454
    
	CP BA,IX ; 4457
	JRL NZ,loc_0x00443D ; 4459
    
	JRL loc_0x004696
    
; ---------------------- ; 445c
loc_0x00445F:

	LD BR,#20h ; 445f
	LD EP,#00h ; 4461
    
	CP A,#06h ; 4464
	JRL NC,loc_0x00469B ; 4466
    
	PUSH IX ; 4469
	PUSH IP ; 446a
    
	LD L,#12h ; 446b
	MLT ; 446d
	ADD HL,#0004h ; 446f
    
	LD A,L ; 4472
	LD [152Fh],A ; 4473
    
	LD A,H ; 4477
	LD [1530h],A ; 4478
    
	LD IX,HL ; 447c
    
	LD YP,#00h ; 447e
	LD IY,#eeprom_buffer ; 4481
    
	LD HL,#0012h ; 4484
	CARL loc_0x0040AA ; 4487
    
	POP IP ; 448a
	POP IX ; 448b
    
	JRL NZ,loc_0x004698 ; 448c
    
	PUSH IX ; 448f
	PUSH IP ; 4490
    
	CARL loc_0x004662 ; 4491
    
	AND A,A ; 4494
	JRL Z,loc_0x00449B ; 4495
    
	CARL loc_0x004689 ; 4498
    
loc_0x00449B:

	POP IP ; 449b
	POP IX ; 449c
    
	LD A,[eeprom_buffer] ; 449d
	AND A,A ; 44a1
	JRL Z,loc_0x0044BE ; 44a2
    
	PUSH IX ; 44a5
	LD HL,#eeprom_buffer ; 44a6
    
loc_0x0044A9:

	CP [HL],[IX] ; 44a9
	JRL NZ,loc_0x0044B9 ; 44ab
    
	INC HL ; 44ae
	INC IX ; 44af
    
	CP HL,#eeprom_buffer + 4 ; 44b0
	JRL NZ,loc_0x0044A9 ; 44b3
    
	JRL loc_0x0044BD
    
; ---------------------- ; 44b6
loc_0x0044B9:

	POP IX ; 44b9
    
	JRL loc_0x00469E
    
; ---------------------- ; 44ba
loc_0x0044BD:

	POP IX ; 44bd
    
loc_0x0044BE:

	CARL loc_0x004689 ; 44be
    
	LD A,[152Fh] ; 44c1
	LD L,A ; 44c5
    
	LD A,[1530h] ; 44c6
	LD H,A ; 44ca
    
	LD IX,HL ; 44cb
    
	LD YP,#00h ; 44cd
	LD IY,#eeprom_buffer ; 44d0
    
	LD HL,#0012h ; 44d3
	CARL loc_0x0040FF ; 44d6
    
	JRL NZ,loc_0x004698 ; 44d9
    
	JRL loc_0x004696
    
; ---------------------- ; 44dc
loc_0x0044DF:

	LD BR,#20h ; 44df
	LD EP,#00h ; 44e1
    
	CP A,#06h ; 44e4
	JRL NC,loc_0x00469B ; 44e6
    
	LD [1530h],A ; 44e9
    
	XOR A,A ; 44ed
	LD [152Fh],A ; 44ee
    
	JRL loc_0x004509
    
; ---------------------- ; 44ee
loc_0x0044F5:

	LD BR,#20h ; 44f5
	LD EP,#00h ; 44f7

	CP A,#06h ; 44fa
	JRL NC,loc_0x00469B ; 44fc

	LD [1530h],A ; 44ff

	LD A,#01h ; 4503
	LD [152Fh],A ; 4505

loc_0x004509:

	PUSH IX ; 4509
	PUSH IP ; 450a

	LD A,[1530h] ; 450b
	LD L,#12h ; 450f
	MLT ; 4511
	ADD HL,#0004h ; 4513
	LD IX,HL ; 4516
	LD YP,#00h ; 4518
	LD IY,#eeprom_buffer ; 451b
	LD HL,#0012h ; 451e
	CARL loc_0x0040AA ; 4521

	POP IP ; 4524
	POP IX ; 4525

	JRL NZ,loc_0x004698 ; 4526

	PUSH IX ; 4529
	PUSH IP ; 452a

	CARL loc_0x004662 ; 452b
	AND A,A ; 452e
	JRL Z,loc_0x004535 ; 452f

	CARL loc_0x004689 ; 4532

loc_0x004535:

	POP IP ; 4535
	POP IX ; 4536

	PUSH IX ; 4537
	LD HL,#eeprom_buffer ; 4538

loc_0x00453B:

	CP [HL],[IX] ; 453b
	JRL NZ,loc_0x00454B ; 453d

	INC HL ; 4540
	INC IX ; 4541

	CP HL,#eeprom_buffer + 4 ; 4542
	JRL NZ,loc_0x00453B ; 4545

	JRL loc_0x00454F

; ---------------------- ; 4548
loc_0x00454B:

	POP IX ; 454b

	JRL loc_0x00469E

; ---------------------- ; 454c
loc_0x00454F:

	POP IX ; 454f
	ADD IX,#0004h ; 4550

	LD A,[1530h] ; 4553
	LD B,A ; 4557
	SLA A ; 4558
	SLA A ; 455a
	ADD A,B ; 455c
	LD B,A ; 455d
	XOR A,A ; 455e
	LD HL,BA ; 455f
	ADD HL,#0082h ; 4561
	LD A,[IX] ; 4564
	INC IX ; 4565
	LD B,[IX] ; 4566
	INC IX ; 4567

	CP BA,#0501h ; 4568
	JRL NC,loc_0x00469B ; 456b

	ADD HL,BA ; 456e
	PUSH HL ; 4570

	LD A,[IX] ; 4571

	INC IX ; 4572
	LD B,[IX] ; 4573

	INC IX ; 4574
	LD IY,BA ; 4575
	LD A,[IX] ; 4577
	LD YP,A ; 4578

	INC IX ; 457a
	LD A,[IX] ; 457b

	INC IX ; 457c
	LD B,[IX] ; 457d

	CP BA,#0501h ; 457e
	JRL NC,loc_0x00469B ; 4581

	LD HL,BA ; 4584

	POP IX ; 4586

	LD A,[152Fh] ; 4587
	AND A,A ; 458b
	JRL NZ,loc_0x004598 ; 458c

	CARL loc_0x0040AA ; 458f
	JRL NZ,loc_0x004698 ; 4592

	JRL loc_0x004696

; ---------------------- ; 4595
loc_0x004598:

	CARL loc_0x0040FF ; 4598
	JRL NZ,loc_0x004698 ; 459b

	JRL loc_0x004696

; ---------------------- ; 459e
loc_0x0045A1:

	LD BR,#20h ; 45a1
	LD EP,#00h ; 45a3

	CARL loc_0x004689 ; 45a6

	LD IX,#0000h ; 45a9

loc_0x0045AC:

	LD YP,#00h ; 45ac
	LD IY,#eeprom_buffer ; 45af
	LD HL,#0010h ; 45b2

	PUSH IX ; 45b5
	CARL loc_0x0040FF ; 45b6
	POP IX ; 45b9
	JRL NZ,loc_0x004698 ; 45ba

	ADD IX,#0010h ; 45bd
	CP IX,#0090h ; 45c0
	JRL NZ,loc_0x0045AC ; 45c3

	LD YP,#00h ; 45c6
	LD IY,#eeprom_buffer ; 45c9
	LD HL,#000Ah ; 45cc
	LD IX,#1FF6h ; 45cf
	CARL loc_0x0040FF ; 45d2

	LD A,#01h ; 45d5
	LD [eeprom_buffer],A ; 45d7

	LD IX,#1FF2h ; 45db
	LD YP,#00h ; 45de
	LD IY,#eeprom_buffer ; 45e1
	LD HL,#0001h ; 45e4
	CARL loc_0x0040FF ; 45e7
	JRL NZ,loc_0x004698 ; 45ea

	LD A,#03h ; 45ed
	LD [eeprom_buffer],A ; 45ef

	LD IX,#1FF3h ; 45f3
	LD YP,#00h ; 45f6
	LD IY,#eeprom_buffer ; 45f9
	LD HL,#0001h ; 45fc
	CARL loc_0x0040FF ; 45ff
	JRL NZ,loc_0x004698 ; 4602

	LD A,#01h ; 4605
	LD [eeprom_buffer],A ; 4607

	LD IX,#1FF4h ; 460b
	LD YP,#00h ; 460e
	LD IY,#eeprom_buffer ; 4611
	LD HL,#0001h ; 4614
	CARL loc_0x0040FF ; 4617
	JRL NZ,loc_0x004698 ; 461a

	LD A,#1Fh ; 461d
	LD [eeprom_buffer],A ; 461f

	LD IX,#1FF5h ; 4623
	LD YP,#00h ; 4626
	LD IY,#eeprom_buffer ; 4629
	LD HL,#0001h ; 462c
	CARL loc_0x0040FF ; 462f
	JRL NZ,loc_0x004698 ; 4632

	LD A,#47h ; 4635
	LD [eeprom_buffer],A ; 4637

	LD A,#42h ; 463b
	LD [eeprom_buffer + 1],A ; 463d

	LD A,#4Dh ; 4641
	LD [eeprom_buffer + 2],A ; 4643

	LD A,#4Eh ; 4647
	LD [eeprom_buffer + 3],A ; 4649

	LD IX,#0000h ; 464d
	LD YP,#00h ; 4650
	LD IY,#eeprom_buffer ; 4653
	LD HL,#0004h ; 4656
	CARL loc_0x0040FF ; 4659
	JRL NZ,loc_0x004698 ; 465c

	JRL loc_0x004696

; ---------------------- ; 465f
loc_0x004662:

	CARL loc_0x004673 ; 4662

	LD A,L ; 4665
	CP A,[IY] ; 4666
	JRL NZ,loc_0x004698 ; 4667

	INC IY ; 466a
	LD A,H ; 466b
	CP A,[IY] ; 466c
	JRL NZ,loc_0x004698 ; 466d

	JRL loc_0x004696

; ---------------------- ; 4670
loc_0x004673:

	LD HL,#0000h ; 4673
	LD YP,#00h ; 4676
	LD IY,#eeprom_buffer ; 4679
	LD B,#00h ; 467c

loc_0x00467E:

	LD A,[IY] ; 467e
	ADD HL,BA ; 467f
	INC IY ; 4681
	CP IY,#eeprom_buffer + 16 ; 4682
	JRL NZ,loc_0x00467E ; 4685

	RET

; ---------------------- ; 4688
loc_0x004689:

	LD HL,#eeprom_buffer ; 4689
	XOR A,A ; 468c
	LD B,#12h ; 468d

loc_0x00468F:

	LD [HL],A ; 468f
	INC HL ; 4690
	DEC B ; 4691
	JRL NZ,loc_0x00468F ; 4692

	RET

; ---------------------- ; 4695
loc_0x004696:

	XOR A,A ; 4696

	RET

; ---------------------- ; 4697
loc_0x004698:

	LD A,#01h ; 4698

	RET

; ---------------------- ; 469a
loc_0x00469B:

	LD A,#02h ; 469b

	RET

; ---------------------- ; 469d
loc_0x00469E:

	LD A,#03h ; 469e

	RET

; ---------------------- ; 46a0
loc_0x0046A1:

	LD A,#05h ; 46a1
    
	RET
    
; ---------------------- ; 46a1
loc_0x0046A4:

	LD BR,#20h ; 46a4
	LD EP,#00h ; 46a6
	LD HL,#eeprom_buffer ; 46a9
	XOR A,A ; 46ac
	LD B,#18h ; 46ad

loc_0x0046AF:

	LD [HL],A ; 46af

	INC HL ; 46b0
	DEC B ; 46b1
	JRL NZ,loc_0x0046AF ; 46b2

	RET

; ---------------------- ; 46b5
global loc_0x0046B6
loc_0x0046B6:

	LD BR,#20h ; 46b6
	LD EP,#00h ; 46b8

	LD A,[BR:02h] ; 46bb
	AND A,#02h ; 46bd
	JRL Z,loc_0x004B0A ; 46bf

	LD IX,#1FF6h ; 46c2
	LD YP,#00h ; 46c5
	LD IY,#1525h ; 46c8
	LD HL,#000Ah ; 46cb
	farcall loc_0x0040AA ; 46d1
	JRL NZ,loc_0x004B01 ; 46d4

	CARL loc_0x004AA7 ; 46d7
	LD B,A ; 46da
	LD A,[152Eh] ; 46db
	CP A,B ; 46df
	JRL NZ,loc_0x004B0A ; 46e0

	LD A,[1528h] ; 46e3
	AND A,A ; 46e7
	JRL Z,loc_0x004B0A ; 46e8

	CARL loc_0x004770 ; 46eb

	LD IX,#1FF6h ; 46ee
	LD YP,#00h ; 46f1
	LD IY,#1525h ; 46f4
	LD HL,#000Ah ; 46f7
	farcall loc_0x0040FF ; 46fd
	JRL NZ,loc_0x004B01 ; 4700

	JRL loc_0x004AFF

; ---------------------- ; 4703
global loc_0x004706
loc_0x004706:

	LD BR,#20h ; 4706
	LD EP,#00h ; 4708

	LD A,[BR:02h] ; 470b
	AND A,#02h ; 470d
	JRL Z,loc_0x004B0A ; 470f

	LD A,XP ; 4712
	PUSH A ; 4714

	PUSH IX ; 4716
	XOR A,A ; 4717
	LD [1535h],A ; 4718

	CARL loc_0x004770 ; 471c

	LD A,[1535h] ; 471f
	AND A,A ; 4723
	JRL Z,loc_0x00473C ; 4724

	LD IX,#1FF6h ; 4727
	LD YP,#00h ; 472a
	LD IY,#1525h ; 472d
	LD HL,#000Ah ; 4730
	farcall loc_0x0040FF ; 4736
	JRL NZ,loc_0x004B0D ; 4739

loc_0x00473C:

	CARL loc_0x004996 ; 473c

	POP IX ; 473f
	POP A ; 4740

	LD XP,A ; 4742
	LD A,[1528h] ; 4744
	LD [IX],A ; 4748

	INC IX ; 4749

	LD A,[1529h] ; 474a
	LD [IX],A ; 474e

	INC IX ; 474f

	LD A,[152Ah] ; 4750
	LD [IX],A ; 4754

	INC IX ; 4755

	LD A,[152Bh] ; 4756
	LD [IX],A ; 475a

	INC IX ; 475b

	LD A,[152Ch] ; 475c
	LD [IX],A ; 4760

	INC IX ; 4761

	LD A,[152Dh] ; 4762
	LD [IX],A ; 4766

	INC IX ; 4767

	LD A,[152Fh] ; 4768
	LD [IX],A ; 476c

	JRL loc_0x004AFF

; ---------------------- ; 476d
loc_0x004770:

	LD XP,#00h ; 4770
	LD IX,#152Fh ; 4773
	CARL loc_0x004AB4 ; 4776

	LD A,[152Fh] ; 4779
	LD [1532h],A ; 477d

	LD A,[1530h] ; 4781
	LD [1533h],A ; 4785

	LD A,[1531h] ; 4789
	LD [1534h],A ; 478d

	LD B,[1525h] ; 4791
	LD A,[1532h] ; 4795
	SUB A,B ; 4799
	LD [1532h],A ; 479a

	LD B,[1526h] ; 479e
	LD A,[1533h] ; 47a2
	SBC A,B ; 47a6
	LD [1533h],A ; 47a7

	LD B,[1527h] ; 47ab
	LD A,[1534h] ; 47af
	SBC A,B ; 47b3
	LD [1534h],A ; 47b4

loc_0x0047B8:

	LD B,#01h ; 47b8
	LD A,[1534h] ; 47ba
	CP A,B ; 47be
	JRL Z,loc_0x0047C7 ; 47bf

	JRL C,loc_0x004813 ; 47c2

	JRS loc_0x0047E0

; ---------------------- ; 47c5
loc_0x0047C7:

	LD B,#51h ; 47c7
	LD A,[1533h] ; 47c9
	CP A,B ; 47cd
	JRL Z,loc_0x0047D6 ; 47ce

	JRL C,loc_0x004813 ; 47d1

	JRS loc_0x0047E0

; ---------------------- ; 47d4
loc_0x0047D6:

	LD B,#80h ; 47d6
	LD A,[1532h] ; 47d8
	CP A,B ; 47dc
	JRL C,loc_0x004813 ; 47dd

loc_0x0047E0:
	LD A,#01h ; 47e0
	LD [1535h],A ; 47e2

	LD A,[152Ah] ; 47e6
	INC A ; 47ea
	LD [152Ah],A ; 47eb

	LD B,#80h ; 47ef
	LD A,[1532h] ; 47f1
	SUB A,B ; 47f5
	LD [1532h],A ; 47f6

	LD B,#51h ; 47fa
	LD A,[1533h] ; 47fc
	SBC A,B ; 4800
	LD [1533h],A ; 4801

	LD B,#01h ; 4805
	LD A,[1534h] ; 4807
	SBC A,B ; 480b
	LD [1534h],A ; 480c

	JRL loc_0x0047B8

; ---------------------- ; 4810
loc_0x004813:

	LD B,#00h ; 4813
	LD A,[1534h] ; 4815
	CP A,B ; 4819
	JRL Z,loc_0x004822 ; 481a

	JRL C,loc_0x004868 ; 481d

	JRS loc_0x00483B

; ---------------------- ; 4820
loc_0x004822:
	LD B,#0Eh ; 4822
	LD A,[1533h] ; 4824
	CP A,B ; 4828
	JRL Z,loc_0x004831 ; 4829

	JRL C,loc_0x004868 ; 482c

	JRS loc_0x00483B
; ---------------------- ; 482f
loc_0x004831:
	LD B,#10h ; 4831
	LD A,[1532h] ; 4833
	CP A,B ; 4837
	JRL C,loc_0x004868 ; 4838

loc_0x00483B:

	LD A,[152Bh] ; 483b
	INC A ; 483f
	LD [152Bh],A ; 4840

	LD B,#10h ; 4844
	LD A,[1532h] ; 4846
	SUB A,B ; 484a
	LD [1532h],A ; 484b

	LD B,#0Eh ; 484f
	LD A,[1533h] ; 4851
	SBC A,B ; 4855
	LD [1533h],A ; 4856

	LD B,#00h ; 485a
	LD A,[1534h] ; 485c
	SBC A,B ; 4860
	LD [1534h],A ; 4861

	JRL loc_0x004813

; ---------------------- ; 4865
loc_0x004868:

	LD B,#00h ; 4868
	LD A,[1534h] ; 486a
	CP A,B ; 486e
	JRL Z,loc_0x004877 ; 486f

	JRL C,UpdateSecondsTimer ; 4872

	JRS loc_0x004890

; ---------------------- ; 4875
loc_0x004877:
	LD B,#00h ; 4877
	LD A,[1533h] ; 4879
	CP A,B ; 487d
	JRL Z,loc_0x004886 ; 487e

	JRL C,UpdateSecondsTimer ; 4881

	JRS loc_0x004890

; ---------------------- ; 4884
loc_0x004886:
	LD B,#3Ch ; 4886
	LD A,[1532h] ; 4888
	CP A,B ; 488c
	JRL C,UpdateSecondsTimer ; 488d

loc_0x004890:

	LD A,[152Ch] ; 4890
	INC A ; 4894
	LD [152Ch],A ; 4895

	LD B,#3Ch ; 4899
	LD A,[1532h] ; 489b
	SUB A,B ; 489f
	LD [1532h],A ; 48a0

	LD B,#00h ; 48a4
	LD A,[1533h] ; 48a6
	SBC A,B ; 48aa
	LD [1533h],A ; 48ab

	LD B,#00h ; 48af
	LD A,[1534h] ; 48b1
	SBC A,B ; 48b5
	LD [1534h],A ; 48b6

	JRL loc_0x004868

; ---------------------- ; 48ba
UpdateSecondsTimer:

	LD B,[1532h] ; 48bd
	LD A,[152Dh] ; 48c1
	ADD A,B ; 48c5
	LD [152Dh],A ; 48c6

loc_0x0048CA:

	LD B,#3Ch ; 48ca
	LD A,[152Dh] ; 48cc
	CP A,B ; 48d0
	JRL C,loc_0x0048EB ; 48d1

	LD B,#3Ch ; 48d4
	LD A,[152Dh] ; 48d6
	SUB A,B ; 48da
	LD [152Dh],A ; 48db

	LD A,[152Ch] ; 48df
	INC A ; 48e3
	LD [152Ch],A ; 48e4

	JRL loc_0x0048CA

; ---------------------- ; 48e8
loc_0x0048EB:

	LD B,#3Ch ; 48eb
	LD A,[152Ch] ; 48ed
	CP A,B ; 48f1
	JRL C,loc_0x00490C ; 48f2

	LD B,#3Ch ; 48f5
	LD A,[152Ch] ; 48f7
	SUB A,B ; 48fb
	LD [152Ch],A ; 48fc

	LD A,[152Bh] ; 4900
	INC A ; 4904
	LD [152Bh],A ; 4905

	JRL loc_0x0048EB

; ---------------------- ; 4909
loc_0x00490C:

	LD B,#18h ; 490c
	LD A,[152Bh] ; 490e
	CP A,B ; 4912
	JRL C,loc_0x00492D ; 4913

	LD B,#18h ; 4916
	LD A,[152Bh] ; 4918
	SUB A,B ; 491c
	LD [152Bh],A ; 491d

	LD A,[152Ah] ; 4921
	INC A ; 4925
	LD [152Ah],A ; 4926

	JRL loc_0x0048EB

; ---------------------- ; 492a
loc_0x00492D:

	CARL loc_0x004A13 ; 492d
	LD B,A ; 4930
	LD A,[152Ah] ; 4931
	CP A,B ; 4935
	JRL Z,loc_0x004976 ; 4936

	JRL C,loc_0x004976 ; 4939

	PUSH A ; 493c

	LD A,#01h ; 493e
	LD [1535h],A ; 4940

	POP A ; 4944

	SUB A,B ; 4946
	LD [152Ah],A ; 4947

	LD A,[1529h] ; 494b
	INC A ; 494f
	LD [1529h],A ; 4950

	CP A,#0Dh ; 4954
	JRL C,loc_0x00492D ; 4956

	LD A,#01h ; 4959
	LD [1529h],A ; 495b

	LD A,[1528h] ; 495f
	INC A ; 4963
	LD [1528h],A ; 4964

	CP A,#64h ; 4968
	JRL C,loc_0x00492D ; 496a

	LD A,#63h ; 496d
	LD [1528h],A ; 496f

	JRL loc_0x00492D

; ---------------------- ; 4973
loc_0x004976:

	LD A,[152Fh] ; 4976
	LD [1525h],A ; 497a

	LD A,[1530h] ; 497e
	LD [1526h],A ; 4982

	LD A,[1531h] ; 4986
	LD [1527h],A ; 498a

	CARL loc_0x004AA7 ; 498e

	LD [152Eh],A ; 4991

	RET

; ---------------------- ; 4995
loc_0x004996:

	LD A,[1528h] ; 4996
	ADD A,#64h ; 499a
	LD B,A ; 499c
	SRL A ; 499d
	SRL A ; 499f
	ADD A,B ; 49a1
	LD [152Fh],A ; 49a2

	LD A,[1528h] ; 49a6
	AND A,#03h ; 49aa
	JRL NZ,loc_0x0049C1 ; 49ac

	LD A,[1529h] ; 49af
	CP A,#03h ; 49b3
	JRL NC,loc_0x0049C1 ; 49b5

	LD A,[152Fh] ; 49b8
	DEC A ; 49bc
	LD [152Fh],A ; 49bd

loc_0x0049C1:

	LD B,#00h ; 49c1
	LD A,[1529h] ; 49c3
	LD XP,#00h ; 49c7
	LD IX,#unk_lookup_2 ; 49ca
	ADD IX,BA ; 49cd
	LD A,[IX] ; 49cf
	LD [1530h],A ; 49d0

	LD B,[1530h] ; 49d4
	LD A,[152Fh] ; 49d8
	ADD A,B ; 49dc
	LD [152Fh],A ; 49dd

	LD B,[152Ah] ; 49e1
	LD A,[152Fh] ; 49e5
	ADD A,B ; 49e9
	LD [152Fh],A ; 49ea

loc_0x0049EE:

	LD A,[152Fh] ; 49ee
	CP A,#07h ; 49f2
	JRL C,loc_0x004A05 ; 49f4

	LD B,#07h ; 49f7
	LD A,[152Fh] ; 49f9
	SUB A,B ; 49fd
	LD [152Fh],A ; 49fe

	JRL loc_0x0049EE

; ---------------------- ; 4a02
loc_0x004A05:

	RET

; ---------------------- ; 4a05
unk_lookup_2:
	DB 00h, 00h, 03h, 03h, 06h, 01h, 04h, 06h ; 4a06
	DB 02h, 05h, 00h, 03h, 05h
; ---------------------- ; 4a0e
loc_0x004A13:

	LD A,[1529h] ; 4a13
	CP A,#02h ; 4a17
	JRL Z,loc_0x004A45 ; 4a19

	CP A,#01h ; 4a1c
	JRL Z,loc_0x004A42 ; 4a1e

	CP A,#03h ; 4a21
	JRL Z,loc_0x004A42 ; 4a23

	CP A,#05h ; 4a26
	JRL Z,loc_0x004A42 ; 4a28

	CP A,#07h ; 4a2b
	JRL Z,loc_0x004A42 ; 4a2d

	CP A,#08h ; 4a30
	JRL Z,loc_0x004A42 ; 4a32

	CP A,#0Ah ; 4a35
	JRL Z,loc_0x004A42 ; 4a37

	CP A,#0Ch ; 4a3a
	JRL Z,loc_0x004A42 ; 4a3c

	LD A,#1Eh ; 4a3f

	RET
; ---------------------- ; 4a41
loc_0x004A42:

	LD A,#1Fh ; 4a42

	RET

; ---------------------- ; 4a44
loc_0x004A45:

	LD A,[1528h] ; 4a45
	AND A,#03h ; 4a49
	JRL NZ,loc_0x004A51 ; 4a4b

	LD A,#1Dh ; 4a4e

	RET

; ---------------------- ; 4a50
loc_0x004A51:

	LD A,#1Ch ; 4a51

	RET

; ---------------------- ; 4a53
global loc_0x004A54
loc_0x004A54:

	LD BR,#20h ; 4a54
	LD EP,#00h ; 4a56
    
	LD A,[IX] ; 4a59
	LD [1528h],A ; 4a5a
    
	INC IX ; 4a5e
    
	LD A,[IX] ; 4a5f
	LD [1529h],A ; 4a60
    
	INC IX ; 4a64
    
	LD A,[IX] ; 4a65
	LD [152Ah],A ; 4a66
    
	INC IX ; 4a6a
    
	LD A,[IX] ; 4a6b
	LD [152Bh],A ; 4a6c
    
	INC IX ; 4a70
    
	LD A,[IX] ; 4a71
	LD [152Ch],A ; 4a72
    
	INC IX ; 4a76
    
	LD A,[IX] ; 4a77
	LD [152Dh],A ; 4a78
    
	LD XP,#00h ; 4a7c
	LD IX,#1525h ; 4a7f
	CARL loc_0x004AB4 ; 4a82
    
	CARL loc_0x004AA7 ; 4a85
    
	LD [152Eh],A ; 4a88
    
	LD IX,#1FF6h ; 4a8c
    
	LD YP,#00h ; 4a8f
	LD IY,#1525h ; 4a92
    
	LD HL,#000Ah ; 4a95
    
	farcall loc_0x0040FF ; 4a9b
    
	JRL NZ,loc_0x004B01 ; 4a9e
    
	OR [BR:SYS_CTRL3],#RTC_VALID ; 4aa1
    
	JRL loc_0x004AFF
    
; ---------------------- ; 4aa4

loc_0x004AA7:
	LD HL,#1525h ; 4aa7
	LD B,#09h ; 4aaa
	XOR A,A ; 4aac

loc_0x004AAD:

	ADD A,[HL] ; 4aad
	INC HL ; 4aae
	DEC B ; 4aaf
	JRL NZ,loc_0x004AAD ; 4ab0

	RET

; ---------------------- ; 4ab3
loc_0x004AB4:
	LD BR,#20h ; 4ab4
	LD EP,#00h ; 4ab6

	PUSH IX ; 4ab9

	INC IX ; 4aba
	INC IX ; 4abb

	LD A,[BR:SEC_CNT_HI] ; 4abc
	LD [IX],A ; 4abe

	DEC IX ; 4abf

	LD A,[BR:SEC_CNT_MID] ; 4ac0
	LD [IX],A ; 4ac2

	DEC IX ; 4ac3

	LD A,[BR:SEC_CNT_LO] ; 4ac4
	LD [IX],A ; 4ac6

	INC IX ; 4ac7
	INC IX ; 4ac8

	LD B,[BR:SEC_CNT_HI] ; 4ac9
	LD A,[IX] ; 4acb
	CP A,B ; 4acc
	JRL NZ,loc_0x004AFB ; 4acd

	DEC IX ; 4ad0
	LD B,[BR:SEC_CNT_MID] ; 4ad1
	LD A,[IX] ; 4ad3
	CP A,B ; 4ad4
	JRL NZ,loc_0x004AFB ; 4ad5

	DEC IX ; 4ad8

	LD B,[BR:SEC_CNT_LO] ; 4ad9
	LD A,[IX] ; 4adb
	CP A,B ; 4adc
	JRL NZ,loc_0x004AFB ; 4add

	INC IX ; 4ae0
	INC IX ; 4ae1

	LD B,[BR:SEC_CNT_HI] ; 4ae2
	LD A,[IX] ; 4ae4
	CP A,B ; 4ae5
	JRL NZ,loc_0x004AFB ; 4ae6

	DEC IX ; 4ae9

	LD B,[BR:SEC_CNT_MID] ; 4aea
	LD A,[IX] ; 4aec
	CP A,B ; 4aed
	JRL NZ,loc_0x004AFB ; 4aee

	DEC IX ; 4af1

	LD B,[BR:SEC_CNT_LO] ; 4af2
	LD A,[IX] ; 4af4
	CP A,B ; 4af5
	JRL NZ,loc_0x004AFB ; 4af6

	POP IX ; 4af9

	RET

; ---------------------- ; 4afa
loc_0x004AFB:

	POP IX ; 4afb

	JRL loc_0x004AB4

; ---------------------- ; 4afc
loc_0x004AFF:

	XOR A,A ; 4aff

	RET

; ---------------------- ; 4b00
loc_0x004B01:

	LD A,#01h ; 4b01

	RET

; ---------------------- ; 4b03
loc_0x004B04:

	LD A,#02h ; 4b04
    
	RET
    
; ---------------------- ; 4b06
loc_0x004B07:

	LD A,#03h ; 4b07
    
	RET
    
; ---------------------- ; 4b04
loc_0x004B0A:

	LD A,#04h ; 4b0a

	RET

; ---------------------- ; 4b0c
loc_0x004B0D:

	POP IX ; 4b0d
	POP A ; 4b0e

	LD A,#01h ; 4b10

	RET
; ---------------------- ; 4b12
global loc_0x004B13
loc_0x004B13:

	LD BR,#20h ; 4b13
	LD EP,#00h ; 4b15

	LD HL,#1525h ; 4b18
	XOR A,A ; 4b1b
	LD B,#14h ; 4b1c

loc_0x004B1E:

	LD [HL],A ; 4b1e
	INC HL ; 4b1f
	DEC B ; 4b20
	JRL NZ,loc_0x004B1E ; 4b21

	RET

; ---------------------- ; 4b24
loc_0x004B25:
	LD BR,#20h ; 4b25
	LD EP,#00h ; 4b27
	LD [BR:IO_DIR],#(IR_DIS | RUMBLE | IR_TX)
	LD [BR:IO_DATA],#00h
	LD [BR:62h],#00h ; 4b30
	LD B,#0C8h ; 4b33
loc_0x004B35:
	NOP ; 4b35
	NOP ; 4b36
	NOP ; 4b37
	DEC B ; 4b38
	JRS NZ,loc_0x004B35 ; 4b39
	RET
; ---------------------- ; 4b3b
loc_0x004B3C:
	LD BR,#20h ; 4b3c
	LD EP,#00h ; 4b3e
	LD [u8_150a],A ; 4b41
	LD [u8_150b],B ; 4b45
	LD A,XP ; 4b49
	LD [u8_150c],A ; 4b4b
	LD [eeprom_buffer],IX ; 4b4f
	LD [eeprom_buffer + 4],H ; 4b52
	LD YP,#00h ; 4b56
	LD IY,#0000h ; 4b59
	LD HL,#0000h ; 4b5c
	LD A,#00h ; 4b5f
	CP B,#00h ; 4b61
	JRL Z,loc_0x004B73 ; 4b64
	EX A,B ; 4b67
	LD IY,BA ; 4b68
	LD HL,BA ; 4b6a
loc_0x004B6C:
	LD A,[IX] ; 4b6c
	ADD HL,BA ; 4b6d
	INC IX ; 4b6f
	DEC IY ; 4b70
	JRS NZ,loc_0x004B6C ; 4b71
loc_0x004B73:
	LD A,[u8_150a] ; 4b73
	ADD HL,BA ; 4b77
	LD [eeprom_buffer + 2],L ; 4b79
	LD [eeprom_buffer + 3],H ; 4b7d
	LD A,[eeprom_buffer + 4] ; 4b81
	CP A,#01h ; 4b85
	JRS Z,loc_0x004BA1 ; 4b87
	LD [BR:IRQ_ACT4],#IRQ4_IR_RECV ; 4b89
	LD IY,#0300h ; 4b8c
loc_0x004B8F:
	NOP ; 4b8f
	DEC IY ; 4b90
	JRL Z,loc_0x004B99 ; 4b91
	BIT [BR:IRQ_ACT4],#IRQ4_IR_RECV ; 4b94
	JRS Z,loc_0x004B8F ; 4b97
loc_0x004B99:
	LD A,#50h ; 4b99
loc_0x004B9B:
	NOP ; 4b9b
	NOP ; 4b9c
	NOP ; 4b9d
	DEC A ; 4b9e
	JRS NZ,loc_0x004B9B ; 4b9f
loc_0x004BA1:
	LD IY,#REG_BASE + IO_DATA ; 4ba1
	LD IX,[eeprom_buffer] ; 4ba4
	LD A,[u8_150b] ; 4ba7
	CP A,#00h ; 4bab
	JRS NZ,loc_0x004BB5 ; 4bad
	LD XP,#00h ; 4baf
	LD IX,#eeprom_buffer + 2 ; 4bb2
loc_0x004BB5:
	LD L,#12h ; 4bb5
loc_0x004BB7:
	CARL loc_0x004E10 ; 4bb7
	DEC L ; 4bba
	JRS Z,loc_0x004BE1 ; 4bbb
	NOP ; 4bbd
	NOP ; 4bbe
	NOP ; 4bbf
	NOP ; 4bc0
	NOP ; 4bc1
	NOP ; 4bc2
	NOP ; 4bc3
	NOP ; 4bc4
	NOP ; 4bc5
	NOP ; 4bc6
	NOP ; 4bc7
	NOP ; 4bc8
	NOP ; 4bc9
	NOP ; 4bca
	NOP ; 4bcb
	NOP ; 4bcc
	NOP ; 4bcd
	NOP ; 4bce
	NOP ; 4bcf
	NOP ; 4bd0
	NOP ; 4bd1
	NOP ; 4bd2
	NOP ; 4bd3
	NOP ; 4bd4
	NOP ; 4bd5
	NOP ; 4bd6
	NOP ; 4bd7
	NOP ; 4bd8
	NOP ; 4bd9
	NOP ; 4bda
	NOP ; 4bdb
	NOP ; 4bdc
	NOP ; 4bdd
	NOP ; 4bde
	JRS loc_0x004BB7
; ---------------------- ; 4bdf
loc_0x004BE1:
	NOP ; 4be1
	NOP ; 4be2
	NOP ; 4be3
	NOP ; 4be4
	NOP ; 4be5
	NOP ; 4be6
	NOP ; 4be7
	NOP ; 4be8
	NOP ; 4be9
	NOP ; 4bea
	NOP ; 4beb
	NOP ; 4bec
	NOP ; 4bed
	NOP ; 4bee
	NOP ; 4bef
	NOP ; 4bf0
	NOP ; 4bf1
	NOP ; 4bf2
	NOP ; 4bf3
	NOP ; 4bf4
	NOP ; 4bf5
	NOP ; 4bf6
	NOP ; 4bf7
	NOP ; 4bf8
	NOP ; 4bf9
	NOP ; 4bfa
	NOP ; 4bfb
	NOP ; 4bfc
	NOP ; 4bfd
	NOP ; 4bfe
	NOP ; 4bff
	NOP ; 4c00
	NOP ; 4c01
	NOP ; 4c02
	NOP ; 4c03
	CARL loc_0x004E3E ; 4c04
	NOP ; 4c07
	NOP ; 4c08
	NOP ; 4c09
	NOP ; 4c0a
	NOP ; 4c0b
	NOP ; 4c0c
	NOP ; 4c0d
	NOP ; 4c0e
	NOP ; 4c0f
	NOP ; 4c10
	NOP ; 4c11
	NOP ; 4c12
	NOP ; 4c13
	NOP ; 4c14
	NOP ; 4c15
	NOP ; 4c16
	NOP ; 4c17
	NOP ; 4c18
	NOP ; 4c19
	NOP ; 4c1a
	NOP ; 4c1b
	NOP ; 4c1c
	NOP ; 4c1d
	NOP ; 4c1e
	NOP ; 4c1f
	NOP ; 4c20
	NOP ; 4c21
	NOP ; 4c22
	NOP ; 4c23
	NOP ; 4c24
	LD A,#00h ; 4c25
	CARL loc_0x004D63 ; 4c27
	NOP ; 4c2a
	NOP ; 4c2b
	NOP ; 4c2c
	NOP ; 4c2d
	NOP ; 4c2e
	NOP ; 4c2f
	NOP ; 4c30
	NOP ; 4c31
	NOP ; 4c32
	NOP ; 4c33
	NOP ; 4c34
	NOP ; 4c35
	NOP ; 4c36
	NOP ; 4c37
	NOP ; 4c38
	NOP ; 4c39
	NOP ; 4c3a
	NOP ; 4c3b
	NOP ; 4c3c
	NOP ; 4c3d
	NOP ; 4c3e
	NOP ; 4c3f
	NOP ; 4c40
	NOP ; 4c41
	NOP ; 4c42
	LD A,A ; 4c43
	LD A,[u8_150a] ; 4c44
	CARL loc_0x004D63 ; 4c48
	NOP ; 4c4b
	NOP ; 4c4c
	NOP ; 4c4d
	NOP ; 4c4e
	NOP ; 4c4f
	NOP ; 4c50
	NOP ; 4c51
	NOP ; 4c52
	NOP ; 4c53
	NOP ; 4c54
	NOP ; 4c55
	NOP ; 4c56
	NOP ; 4c57
	NOP ; 4c58
	NOP ; 4c59
	NOP ; 4c5a
	NOP ; 4c5b
	NOP ; 4c5c
	NOP ; 4c5d
	NOP ; 4c5e
	NOP ; 4c5f
	NOP ; 4c60
	NOP ; 4c61
	NOP ; 4c62
	NOP ; 4c63
	LD A,A ; 4c64
	LD A,[u8_150b] ; 4c65
	CARL loc_0x004D63 ; 4c69
	NOP ; 4c6c
	NOP ; 4c6d
	NOP ; 4c6e
	NOP ; 4c6f
	NOP ; 4c70
	NOP ; 4c71
	NOP ; 4c72
	NOP ; 4c73
	NOP ; 4c74
	NOP ; 4c75
	NOP ; 4c76
	NOP ; 4c77
	NOP ; 4c78
	NOP ; 4c79
	NOP ; 4c7a
	NOP ; 4c7b
	NOP ; 4c7c
	NOP ; 4c7d
	NOP ; 4c7e
	NOP ; 4c7f
	LD A,#00h ; 4c80
	LD B,[u8_150a] ; 4c82
	XOR A,B ; 4c86
	LD B,[u8_150b] ; 4c87
	XOR A,B ; 4c8b
	CARL loc_0x004D63 ; 4c8c
	NOP ; 4c8f
	NOP ; 4c90
	NOP ; 4c91
	NOP ; 4c92
	NOP ; 4c93
	NOP ; 4c94
	NOP ; 4c95
	NOP ; 4c96
	NOP ; 4c97
	NOP ; 4c98
	LD IY,#0003h ; 4c99
	LD H,[u8_150b] ; 4c9c
loc_0x004CA0:
	CP H,#00h ; 4ca0
	JRS Z,loc_0x004CE1 ; 4ca3
	NOP ; 4ca5
	NOP ; 4ca6
	NOP ; 4ca7
	NOP ; 4ca8
	NOP ; 4ca9
	NOP ; 4caa
	NOP ; 4cab
	NOP ; 4cac
	NOP ; 4cad
	NOP ; 4cae
	LD A,A ; 4caf
	LD A,[IX] ; 4cb0
loc_0x004CB1:
	CARL loc_0x004D63 ; 4cb1
	DEC IY ; 4cb4
	JRS Z,loc_0x004CC4 ; 4cb5
	NOP ; 4cb7
	NOP ; 4cb8
	NOP ; 4cb9
	NOP ; 4cba
	NOP ; 4cbb
	NOP ; 4cbc
	NOP ; 4cbd
	NOP ; 4cbe
	NOP ; 4cbf
	INC IX ; 4cc0
	DEC H ; 4cc1
	JRS loc_0x004CA0
; ---------------------- ; 4cc2
loc_0x004CC4:
	NOP ; 4cc4
	NOP ; 4cc5
	NOP ; 4cc6
	NOP ; 4cc7
	NOP ; 4cc8
	NOP ; 4cc9
	NOP ; 4cca
	NOP ; 4ccb
	NOP ; 4ccc
	NOP ; 4ccd
	NOP ; 4cce
	NOP ; 4ccf
	NOP ; 4cd0
	NOP ; 4cd1
	LD A,A ; 4cd2
	LD IY,#0004h ; 4cd3
	DEC IX ; 4cd6
	DEC IX ; 4cd7
	LD A,[IX] ; 4cd8
	INC IX ; 4cd9
	LD B,[IX] ; 4cda
	XOR A,B ; 4cdb
	INC IX ; 4cdc
	LD B,[IX] ; 4cdd
	XOR A,B ; 4cde
	JRS loc_0x004CB1
; ---------------------- ; 4cdf
loc_0x004CE1:
	CP IY,#0001h ; 4ce1
	JRS Z,loc_0x004CF3 ; 4ce4
	CP IY,#0003h ; 4ce6
	JRS Z,loc_0x004D15 ; 4ce9
	DEC IX ; 4ceb
	LD A,[IX] ; 4cec
	NOP ; 4ced
	NOP ; 4cee
	NOP ; 4cef
	LD A,A ; 4cf0
	JRS loc_0x004CFC
; ---------------------- ; 4cf1
loc_0x004CF3:
	DEC IX ; 4cf3
	DEC IX ; 4cf4
	LD A,[IX] ; 4cf5
	INC IX ; 4cf6
	LD B,[IX] ; 4cf7
	XOR A,B ; 4cf8
	NOP ; 4cf9
	NOP ; 4cfa
	NOP ; 4cfb
loc_0x004CFC:
	CARL loc_0x004D63 ; 4cfc
	NOP ; 4cff
	NOP ; 4d00
	NOP ; 4d01
	NOP ; 4d02
	NOP ; 4d03
	NOP ; 4d04
	NOP ; 4d05
	NOP ; 4d06
	NOP ; 4d07
	NOP ; 4d08
	NOP ; 4d09
	NOP ; 4d0a
	NOP ; 4d0b
	NOP ; 4d0c
	NOP ; 4d0d
	NOP ; 4d0e
	NOP ; 4d0f
	NOP ; 4d10
	NOP ; 4d11
	NOP ; 4d12
	NOP ; 4d13
	NOP ; 4d14
loc_0x004D15:
	NOP ; 4d15
	NOP ; 4d16
	NOP ; 4d17
	LD XP,#00h ; 4d18
	LD IX,#eeprom_buffer + 2 ; 4d1b
	LD A,[IX] ; 4d1e
	CARL loc_0x004D63 ; 4d1f
	NOP ; 4d22
	NOP ; 4d23
	NOP ; 4d24
	NOP ; 4d25
	NOP ; 4d26
	NOP ; 4d27
	NOP ; 4d28
	NOP ; 4d29
	NOP ; 4d2a
	NOP ; 4d2b
	NOP ; 4d2c
	NOP ; 4d2d
	NOP ; 4d2e
	NOP ; 4d2f
	NOP ; 4d30
	NOP ; 4d31
	NOP ; 4d32
	NOP ; 4d33
	NOP ; 4d34
	NOP ; 4d35
	NOP ; 4d36
	NOP ; 4d37
	NOP ; 4d38
	NOP ; 4d39
	NOP ; 4d3a
	LD A,A ; 4d3b
	LD IX,#eeprom_buffer + 3 ; 4d3c
	LD A,[IX] ; 4d3f
	CARL loc_0x004D63 ; 4d40
	NOP ; 4d43
	NOP ; 4d44
	NOP ; 4d45
	NOP ; 4d46
	NOP ; 4d47
	NOP ; 4d48
	NOP ; 4d49
	NOP ; 4d4a
	NOP ; 4d4b
	NOP ; 4d4c
	NOP ; 4d4d
	NOP ; 4d4e
	NOP ; 4d4f
	NOP ; 4d50
	NOP ; 4d51
	NOP ; 4d52
	NOP ; 4d53
	NOP ; 4d54
	NOP ; 4d55
	NOP ; 4d56
	NOP ; 4d57
	NOP ; 4d58
	NOP ; 4d59
	DEC IX ; 4d5a
	LD A,[IX] ; 4d5b
	INC IX ; 4d5c
	LD B,[IX] ; 4d5d
	XOR A,B ; 4d5e
	CARL loc_0x004D63 ; 4d5f
	RET
; ---------------------- ; 4d62
loc_0x004D63:
	NOP ; 4d63
	NOP ; 4d64
	NOP ; 4d65
	CARL loc_0x004E10 ; 4d66
	NOP ; 4d69
	NOP ; 4d6a
	NOP ; 4d6b
	NOP ; 4d6c
	NOP ; 4d6d
	NOP ; 4d6e
	NOP ; 4d6f
	NOP ; 4d70
	NOP ; 4d71
	NOP ; 4d72
	NOP ; 4d73
	NOP ; 4d74
	NOP ; 4d75
	NOP ; 4d76
	NOP ; 4d77
	NOP ; 4d78
	NOP ; 4d79
	NOP ; 4d7a
	NOP ; 4d7b
	NOP ; 4d7c
	NOP ; 4d7d
	NOP ; 4d7e
	NOP ; 4d7f
	NOP ; 4d80
	NOP ; 4d81
	NOP ; 4d82
	NOP ; 4d83
	NOP ; 4d84
	NOP ; 4d85
	NOP ; 4d86
	NOP ; 4d87
	NOP ; 4d88
	NOP ; 4d89
	LD A,A ; 4d8a
	LD B,#08h ; 4d8b
loc_0x004D8D:
	SLA A ; 4d8d
	JRS C,loc_0x004D96 ; 4d8f
	CARL loc_0x004E3E ; 4d91
	JRS loc_0x004D9A
; ---------------------- ; 4d94
loc_0x004D96:
	CARL loc_0x004E10 ; 4d96
	INC L ; 4d99
loc_0x004D9A:
	DEC B ; 4d9a
	JRS Z,loc_0x004DBE ; 4d9b
	NOP ; 4d9d
	NOP ; 4d9e
	NOP ; 4d9f
	NOP ; 4da0
	NOP ; 4da1
	NOP ; 4da2
	NOP ; 4da3
	NOP ; 4da4
	NOP ; 4da5
	NOP ; 4da6
	NOP ; 4da7
	NOP ; 4da8
	NOP ; 4da9
	NOP ; 4daa
	NOP ; 4dab
	NOP ; 4dac
	NOP ; 4dad
	NOP ; 4dae
	NOP ; 4daf
	NOP ; 4db0
	NOP ; 4db1
	NOP ; 4db2
	NOP ; 4db3
	NOP ; 4db4
	NOP ; 4db5
	NOP ; 4db6
	NOP ; 4db7
	NOP ; 4db8
	NOP ; 4db9
	NOP ; 4dba
	LD A,A ; 4dbb
	JRS loc_0x004D8D
; ---------------------- ; 4dbc
loc_0x004DBE:
	AND L,#01h ; 4dbe
	JRS NZ,loc_0x004DE9 ; 4dc1
	LD L,#00h ; 4dc3
	NOP ; 4dc5
	NOP ; 4dc6
	NOP ; 4dc7
	NOP ; 4dc8
	NOP ; 4dc9
	NOP ; 4dca
	NOP ; 4dcb
	NOP ; 4dcc
	NOP ; 4dcd
	NOP ; 4dce
	NOP ; 4dcf
	NOP ; 4dd0
	NOP ; 4dd1
	NOP ; 4dd2
	NOP ; 4dd3
	NOP ; 4dd4
	NOP ; 4dd5
	NOP ; 4dd6
	NOP ; 4dd7
	NOP ; 4dd8
	NOP ; 4dd9
	NOP ; 4dda
	NOP ; 4ddb
	NOP ; 4ddc
	NOP ; 4ddd
	NOP ; 4dde
	NOP ; 4ddf
	NOP ; 4de0
	NOP ; 4de1
	NOP ; 4de2
	LD A,A ; 4de3
	CARL loc_0x004E3E ; 4de4
	JRS loc_0x004E0F
; ---------------------- ; 4de7
loc_0x004DE9:
	LD L,#00h ; 4de9
	NOP ; 4deb
	NOP ; 4dec
	NOP ; 4ded
	NOP ; 4dee
	NOP ; 4def
	NOP ; 4df0
	NOP ; 4df1
	NOP ; 4df2
	NOP ; 4df3
	NOP ; 4df4
	NOP ; 4df5
	NOP ; 4df6
	NOP ; 4df7
	NOP ; 4df8
	NOP ; 4df9
	NOP ; 4dfa
	NOP ; 4dfb
	NOP ; 4dfc
	NOP ; 4dfd
	NOP ; 4dfe
	NOP ; 4dff
	NOP ; 4e00
	NOP ; 4e01
	NOP ; 4e02
	NOP ; 4e03
	NOP ; 4e04
	NOP ; 4e05
	NOP ; 4e06
	NOP ; 4e07
	NOP ; 4e08
	LD A,A ; 4e09
	CARL loc_0x004E10 ; 4e0a
	JRS loc_0x004E0F
; ---------------------- ; 4e0d
loc_0x004E0F:
	RET
; ---------------------- ; 4e0f
loc_0x004E10:
	PUSH IY ; 4e10
	PUSH B ; 4e11
	LD IY,#REG_BASE + IO_DATA ; 4e13
	LD B,#04h ; 4e16
	INT [98h] ; 4e18
	POP B ; 4e1a
	POP IY ; 4e1c
	NOP ; 4e1d
	NOP ; 4e1e
	NOP ; 4e1f
	NOP ; 4e20
	NOP ; 4e21
	NOP ; 4e22
	NOP ; 4e23
	NOP ; 4e24
	NOP ; 4e25
	NOP ; 4e26
	NOP ; 4e27
	NOP ; 4e28
	NOP ; 4e29
	NOP ; 4e2a
	NOP ; 4e2b
	NOP ; 4e2c
	NOP ; 4e2d
	NOP ; 4e2e
	NOP ; 4e2f
	NOP ; 4e30
	NOP ; 4e31
	NOP ; 4e32
	NOP ; 4e33
	NOP ; 4e34
	NOP ; 4e35
	NOP ; 4e36
	NOP ; 4e37
	NOP ; 4e38
	NOP ; 4e39
	NOP ; 4e3a
	NOP ; 4e3b
	LD A,A ; 4e3c
	RET
; ---------------------- ; 4e3d
loc_0x004E3E:
	NOP ; 4e3e
	NOP ; 4e3f
	NOP ; 4e40
	NOP ; 4e41
	NOP ; 4e42
	NOP ; 4e43
	NOP ; 4e44
	NOP ; 4e45
	NOP ; 4e46
	NOP ; 4e47
	NOP ; 4e48
	NOP ; 4e49
	NOP ; 4e4a
	NOP ; 4e4b
	NOP ; 4e4c
	NOP ; 4e4d
	NOP ; 4e4e
	NOP ; 4e4f
	NOP ; 4e50
	NOP ; 4e51
	NOP ; 4e52
	NOP ; 4e53
	NOP ; 4e54
	NOP ; 4e55
	NOP ; 4e56
	NOP ; 4e57
	NOP ; 4e58
	NOP ; 4e59
	NOP ; 4e5a
	NOP ; 4e5b
	NOP ; 4e5c
	NOP ; 4e5d
	NOP ; 4e5e
	NOP ; 4e5f
	NOP ; 4e60
	NOP ; 4e61
	NOP ; 4e62
	NOP ; 4e63
	NOP ; 4e64
	NOP ; 4e65
	NOP ; 4e66
	NOP ; 4e67
	NOP ; 4e68
	NOP ; 4e69
	NOP ; 4e6a
	NOP ; 4e6b
	NOP ; 4e6c
	NOP ; 4e6d
	NOP ; 4e6e
	NOP ; 4e6f
	NOP ; 4e70
	NOP ; 4e71
	NOP ; 4e72
	NOP ; 4e73
	NOP ; 4e74
	NOP ; 4e75
	NOP ; 4e76
	NOP ; 4e77
	RET
; ---------------------- ; 4e78
loc_0x004E79:
	LD BR,#20h ; 4e79
	LD EP,#00h ; 4e7b
	LD XP,#00h ; 4e7e
	LD YP,#00h ; 4e81
	CP A,#80h ; 4e84
	JRL NC,loc_0x0055FE ; 4e86
	PUSH A ; 4e89
	PUSH IX ; 4e8b
	PUSH IY ; 4e8c
	LD A,#00h ; 4e8d
	LD H,#1Ch ; 4e8f
	LD IX,#u8_150a ; 4e91
loc_0x004E94:
	LD [IX],A ; 4e94
	INC IX ; 4e95
	DEC H ; 4e96
	JRS NZ,loc_0x004E94 ; 4e97
	POP IY ; 4e99
	POP IX ; 4e9a
	POP A ; 4e9b
	LD [eeprom_buffer + 3],A ; 4e9d
	LD [eeprom_buffer + 5],IX ; 4ea1
	LD [eeprom_buffer + 16],IX ; 4ea4
	LD A,#00h ; 4ea7
	LD H,#12h ; 4ea9
	LD L,#00h ; 4eab
	LD [BR:IRQ_ACT4],#IRQ4_IR_RECV
	CP IY,#0018h ; 4eb0
	JRS C,loc_0x004EBA ; 4eb3
	SUB IY,#0017h ; 4eb5
	JRS loc_0x004EBD
; ---------------------- ; 4eb8
loc_0x004EBA:
	LD IY,#0001h ; 4eba
loc_0x004EBD:
	NOP ; 4ebd
	DEC IY ; 4ebe
	JRL Z,loc_0x005601 ; 4ebf
	BIT [BR:IRQ_ACT4],#IRQ4_IR_RECV
	JRS Z,loc_0x004EBD ; 4ec5
	LD [u8_150a],IY ; 4ec7
	NOP ; 4eca
	NOP ; 4ecb
	LD A,A ; 4ecc
	LD A,#0Dh ; 4ecd
loc_0x004ECF:
	NOP ; 4ecf
	NOP ; 4ed0
	NOP ; 4ed1
	DEC A ; 4ed2
	JRS NZ,loc_0x004ECF ; 4ed3
	LD A,A ; 4ed5
	NOP ; 4ed6
	LD IY,#0000h ; 4ed7
	LD B,#09h ; 4eda
loc_0x004EDC:
	CARL loc_0x005634 ; 4edc
	DEC H ; 4edf
	JRL Z,loc_0x004F22 ; 4ee0
	CP A,#01h ; 4ee3
	JRL NZ,loc_0x0055DB ; 4ee5
	NOP ; 4ee8
	NOP ; 4ee9
	NOP ; 4eea
	NOP ; 4eeb
	NOP ; 4eec
	NOP ; 4eed
	NOP ; 4eee
	NOP ; 4eef
	NOP ; 4ef0
	NOP ; 4ef1
	NOP ; 4ef2
	NOP ; 4ef3
	NOP ; 4ef4
	NOP ; 4ef5
	NOP ; 4ef6
	NOP ; 4ef7
	NOP ; 4ef8
	NOP ; 4ef9
	NOP ; 4efa
	NOP ; 4efb
	NOP ; 4efc
	NOP ; 4efd
	NOP ; 4efe
	NOP ; 4eff
	NOP ; 4f00
	NOP ; 4f01
	NOP ; 4f02
	NOP ; 4f03
	NOP ; 4f04
	NOP ; 4f05
	NOP ; 4f06
	NOP ; 4f07
	NOP ; 4f08
	NOP ; 4f09
	NOP ; 4f0a
	NOP ; 4f0b
	NOP ; 4f0c
	NOP ; 4f0d
	NOP ; 4f0e
	NOP ; 4f0f
	NOP ; 4f10
	NOP ; 4f11
	NOP ; 4f12
	NOP ; 4f13
	NOP ; 4f14
	NOP ; 4f15
	NOP ; 4f16
	NOP ; 4f17
	NOP ; 4f18
	NOP ; 4f19
	NOP ; 4f1a
	NOP ; 4f1b
	NOP ; 4f1c
	NOP ; 4f1d
	LD A,A ; 4f1e
	JRL loc_0x004EDC
; ---------------------- ; 4f1f
loc_0x004F22:
	CP A,#00h ; 4f22
	JRL NZ,loc_0x0055DB ; 4f24
	NOP ; 4f27
	NOP ; 4f28
	NOP ; 4f29
	NOP ; 4f2a
	NOP ; 4f2b
	NOP ; 4f2c
	NOP ; 4f2d
	NOP ; 4f2e
	NOP ; 4f2f
	NOP ; 4f30
	NOP ; 4f31
	NOP ; 4f32
	NOP ; 4f33
	NOP ; 4f34
	NOP ; 4f35
	NOP ; 4f36
	NOP ; 4f37
	NOP ; 4f38
	NOP ; 4f39
	NOP ; 4f3a
	NOP ; 4f3b
	NOP ; 4f3c
	NOP ; 4f3d
	NOP ; 4f3e
	NOP ; 4f3f
	NOP ; 4f40
	NOP ; 4f41
	NOP ; 4f42
	NOP ; 4f43
	NOP ; 4f44
	NOP ; 4f45
	NOP ; 4f46
	NOP ; 4f47
	NOP ; 4f48
	NOP ; 4f49
	NOP ; 4f4a
	NOP ; 4f4b
	NOP ; 4f4c
	NOP ; 4f4d
	NOP ; 4f4e
	NOP ; 4f4f
	NOP ; 4f50
	NOP ; 4f51
	NOP ; 4f52
	NOP ; 4f53
	NOP ; 4f54
	NOP ; 4f55
	NOP ; 4f56
	NOP ; 4f57
	NOP ; 4f58
	NOP ; 4f59
	NOP ; 4f5a
	NOP ; 4f5b
	NOP ; 4f5c
	LD A,A ; 4f5d
	LD IX,#eeprom_buffer + 9 ; 4f5e
loc_0x004F61:
	CARL loc_0x005634 ; 4f61
	CP A,#0FFh ; 4f64
	JRL Z,loc_0x0055F5 ; 4f66
	CP B,#01h ; 4f69
	JRL Z,loc_0x00501C ; 4f6c
	CP B,#0Ah ; 4f6f
	JRL Z,loc_0x004FE3 ; 4f72
	CP A,#00h ; 4f75
	JRL Z,loc_0x004FAF ; 4f77
	LD A,[IX] ; 4f7a
	SLA A ; 4f7b
	OR A,#01h ; 4f7d
	LD [IX],A ; 4f7f
	INC L ; 4f80
	NOP ; 4f81
	NOP ; 4f82
	NOP ; 4f83
	NOP ; 4f84
	NOP ; 4f85
	NOP ; 4f86
	NOP ; 4f87
	NOP ; 4f88
	NOP ; 4f89
	NOP ; 4f8a
	NOP ; 4f8b
	NOP ; 4f8c
	NOP ; 4f8d
	NOP ; 4f8e
	NOP ; 4f8f
	NOP ; 4f90
	NOP ; 4f91
	NOP ; 4f92
	NOP ; 4f93
	NOP ; 4f94
	NOP ; 4f95
	NOP ; 4f96
	NOP ; 4f97
	NOP ; 4f98
	NOP ; 4f99
	NOP ; 4f9a
	NOP ; 4f9b
	NOP ; 4f9c
	NOP ; 4f9d
	NOP ; 4f9e
	NOP ; 4f9f
	NOP ; 4fa0
	NOP ; 4fa1
	NOP ; 4fa2
	NOP ; 4fa3
	NOP ; 4fa4
	NOP ; 4fa5
	NOP ; 4fa6
	NOP ; 4fa7
	NOP ; 4fa8
	NOP ; 4fa9
	NOP ; 4faa
	NOP ; 4fab
	JRL loc_0x004F61
; ---------------------- ; 4fac
loc_0x004FAF:
	LD A,[IX] ; 4faf
	SLA A ; 4fb0
	LD [IX],A ; 4fb2
	NOP ; 4fb3
	NOP ; 4fb4
	NOP ; 4fb5
	NOP ; 4fb6
	NOP ; 4fb7
	NOP ; 4fb8
	NOP ; 4fb9
	NOP ; 4fba
	NOP ; 4fbb
	NOP ; 4fbc
	NOP ; 4fbd
	NOP ; 4fbe
	NOP ; 4fbf
	NOP ; 4fc0
	NOP ; 4fc1
	NOP ; 4fc2
	NOP ; 4fc3
	NOP ; 4fc4
	NOP ; 4fc5
	NOP ; 4fc6
	NOP ; 4fc7
	NOP ; 4fc8
	NOP ; 4fc9
	NOP ; 4fca
	NOP ; 4fcb
	NOP ; 4fcc
	NOP ; 4fcd
	NOP ; 4fce
	NOP ; 4fcf
	NOP ; 4fd0
	NOP ; 4fd1
	NOP ; 4fd2
	NOP ; 4fd3
	NOP ; 4fd4
	NOP ; 4fd5
	NOP ; 4fd6
	NOP ; 4fd7
	NOP ; 4fd8
	NOP ; 4fd9
	NOP ; 4fda
	NOP ; 4fdb
	NOP ; 4fdc
	NOP ; 4fdd
	NOP ; 4fde
	NOP ; 4fdf
	JRL loc_0x004F61
; ---------------------- ; 4fe0
loc_0x004FE3:
	CP A,#01h ; 4fe3
	JRL NZ,loc_0x005604 ; 4fe5
	NOP ; 4fe8
	NOP ; 4fe9
	NOP ; 4fea
	NOP ; 4feb
	NOP ; 4fec
	NOP ; 4fed
	NOP ; 4fee
	NOP ; 4fef
	NOP ; 4ff0
	NOP ; 4ff1
	NOP ; 4ff2
	NOP ; 4ff3
	NOP ; 4ff4
	NOP ; 4ff5
	NOP ; 4ff6
	NOP ; 4ff7
	NOP ; 4ff8
	NOP ; 4ff9
	NOP ; 4ffa
	NOP ; 4ffb
	NOP ; 4ffc
	NOP ; 4ffd
	NOP ; 4ffe
	NOP ; 4fff
	NOP ; 5000
	NOP ; 5001
	NOP ; 5002
	NOP ; 5003
	NOP ; 5004
	NOP ; 5005
	NOP ; 5006
	NOP ; 5007
	NOP ; 5008
	NOP ; 5009
	NOP ; 500a
	NOP ; 500b
	NOP ; 500c
	NOP ; 500d
	NOP ; 500e
	NOP ; 500f
	NOP ; 5010
	NOP ; 5011
	NOP ; 5012
	NOP ; 5013
	NOP ; 5014
	NOP ; 5015
	NOP ; 5016
	NOP ; 5017
	LD A,A ; 5018
	JRL loc_0x004F61
; ---------------------- ; 5019
loc_0x00501C:
	PUSH B ; 501c
	LD B,L ; 501e
	AND B,#01h ; 501f
	CP A,B ; 5022
	JRL NZ,loc_0x00505F ; 5023
	POP B ; 5026
	LD L,#00h ; 5028
	LD A,H ; 502a
	XOR A,[IX] ; 502b
	LD H,A ; 502c
	CP IX,#eeprom_buffer + 12 ; 502d
	JRL Z,loc_0x00509F ; 5030
	INC IX ; 5033
	NOP ; 5034
	NOP ; 5035
	NOP ; 5036
	NOP ; 5037
	NOP ; 5038
	NOP ; 5039
	NOP ; 503a
	NOP ; 503b
	NOP ; 503c
	NOP ; 503d
	NOP ; 503e
	NOP ; 503f
	NOP ; 5040
	NOP ; 5041
	NOP ; 5042
	NOP ; 5043
	NOP ; 5044
	NOP ; 5045
	NOP ; 5046
	NOP ; 5047
	NOP ; 5048
	NOP ; 5049
	NOP ; 504a
	NOP ; 504b
	NOP ; 504c
	NOP ; 504d
	NOP ; 504e
	NOP ; 504f
	NOP ; 5050
	NOP ; 5051
	NOP ; 5052
	NOP ; 5053
	NOP ; 5054
	NOP ; 5055
	NOP ; 5056
	NOP ; 5057
	NOP ; 5058
	NOP ; 5059
	NOP ; 505a
	LD A,A ; 505b
	JRL loc_0x004F61
; ---------------------- ; 505c
loc_0x00505F:
	POP B ; 505f
	LD A,[eeprom_buffer + 13] ; 5061
	CP A,#00h ; 5065
	JRL NZ,loc_0x0055F8 ; 5067
	LD A,#01h ; 506a
	LD [eeprom_buffer + 13],A ; 506c
	LD IY,#eeprom_buffer + 7 ; 5070
	LD [IY],IX ; 5073
	LD L,#00h ; 5075
	CP IX,#eeprom_buffer + 12 ; 5077
	JRL Z,loc_0x0050AB ; 507a
	INC IX ; 507d
	NOP ; 507e
	NOP ; 507f
	NOP ; 5080
	NOP ; 5081
	NOP ; 5082
	NOP ; 5083
	NOP ; 5084
	NOP ; 5085
	NOP ; 5086
	NOP ; 5087
	NOP ; 5088
	NOP ; 5089
	NOP ; 508a
	NOP ; 508b
	NOP ; 508c
	NOP ; 508d
	NOP ; 508e
	NOP ; 508f
	NOP ; 5090
	NOP ; 5091
	NOP ; 5092
	NOP ; 5093
	NOP ; 5094
	NOP ; 5095
	NOP ; 5096
	NOP ; 5097
	NOP ; 5098
	NOP ; 5099
	NOP ; 509a
	LD A,A ; 509b
	JRL loc_0x004F61
; ---------------------- ; 509c
loc_0x00509F:
	LD A,[eeprom_buffer + 13] ; 509f
	LD A,A ; 50a3
	NOP ; 50a4
	NOP ; 50a5
	NOP ; 50a6
	NOP ; 50a7
	NOP ; 50a8
	NOP ; 50a9
	NOP ; 50aa
loc_0x0050AB:
	CP A,#00h ; 50ab
	JRS NZ,loc_0x0050C5 ; 50ad
	LD IY,#u8_150a ; 50af
	LD IX,#eeprom_buffer + 9 ; 50b2
	LD A,[IX] ; 50b5
	LD [IY],A ; 50b6
	INC IX ; 50b7
	INC IY ; 50b8
	LD A,[IX] ; 50b9
	LD [IY],A ; 50ba
	INC IX ; 50bb
	INC IY ; 50bc
	LD A,[IX] ; 50bd
	LD [IY],A ; 50be
	NOP ; 50bf
	NOP ; 50c0
	NOP ; 50c1
	NOP ; 50c2
	JRS loc_0x0050DB
; ---------------------- ; 50c3
loc_0x0050C5:
	LD IY,#eeprom_buffer + 7 ; 50c5
	LD IX,[IY] ; 50c8
	LD [IX],H ; 50ca
	LD IY,#u8_150a ; 50cb
	LD IX,#eeprom_buffer + 9 ; 50ce
	LD A,[IX] ; 50d1
	LD [IY],A ; 50d2
	INC IX ; 50d3
	INC IY ; 50d4
	LD A,[IX] ; 50d5
	LD [IY],A ; 50d6
	INC IX ; 50d7
	INC IY ; 50d8
	LD A,[IX] ; 50d9
	LD [IY],A ; 50da
loc_0x0050DB:
	CP A,#03h ; 50db
	JRL C,loc_0x00531B ; 50dd
	DEC A ; 50e0
	CP A,[eeprom_buffer + 3] ; 50e1
	JRL NC,loc_0x0055FE ; 50e4
	LD A,#03h ; 50e7
	LD [eeprom_buffer + 2],A ; 50e9
	NOP ; 50ed
	LD A,A ; 50ee
loc_0x0050EF:
	CARL loc_0x005634 ; 50ef
	CP A,#0FFh ; 50f2
	JRL Z,loc_0x0055F5 ; 50f4
	CP B,#01h ; 50f7
	JRL Z,loc_0x005249 ; 50fa
	CP B,#0Ah ; 50fd
	JRL Z,loc_0x005171 ; 5100
	CP A,#00h ; 5103
	JRL Z,loc_0x00513D ; 5105
	LD A,[IX] ; 5108
	SLA A ; 5109
	OR A,#01h ; 510b
	LD [IX],A ; 510d
	INC L ; 510e
	NOP ; 510f
	NOP ; 5110
	NOP ; 5111
	NOP ; 5112
	NOP ; 5113
	NOP ; 5114
	NOP ; 5115
	NOP ; 5116
	NOP ; 5117
	NOP ; 5118
	NOP ; 5119
	NOP ; 511a
	NOP ; 511b
	NOP ; 511c
	NOP ; 511d
	NOP ; 511e
	NOP ; 511f
	NOP ; 5120
	NOP ; 5121
	NOP ; 5122
	NOP ; 5123
	NOP ; 5124
	NOP ; 5125
	NOP ; 5126
	NOP ; 5127
	NOP ; 5128
	NOP ; 5129
	NOP ; 512a
	NOP ; 512b
	NOP ; 512c
	NOP ; 512d
	NOP ; 512e
	NOP ; 512f
	NOP ; 5130
	NOP ; 5131
	NOP ; 5132
	NOP ; 5133
	NOP ; 5134
	NOP ; 5135
	NOP ; 5136
	NOP ; 5137
	NOP ; 5138
	NOP ; 5139
	JRL loc_0x0050EF
; ---------------------- ; 513a
loc_0x00513D:
	LD A,[IX] ; 513d
	SLA A ; 513e
	LD [IX],A ; 5140
	NOP ; 5141
	NOP ; 5142
	NOP ; 5143
	NOP ; 5144
	NOP ; 5145
	NOP ; 5146
	NOP ; 5147
	NOP ; 5148
	NOP ; 5149
	NOP ; 514a
	NOP ; 514b
	NOP ; 514c
	NOP ; 514d
	NOP ; 514e
	NOP ; 514f
	NOP ; 5150
	NOP ; 5151
	NOP ; 5152
	NOP ; 5153
	NOP ; 5154
	NOP ; 5155
	NOP ; 5156
	NOP ; 5157
	NOP ; 5158
	NOP ; 5159
	NOP ; 515a
	NOP ; 515b
	NOP ; 515c
	NOP ; 515d
	NOP ; 515e
	NOP ; 515f
	NOP ; 5160
	NOP ; 5161
	NOP ; 5162
	NOP ; 5163
	NOP ; 5164
	NOP ; 5165
	NOP ; 5166
	NOP ; 5167
	NOP ; 5168
	NOP ; 5169
	NOP ; 516a
	NOP ; 516b
	NOP ; 516c
	NOP ; 516d
	JRL loc_0x0050EF
; ---------------------- ; 516e
loc_0x005171:
	CP A,#01h ; 5171
	JRL NZ,loc_0x005604 ; 5173
	LD A,#01h ; 5176
	AND A,[eeprom_buffer + 2] ; 5178
	JRL NZ,loc_0x0051B4 ; 517b
	LD A,#02h ; 517e
	AND A,[eeprom_buffer + 2] ; 5180
	JRL NZ,loc_0x0051EC ; 5183
	LD A,#04h ; 5186
	AND A,[eeprom_buffer + 2] ; 5188
	JRL NZ,loc_0x00521E ; 518b
	NOP ; 518e
	NOP ; 518f
	NOP ; 5190
	NOP ; 5191
	NOP ; 5192
	NOP ; 5193
	NOP ; 5194
	NOP ; 5195
	NOP ; 5196
	NOP ; 5197
	NOP ; 5198
	NOP ; 5199
	NOP ; 519a
	NOP ; 519b
	NOP ; 519c
	NOP ; 519d
	NOP ; 519e
	NOP ; 519f
	NOP ; 51a0
	NOP ; 51a1
	NOP ; 51a2
	NOP ; 51a3
	NOP ; 51a4
	NOP ; 51a5
	NOP ; 51a6
	NOP ; 51a7
	NOP ; 51a8
	NOP ; 51a9
	NOP ; 51aa
	NOP ; 51ab
	NOP ; 51ac
	NOP ; 51ad
	NOP ; 51ae
	NOP ; 51af
	NOP ; 51b0
	JRL loc_0x0050EF
; ---------------------- ; 51b1
loc_0x0051B4:
	LD HL,#0000h ; 51b4
	LD IX,#eeprom_buffer + 13 ; 51b7
	LD A,#00h ; 51ba
	LD [IX],A ; 51bc
	DEC IX ; 51bd
	LD [IX],A ; 51be
	DEC IX ; 51bf
	LD [IX],A ; 51c0
	DEC IX ; 51c1
	LD [IX],A ; 51c2
	DEC IX ; 51c3
	LD [IX],A ; 51c4
	LD A,[eeprom_buffer + 2] ; 51c5
	AND A,#0FEh ; 51c9
	LD [eeprom_buffer + 2],A ; 51cb
	NOP ; 51cf
	NOP ; 51d0
	NOP ; 51d1
	NOP ; 51d2
	NOP ; 51d3
	NOP ; 51d4
	NOP ; 51d5
	NOP ; 51d6
	NOP ; 51d7
	NOP ; 51d8
	NOP ; 51d9
	NOP ; 51da
	NOP ; 51db
	NOP ; 51dc
	NOP ; 51dd
	NOP ; 51de
	NOP ; 51df
	NOP ; 51e0
	NOP ; 51e1
	NOP ; 51e2
	NOP ; 51e3
	NOP ; 51e4
	NOP ; 51e5
	NOP ; 51e6
	NOP ; 51e7
	NOP ; 51e8
	JRL loc_0x0050EF
; ---------------------- ; 51e9
loc_0x0051EC:
	PUSH HL ; 51ec
	LD A,[u8_150c] ; 51ed
	LD H,#00h ; 51f1
	LD L,A ; 51f3
	LD A,#03h ; 51f4
	DIV ; 51f6
	LD [eeprom_buffer + 14],L ; 51f8
	LD [eeprom_buffer + 15],H ; 51fc
	POP HL ; 5200
	LD A,[eeprom_buffer + 2] ; 5201
	AND A,#0FDh ; 5205
	LD [eeprom_buffer + 2],A ; 5207
	NOP ; 520b
	NOP ; 520c
	NOP ; 520d
	NOP ; 520e
	NOP ; 520f
	NOP ; 5210
	NOP ; 5211
	NOP ; 5212
	NOP ; 5213
	NOP ; 5214
	NOP ; 5215
	NOP ; 5216
	NOP ; 5217
	NOP ; 5218
	NOP ; 5219
	LD A,A ; 521a
	JRL loc_0x0050EF
; ---------------------- ; 521b
loc_0x00521E:
	PUSH HL ; 521e
	LD IY,#eeprom_buffer + 16 ; 521f
	LD HL,[IY] ; 5222
	INC HL ; 5224
	INC HL ; 5225
	INC HL ; 5226
	LD [IY],HL ; 5227
	POP HL ; 5229
	LD A,[eeprom_buffer + 2] ; 522a
	AND A,#0FBh ; 522e
	LD [eeprom_buffer + 2],A ; 5230
	NOP ; 5234
	NOP ; 5235
	NOP ; 5236
	NOP ; 5237
	NOP ; 5238
	NOP ; 5239
	NOP ; 523a
	NOP ; 523b
	NOP ; 523c
	NOP ; 523d
	NOP ; 523e
	NOP ; 523f
	NOP ; 5240
	NOP ; 5241
	NOP ; 5242
	NOP ; 5243
	NOP ; 5244
	LD A,A ; 5245
	JRL loc_0x0050EF
; ---------------------- ; 5246
loc_0x005249:
	PUSH B ; 5249
	LD B,L ; 524b
	AND B,#01h ; 524c
	CP A,B ; 524f
	JRL NZ,loc_0x00528C ; 5250
	POP B ; 5253
	LD L,#00h ; 5255
	LD A,H ; 5257
	XOR A,[IX] ; 5258
	LD H,A ; 5259
	CP IX,#eeprom_buffer + 12 ; 525a
	JRL Z,loc_0x0052CC ; 525d
	INC IX ; 5260
	NOP ; 5261
	NOP ; 5262
	NOP ; 5263
	NOP ; 5264
	NOP ; 5265
	NOP ; 5266
	NOP ; 5267
	NOP ; 5268
	NOP ; 5269
	NOP ; 526a
	NOP ; 526b
	NOP ; 526c
	NOP ; 526d
	NOP ; 526e
	NOP ; 526f
	NOP ; 5270
	NOP ; 5271
	NOP ; 5272
	NOP ; 5273
	NOP ; 5274
	NOP ; 5275
	NOP ; 5276
	NOP ; 5277
	NOP ; 5278
	NOP ; 5279
	NOP ; 527a
	NOP ; 527b
	NOP ; 527c
	NOP ; 527d
	NOP ; 527e
	NOP ; 527f
	NOP ; 5280
	NOP ; 5281
	NOP ; 5282
	NOP ; 5283
	NOP ; 5284
	NOP ; 5285
	NOP ; 5286
	NOP ; 5287
	LD A,A ; 5288
	JRL loc_0x0050EF
; ---------------------- ; 5289
loc_0x00528C:
	POP B ; 528c
	LD A,[eeprom_buffer + 13] ; 528e
	CP A,#00h ; 5292
	JRL NZ,loc_0x0055F8 ; 5294
	LD A,#01h ; 5297
	LD [eeprom_buffer + 13],A ; 5299
	LD IY,#eeprom_buffer + 7 ; 529d
	LD [IY],IX ; 52a0
	LD L,#00h ; 52a2
	CP IX,#eeprom_buffer + 12 ; 52a4
	JRL Z,loc_0x0052D8 ; 52a7
	INC IX ; 52aa
	NOP ; 52ab
	NOP ; 52ac
	NOP ; 52ad
	NOP ; 52ae
	NOP ; 52af
	NOP ; 52b0
	NOP ; 52b1
	NOP ; 52b2
	NOP ; 52b3
	NOP ; 52b4
	NOP ; 52b5
	NOP ; 52b6
	NOP ; 52b7
	NOP ; 52b8
	NOP ; 52b9
	NOP ; 52ba
	NOP ; 52bb
	NOP ; 52bc
	NOP ; 52bd
	NOP ; 52be
	NOP ; 52bf
	NOP ; 52c0
	NOP ; 52c1
	NOP ; 52c2
	NOP ; 52c3
	NOP ; 52c4
	NOP ; 52c5
	NOP ; 52c6
	NOP ; 52c7
	LD A,A ; 52c8
	JRL loc_0x0050EF
; ---------------------- ; 52c9
loc_0x0052CC:
	LD A,[eeprom_buffer + 13] ; 52cc
	LD A,A ; 52d0
	NOP ; 52d1
	NOP ; 52d2
	NOP ; 52d3
	NOP ; 52d4
	NOP ; 52d5
	NOP ; 52d6
	NOP ; 52d7
loc_0x0052D8:
	CP A,#00h ; 52d8
	JRS NZ,loc_0x0052F4 ; 52da
	LD IX,#eeprom_buffer + 16 ; 52dc
	LD IY,[IX] ; 52df
	LD IX,#eeprom_buffer + 9 ; 52e1
	LD A,[IX] ; 52e4
	LD [IY],A ; 52e5
	INC IX ; 52e6
	INC IY ; 52e7
	LD A,[IX] ; 52e8
	LD [IY],A ; 52e9
	INC IX ; 52ea
	INC IY ; 52eb
	LD A,[IX] ; 52ec
	LD [IY],A ; 52ed
	NOP ; 52ee
	NOP ; 52ef
	NOP ; 52f0
	NOP ; 52f1
	JRS loc_0x00530C
; ---------------------- ; 52f2
loc_0x0052F4:
	LD IY,#eeprom_buffer + 7 ; 52f4
	LD IX,[IY] ; 52f7
	LD [IX],H ; 52f9
	LD IX,#eeprom_buffer + 16 ; 52fa
	LD IY,[IX] ; 52fd
	LD IX,#eeprom_buffer + 9 ; 52ff
	LD A,[IX] ; 5302
	LD [IY],A ; 5303
	INC IX ; 5304
	INC IY ; 5305
	LD A,[IX] ; 5306
	LD [IY],A ; 5307
	INC IX ; 5308
	INC IY ; 5309
	LD A,[IX] ; 530a
	LD [IY],A ; 530b
loc_0x00530C:
	LD IX,#eeprom_buffer + 14 ; 530c
	LD A,[IX] ; 530f
	DEC A ; 5310
	JRL Z,loc_0x00532A ; 5311
	LD [IX],A ; 5314
	LD L,#0FFh ; 5315
	NOP ; 5317
	JRL loc_0x0050EF
; ---------------------- ; 5318
loc_0x00531B:
	LD [eeprom_buffer + 15],A ; 531b
	LD A,#0FFh ; 531f
	LD [eeprom_buffer + 2],A ; 5321
	NOP ; 5325
	NOP ; 5326
	JRL loc_0x005330
; ---------------------- ; 5327
loc_0x00532A:
	NOP ; 532a
	NOP ; 532b
	NOP ; 532c
	JRL loc_0x005330
; ---------------------- ; 532d
loc_0x005330:
	CARL loc_0x005634 ; 5330
	CP A,#0FFh ; 5333
	JRL Z,loc_0x0055F5 ; 5335
	LD A,[eeprom_buffer + 15] ; 5338
	CP A,#00h ; 533c
	JRS Z,loc_0x005348 ; 533e
	CP A,#01h ; 5340
	JRS Z,loc_0x00534C ; 5342
	LD A,#3Bh ; 5344
	JRS loc_0x005352
; ---------------------- ; 5346
loc_0x005348:
	LD A,#1Dh ; 5348
	JRS loc_0x005350
; ---------------------- ; 534a
loc_0x00534C:
	LD A,#31h ; 534c
	JRS loc_0x005352
; ---------------------- ; 534e
loc_0x005350:
	NOP ; 5350
	NOP ; 5351
loc_0x005352:
	LD L,A ; 5352
	INC A ; 5353
	LD [eeprom_buffer + 15],A ; 5354
	LD A,#01h ; 5358
	LD IX,#151Fh ; 535a
	LD [IX],A ; 535d
	LD H,#07h ; 535e
	NOP ; 5360
	NOP ; 5361
	NOP ; 5362
	NOP ; 5363
	NOP ; 5364
	NOP ; 5365
	NOP ; 5366
	NOP ; 5367
	NOP ; 5368
	NOP ; 5369
	NOP ; 536a
	NOP ; 536b
	NOP ; 536c
	NOP ; 536d
	NOP ; 536e
	NOP ; 536f
	NOP ; 5370
	NOP ; 5371
	NOP ; 5372
	NOP ; 5373
	NOP ; 5374
	NOP ; 5375
	NOP ; 5376
	NOP ; 5377
	NOP ; 5378
	NOP ; 5379
	NOP ; 537a
	NOP ; 537b
	NOP ; 537c
	NOP ; 537d
	NOP ; 537e
	NOP ; 537f
	NOP ; 5380
	NOP ; 5381
	NOP ; 5382
	NOP ; 5383
	NOP ; 5384
	NOP ; 5385
	NOP ; 5386
	NOP ; 5387
	NOP ; 5388
	LD A,A ; 5389
loc_0x00538A:
	CARL loc_0x005634 ; 538a
	CP A,#0FFh ; 538d
	JRL Z,loc_0x0055F5 ; 538f
	CP A,#01h ; 5392
	JRS Z,loc_0x00539D ; 5394
	LD A,[IX] ; 5396
	SLA A ; 5397
	LD [IX],A ; 5399
	LD A,A ; 539a
	JRS loc_0x0053A3
; ---------------------- ; 539b
loc_0x00539D:
	LD A,[IX] ; 539d
	SLA A ; 539e
	OR A,#01h ; 53a0
	LD [IX],A ; 53a2
loc_0x0053A3:
	DEC H ; 53a3
	JRS NZ,loc_0x0053AB ; 53a4
	INC IX ; 53a6
	LD H,#08h ; 53a7
	JRS loc_0x0053AE
; ---------------------- ; 53a9
loc_0x0053AB:
	NOP ; 53ab
	NOP ; 53ac
	NOP ; 53ad
loc_0x0053AE:
	DEC L ; 53ae
	JRL Z,loc_0x0053E0 ; 53af
	NOP ; 53b2
	NOP ; 53b3
	NOP ; 53b4
	NOP ; 53b5
	NOP ; 53b6
	NOP ; 53b7
	NOP ; 53b8
	NOP ; 53b9
	NOP ; 53ba
	NOP ; 53bb
	NOP ; 53bc
	NOP ; 53bd
	NOP ; 53be
	NOP ; 53bf
	NOP ; 53c0
	NOP ; 53c1
	NOP ; 53c2
	NOP ; 53c3
	NOP ; 53c4
	NOP ; 53c5
	NOP ; 53c6
	NOP ; 53c7
	NOP ; 53c8
	NOP ; 53c9
	NOP ; 53ca
	NOP ; 53cb
	NOP ; 53cc
	NOP ; 53cd
	NOP ; 53ce
	NOP ; 53cf
	NOP ; 53d0
	NOP ; 53d1
	NOP ; 53d2
	NOP ; 53d3
	NOP ; 53d4
	NOP ; 53d5
	NOP ; 53d6
	NOP ; 53d7
	NOP ; 53d8
	NOP ; 53d9
	NOP ; 53da
	NOP ; 53db
	LD A,A ; 53dc
	JRL loc_0x00538A
; ---------------------- ; 53dd
loc_0x0053E0:
	CP H,#00h ; 53e0
	JRS Z,loc_0x0053EC ; 53e3
	LD A,[IX] ; 53e5
	SLA A ; 53e6
	LD [IX],A ; 53e8
	DEC H ; 53e9
	JRS NZ,loc_0x0053E0 ; 53ea
loc_0x0053EC:
	LD A,[eeprom_buffer + 3] ; 53ec
	CP A,[u8_150c] ; 53f0
	JRL C,loc_0x0055FE ; 53f3
	LD A,[eeprom_buffer + 2] ; 53f6
	CP A,#0FFh ; 53fa
	JRS Z,loc_0x005408 ; 53fc
	LD IY,#eeprom_buffer + 16 ; 53fe
	LD HL,[IY] ; 5401
	INC HL ; 5403
	INC HL ; 5404
	INC HL ; 5405
	LD [IY],HL ; 5406
loc_0x005408:
	LD L,[eeprom_buffer + 15] ; 5408
	LD H,#00h ; 540c
	LD A,#0Ah ; 540e
	DIV ; 5410
	LD [eeprom_buffer + 7],L ; 5412
	LD B,#00h ; 5416
	LD [eeprom_buffer + 9],B ; 5418
	LD [eeprom_buffer + 8],B ; 541c
	LD B,#0Ah ; 5420
	LD [eeprom_buffer + 10],B ; 5422
	LD L,[eeprom_buffer + 15] ; 5426
	LD IX,#151Fh ; 542a
	LD IY,#151Fh ; 542d
	LD H,#08h ; 5430
	LD A,#00h ; 5432
loc_0x005434:
	LD A,[IX] ; 5434
loc_0x005435:
	PUSH A ; 5435
	LD A,[eeprom_buffer + 10] ; 5437
	DEC A ; 543b
	LD [eeprom_buffer + 10],A ; 543c
	CP A,#09h ; 5440
	JRS Z,loc_0x005458 ; 5442
	CP A,#00h ; 5444
	JRS Z,loc_0x00545E ; 5446
	POP A ; 5448
	LD B,[eeprom_buffer + 8] ; 544a
	SLA A ; 544e
	RL B ; 5450
	LD [eeprom_buffer + 8],B ; 5452
	JRS loc_0x0054AA
; ---------------------- ; 5456
loc_0x005458:
	POP A ; 5458
	SLA A ; 545a
	JRS loc_0x0054AA
; ---------------------- ; 545c
loc_0x00545E:
	POP A ; 545e
	LD B,[eeprom_buffer + 8] ; 5460
	LD [IY],B ; 5464
	PUSH L ; 5465
	PUSH H ; 5467
	LD L,#00h ; 5469
	LD H,#08h ; 546b
loc_0x00546D:
	SLL B ; 546d
	JRS NC,loc_0x005472 ; 546f
	INC L ; 5471
loc_0x005472:
	DEC H ; 5472
	JRS NZ,loc_0x00546D ; 5473
	AND L,#01h ; 5475
	SLA A ; 5478
	RL B ; 547a
	AND B,#01h ; 547c
	PUSH A ; 547f
	LD A,L ; 5481
	CP A,B ; 5482
	JRS NZ,loc_0x005491 ; 5483
	LD A,[eeprom_buffer + 9] ; 5485
	SLA A ; 5489
	LD [eeprom_buffer + 9],A ; 548b
	JRS loc_0x00549D
; ---------------------- ; 548f
loc_0x005491:
	LD A,[eeprom_buffer + 9] ; 5491
	SLA A ; 5495
	OR A,#01h ; 5497
	LD [eeprom_buffer + 9],A ; 5499
loc_0x00549D:
	LD A,#0Ah ; 549d
	LD [eeprom_buffer + 10],A ; 549f
	INC IY ; 54a3
	POP A ; 54a4
	POP H ; 54a6
	POP L ; 54a8
loc_0x0054AA:
	DEC L ; 54aa
	JRS Z,loc_0x0054B5 ; 54ab
	DEC H ; 54ad
	JRS NZ,loc_0x005435 ; 54ae
	LD H,#08h ; 54b0
	INC IX ; 54b2
	JRS loc_0x005434
; ---------------------- ; 54b3
loc_0x0054B5:
	LD A,[eeprom_buffer + 7] ; 54b5
	CP A,#03h ; 54b9
	JRL Z,loc_0x005565 ; 54bb
	CP A,#05h ; 54be
	JRL Z,loc_0x005516 ; 54c0
	LD A,[eeprom_buffer + 9] ; 54c3
	SLA A ; 54c7
	SLA A ; 54c9
	LD [eeprom_buffer + 9],A ; 54cb
	LD H,#03h ; 54cf
	LD IX,#151Fh ; 54d1
	LD IY,#eeprom_buffer + 11 ; 54d4
	CARL loc_0x005607 ; 54d7
	CP A,#01h ; 54da
	JRL Z,loc_0x0055F8 ; 54dc
	LD IX,#eeprom_buffer + 16 ; 54df
	LD IY,[IX] ; 54e2
	LD IX,#151Fh ; 54e4
	LD A,[IX] ; 54e7
	LD [IY],A ; 54e8
	INC IX ; 54e9
	INC IY ; 54ea
	LD A,[IX] ; 54eb
	LD [IY],A ; 54ec
	LD A,[eeprom_buffer + 9] ; 54ed
	SLA A ; 54f1
	SLA A ; 54f3
	SLA A ; 54f5
	LD H,#03h ; 54f7
	LD IX,#1522h ; 54f9
	LD IY,#eeprom_buffer + 11 ; 54fc
	CARL loc_0x005607 ; 54ff
	CP A,#01h ; 5502
	JRL Z,loc_0x0055F8 ; 5504
	LD IY,#eeprom_buffer ; 5507
	LD IX,#1522h ; 550a
	LD A,[IX] ; 550d
	LD [IY],A ; 550e
	INC IX ; 550f
	INC IY ; 5510
	LD A,[IX] ; 5511
	LD [IY],A ; 5512
	JRL loc_0x005592
; ---------------------- ; 5513
loc_0x005516:
	LD A,[eeprom_buffer + 9] ; 5516
	SLA A ; 551a
	SLA A ; 551c
	SLA A ; 551e
	LD [eeprom_buffer + 9],A ; 5520
	LD H,#02h ; 5524
	LD IX,#151Fh ; 5526
	LD IY,#eeprom_buffer + 11 ; 5529
	CARL loc_0x005607 ; 552c
	CP A,#01h ; 552f
	JRL Z,loc_0x0055F8 ; 5531
	LD IX,#eeprom_buffer + 16 ; 5534
	LD IY,[IX] ; 5537
	LD IX,#151Fh ; 5539
	LD A,[IX] ; 553c
	LD [IY],A ; 553d
	LD A,[eeprom_buffer + 9] ; 553e
	SLA A ; 5542
	SLA A ; 5544
	LD H,#03h ; 5546
	LD IX,#1521h ; 5548
	LD IY,#eeprom_buffer + 11 ; 554b
	CARL loc_0x005607 ; 554e
	CP A,#01h ; 5551
	JRL Z,loc_0x0055F8 ; 5553
	LD IY,#eeprom_buffer ; 5556
	LD IX,#1521h ; 5559
	LD A,[IX] ; 555c
	LD [IY],A ; 555d
	INC IX ; 555e
	INC IY ; 555f
	LD A,[IX] ; 5560
	LD [IY],A ; 5561
	JRL loc_0x005592
; ---------------------- ; 5562
loc_0x005565:
	LD A,[eeprom_buffer + 9] ; 5565
	SLA A ; 5569
	SLA A ; 556b
	SLA A ; 556d
	SLA A ; 556f
	SLA A ; 5571
	LD H,#02h ; 5573
	LD IX,#151Fh ; 5575
	LD IY,#eeprom_buffer + 11 ; 5578
	CARL loc_0x005607 ; 557b
	CP A,#01h ; 557e
	JRL Z,loc_0x0055F8 ; 5580
	LD IY,#eeprom_buffer ; 5583
	LD IX,#151Fh ; 5586
	LD A,[IX] ; 5589
	LD [IY],A ; 558a
	INC IX ; 558b
	INC IY ; 558c
	LD A,[IX] ; 558d
	LD [IY],A ; 558e
	JRL loc_0x005592
; ---------------------- ; 558f
loc_0x005592:
	LD HL,#0000h ; 5592
	LD B,#00h ; 5595
	LD IX,#u8_150a ; 5597
	LD A,[IX] ; 559a
	ADD HL,BA ; 559b
	INC IX ; 559d
	LD A,[IX] ; 559e
	ADD HL,BA ; 559f
	INC IX ; 55a1
	LD A,[IX] ; 55a2
	ADD HL,BA ; 55a3
	CP A,#00h ; 55a5
	JRS Z,loc_0x0055B7 ; 55a7
	LD IY,#eeprom_buffer + 5 ; 55a9
	LD IX,[IY] ; 55ac
	LD IY,BA ; 55ae
loc_0x0055B0:
	LD A,[IX] ; 55b0
	ADD HL,BA ; 55b1
	INC IX ; 55b3
	DEC IY ; 55b4
	JRS NZ,loc_0x0055B0 ; 55b5
loc_0x0055B7:
	LD A,[eeprom_buffer] ; 55b7
	LD B,L ; 55bb
	CP A,B ; 55bc
	JRL NZ,loc_0x0055FB ; 55bd
	LD A,[eeprom_buffer + 1] ; 55c0
	LD B,H ; 55c4
	CP A,B ; 55c5
	JRL NZ,loc_0x0055FB ; 55c6
	LD A,[u8_150a] ; 55c9
	LD H,A ; 55cd
	LD A,[u8_150b] ; 55ce
	LD B,A ; 55d2
	LD A,[u8_150c] ; 55d3
	LD L,A ; 55d7
	LD A,#00h ; 55d8
	RET
; ---------------------- ; 55da
loc_0x0055DB:
	LD A,#12h ; 55db
	LD B,H ; 55dd
	SUB A,B ; 55de
	LD H,#00h ; 55df
	LD L,#0Fh ; 55e1
	MLT ; 55e3
	LD IY,[u8_150a] ; 55e5
	SUB IY,HL ; 55e8
	JRS NC,loc_0x0055EF ; 55ea
	LD IY,#0000h ; 55ec
loc_0x0055EF:
	LD [u8_150a],IY ; 55ef
	LD A,#01h ; 55f2
	RET
; ---------------------- ; 55f4
loc_0x0055F5:
	LD A,#02h ; 55f5
	RET
; ---------------------- ; 55f7
loc_0x0055F8:
	LD A,#03h ; 55f8
	RET
; ---------------------- ; 55fa
loc_0x0055FB:
	LD A,#04h ; 55fb
	RET
; ---------------------- ; 55fd
loc_0x0055FE:
	LD A,#05h ; 55fe
	RET
; ---------------------- ; 5600
loc_0x005601:
	LD A,#0FFh ; 5601
	RET
; ---------------------- ; 5603
loc_0x005604:
	LD A,#0FEh ; 5604
	RET
; ---------------------- ; 5606
loc_0x005607:
	LD B,#00h ; 5607
	LD L,#00h ; 5609
loc_0x00560B:
	SLA A ; 560b
	JRS NC,loc_0x00561B ; 560d
	INC L ; 560f
	CP L,#02h ; 5610
	JRL Z,loc_0x005631 ; 5613
	LD [IY],IX ; 5616
	INC IX ; 5618
	JRS loc_0x005623
; ---------------------- ; 5619
loc_0x00561B:
	PUSH A ; 561b
	LD A,[IX] ; 561d
	XOR A,B ; 561e
	EX A,B ; 561f
	POP A ; 5620
	INC IX ; 5622
loc_0x005623:
	DEC H ; 5623
	JRS NZ,loc_0x00560B ; 5624
	CP L,#00h ; 5626
	JRS Z,loc_0x00562E ; 5629
	LD IX,[IY] ; 562b
	LD [IX],B ; 562d
loc_0x00562E:
	LD A,#00h ; 562e
	RET
; ---------------------- ; 5630
loc_0x005631:
	LD A,#01h ; 5631
	RET
; ---------------------- ; 5633
loc_0x005634:
	LD A,A ; 5634
	LD [BR:IRQ_ACT4],#IRQ4_IR_RECV
	DEC B ; 5638
	JRS NZ,loc_0x00565E ; 5639
	LD B,#0Ah ; 563b
	LD A,#0Ah ; 563d
loc_0x00563F:
	DEC A ; 563f
	JRS Z,loc_0x005683 ; 5640
	BIT [BR:IRQ_ACT4],#IRQ4_IR_RECV
	JRS Z,loc_0x00563F ; 5645
	CP L,#0FFh ; 5647
	JRS NZ,loc_0x005654 ; 564a
	LD A,#05h ; 564c
	LD [eeprom_buffer + 2],A ; 564e
	JRS loc_0x005659
; ---------------------- ; 5652
loc_0x005654:
	LD A,A ; 5654
	NOP ; 5655
	NOP ; 5656
	NOP ; 5657
	NOP ; 5658
loc_0x005659:
	NOP ; 5659
	NOP ; 565a
	NOP ; 565b
	JRS loc_0x005680
; ---------------------- ; 565c
loc_0x00565E:
	LD A,A ; 565e
	NOP ; 565f
	NOP ; 5660
	NOP ; 5661
	NOP ; 5662
	NOP ; 5663
	NOP ; 5664
	NOP ; 5665
	NOP ; 5666
	NOP ; 5667
	NOP ; 5668
	NOP ; 5669
	NOP ; 566a
	NOP ; 566b
	NOP ; 566c
	NOP ; 566d
	NOP ; 566e
	NOP ; 566f
	NOP ; 5670
	NOP ; 5671
	NOP ; 5672
	NOP ; 5673
	NOP ; 5674
	NOP ; 5675
	NOP ; 5676
	NOP ; 5677
	BIT [BR:IRQ_ACT4],#IRQ4_IR_RECV
	JRS NZ,loc_0x005680 ; 567b
	LD A,#00h ; 567d
	RET
; ---------------------- ; 567f
loc_0x005680:
	LD A,#01h ; 5680
	RET
; ---------------------- ; 5682
loc_0x005683:
	LD A,#0FFh ; 5683
	RET
; ---------------------- ; 5685
global loc_0x005686
loc_0x005686:
	LD EP,#00h ; 5686
	LD A,#00h ; 5689
	LD [1527h],A ; 568b
	LD [1529h],A ; 568f
	LD [152Ah],A ; 5693
	LD [152Bh],A ; 5697
	LD [152Ch],A ; 569b
	LD [152Dh],A ; 569f
	LD [152Eh],A ; 56a3
	LD [152Fh],A ; 56a7
	CARL loc_0x004B25 ; 56ab
	RET
; ---------------------- ; 56ae
loc_0x0056AF:
	LD [152Eh],A ; 56af
	LD [152Dh],B ; 56b3
	LD EP,#00h ; 56b7
	LD EP,#00h ; 56ba
	LD BR,#20h ; 56bd
	LD L,[BR:IRQ_ENA1] ; 56bf
	LD H,[BR:IRQ_ENA2] ; 56c1
	PUSH HL ; 56c3
	LD L,[BR:IRQ_ENA4] ; 56c4
	LD H,[BR:PRC_MODE] ; 56c6
	PUSH HL ; 56c8
	LD [BR:IRQ_ENA1],#00h ; 56c9
	AND [BR:IRQ_ENA2],#(IRQ1_TIM3_HI_UF | IRQ1_TIM3_PIVOT)
	AND [BR:IRQ_ENA4],#0FFh^(IRQ4_IR_RECV | IRQ4_SHOCK) ; 56cf
loc_0x0056D2:
	CARL loc_0x005A1D ; 56d2
	CP A,#00h ; 56d5
	JRS NZ,loc_0x0056D2 ; 56d7
	LD [BR:PRC_MODE],#00h ; 56d9
	PUSH IP ; 56dc
	PUSH IX ; 56dd
	LD YP,#00h ; 56de
	LD IY,#REG_BASE + IO_DATA ; 56e1
	CARL loc_0x004E10 ; 56e4
	POP IX ; 56e7
	POP IP ; 56e8
	LD B,#96h ; 56e9
loc_0x0056EB:
	DJR NZ,loc_0x0056EB ; 56eb
	LD A,[152Eh] ; 56ed
	LD B,[152Dh] ; 56f1
	LD H,#01h ; 56f5
	CARL loc_0x004B3C ; 56f7
	LD IY,#0181h ; 56fa
loc_0x0056FD:
	LD A,#01h ; 56fd
	LD XP,#00h ; 56ff
	LD IX,#152Ah ; 5702
	CARL loc_0x004E79 ; 5705
	CP A,#01h ; 5708
	JRS NZ,loc_0x00571D ; 570a
	LD A,[u8_150a] ; 570c
	LD B,[u8_150b] ; 5710
	LD IY,BA ; 5714
	OR A,B ; 5716
	CP A,#00h ; 5717
	JRS NZ,loc_0x0056FD ; 5719
	LD A,#0FFh ; 571b
loc_0x00571D:
	CARL loc_0x005A0D ; 571d
	LD EP,#00h ; 5720
	LD BR,#20h ; 5723
	LD [BR:IRQ_ACT1],#0FFh ; 5725
	LD [BR:IRQ_ACT2],#0FFh ; 5728
	LD [BR:IRQ_ACT3],#0FFh ; 572b
	LD [BR:IRQ_ACT4],#0FFh ; 572e
	POP HL ; 5731
	LD [BR:IRQ_ENA4],L ; 5732
	LD [BR:PRC_MODE],H ; 5734
	POP HL ; 5736
	LD [BR:IRQ_ENA1],L ; 5737
	LD [BR:IRQ_ENA2],H ; 5739
	RET
; ---------------------- ; 573b
loc_0x00573C:
	LD EP,#00h ; 573c
	LD BR,#20h ; 573f
	LD [152Fh],A ; 5741
	LD [152Ah],IX ; 5745
	LD A,#00h ; 5748
	LD [1528h],A ; 574a
	LD [BR:IRQ_ACT4],#IRQ4_IR_RECV
	OR [BR:IRQ_ENA4],#IRQ4_IR_RECV
	RET
; ---------------------- ; 5754
loc_0x005755:
	PUSH ALE ; 5755
	AND SC,#0CFh ; 5757
	LD EP,#00h ; 5759
	LD BR,#20h ; 575c
	LD [BR:IRQ_ACT4],#IRQ4_IR_RECV
	CARL loc_0x005959 ; 5761
	CP A,#00h ; 5764
	JRS Z,loc_0x005776 ; 5766
	CP A,#03h ; 5768
	JRS Z,loc_0x00576E ; 576a
	JRS loc_0x005780
; ---------------------- ; 576c
loc_0x00576E:
	LD A,#02h ; 576e
	LD [1528h],A ; 5770
	JRS loc_0x00577D
; ---------------------- ; 5774
loc_0x005776:
	LD A,B ; 5776
	ADD A,#80h ; 5777
	LD [1528h],A ; 5779
loc_0x00577D:
	AND [BR:26h],#7Fh ; 577d
loc_0x005780:
	LD [BR:2Ah],#80h ; 5780
	POP ALE ; 5783
	RETE
; ---------------------- ; 5785
global loc_0x005786
loc_0x005786:
	LD EP,#00h ; 5786
	LD [152Eh],A ; 5789
	LD [152Dh],B ; 578d
	LD EP,#00h ; 5791
	LD BR,#20h ; 5794
	LD L,[BR:23h] ; 5796
	LD H,[BR:24h] ; 5798
	PUSH HL ; 579a
	LD L,[BR:26h] ; 579b
	LD H,[BR:PRC_MODE] ; 579d
	PUSH HL ; 579f
	LD L,[BR:25h] ; 57a0
	PUSH L ; 57a2
	LD [BR:23h],#00h ; 57a4
	AND [BR:24h],#03h ; 57a7
	LD [BR:25h],#00h ; 57aa
	AND [BR:26h],#0BFh ; 57ad
loc_0x0057B0:
	CARL loc_0x005A1D ; 57b0
	CP A,#00h ; 57b3
	JRS NZ,loc_0x0057B0 ; 57b5
	LD [BR:PRC_MODE],#00h ; 57b7
	LD A,#03h ; 57ba
	LD [1529h],A ; 57bc
loc_0x0057C0:
	LD A,[152Eh] ; 57c0
	LD B,[152Dh] ; 57c4
	PUSH IP ; 57c8
	PUSH IX ; 57c9
	LD H,#00h ; 57ca
	CARL loc_0x004B3C ; 57cc
	POP IX ; 57cf
	POP IP ; 57d0
	CP A,#00h ; 57d1
	JRL NZ,loc_0x005839 ; 57d3
	LD A,[152Eh] ; 57d6
	CP A,#0FFh ; 57da
	JRS Z,loc_0x005816 ; 57dc
	LD IY,#0514h ; 57de
loc_0x0057E1:
	PUSH IP ; 57e1
	PUSH IX ; 57e2
	LD A,#01h ; 57e3
	LD XP,#00h ; 57e5
	LD IX,#152Ah ; 57e8
	CARL loc_0x004E79 ; 57eb
	POP IX ; 57ee
	POP IP ; 57ef
	CP A,#01h ; 57f0
	JRS NZ,loc_0x005805 ; 57f2
	LD A,[u8_150a] ; 57f4
	LD B,[u8_150b] ; 57f8
	LD IY,BA ; 57fc
	OR A,B ; 57fe
	CP A,#00h ; 57ff
	JRS NZ,loc_0x0057E1 ; 5801
	LD A,#0FFh ; 5803
loc_0x005805:
	CP A,#00h ; 5805
	JRS NZ,loc_0x005839 ; 5807
	LD A,#11h ; 5809
	CARL loc_0x005A05 ; 580b
	LD A,[152Ah] ; 580e
	CP A,#00h ; 5812
	JRS NZ,loc_0x005839 ; 5814
loc_0x005816:
	CARL loc_0x005A0D ; 5816
	LD EP,#00h ; 5819
	LD BR,#20h ; 581c
	LD [BR:27h],#0FFh ; 581e
	LD [BR:28h],#0FFh ; 5821
	LD [BR:29h],#0FFh ; 5824
	LD [BR:2Ah],#0FFh ; 5827
	POP L ; 582a
	LD [BR:25h],L ; 582c
	POP HL ; 582e
	LD [BR:26h],L ; 582f
	LD [BR:PRC_MODE],H ; 5831
	POP HL ; 5833
	LD [BR:23h],L ; 5834
	LD [BR:24h],H ; 5836
	RET
; ---------------------- ; 5838
loc_0x005839:
	LD HL,#1529h ; 5839
	DEC [HL] ; 583c
	JRL NZ,loc_0x0057C0 ; 583d
	JRS loc_0x005816
; ---------------------- ; 5840
global loc_0x005842
loc_0x005842:
	LD EP,#00h ; 5842
	LD [152Fh],A ; 5845
	LD EP,#00h ; 5849
	LD BR,#20h ; 584c
	LD L,[BR:23h] ; 584e
	LD H,[BR:24h] ; 5850
	PUSH HL ; 5852
	LD L,[BR:26h] ; 5853
	LD H,[BR:PRC_MODE] ; 5855
	PUSH HL ; 5857
	LD [BR:23h],#00h ; 5858
	AND [BR:24h],#03h ; 585b
	AND [BR:26h],#3Fh ; 585e
loc_0x005861:
	CARL loc_0x005A1D ; 5861
	CP A,#00h ; 5864
	JRS NZ,loc_0x005861 ; 5866
	LD [BR:PRC_MODE],#00h ; 5868
	LD A,[152Fh] ; 586b
	CP A,#00h ; 586f
	JRS NZ,loc_0x005879 ; 5871
	LD XP,#00h ; 5873
	LD IX,#152Ah ; 5876
loc_0x005879:
	LD A,#03h ; 5879
	LD [1529h],A ; 587b
	LD A,#00h ; 587f
	LD [152Ch],A ; 5881
loc_0x005885:
	LD A,[1529h] ; 5885
	CP A,#00h ; 5889
	JRL Z,loc_0x0058FC ; 588b
	DEC A ; 588e
	LD [1529h],A ; 588f
loc_0x005893:
	LD A,[152Fh] ; 5893
	PUSH IP ; 5897
	PUSH IX ; 5898
	CARL loc_0x004E79 ; 5899
	POP IX ; 589c
	POP IP ; 589d
	LD [152Ah],A ; 589e
	CP A,#0FFh ; 58a2
	JRL Z,loc_0x005923 ; 58a4
	CP A,#01h ; 58a7
	JRS NZ,loc_0x0058BC ; 58a9
	LD A,[u8_150a] ; 58ab
	LD B,[u8_150b] ; 58af
	LD IY,BA ; 58b3
	OR A,B ; 58b5
	CP A,#00h ; 58b6
	JRS NZ,loc_0x005893 ; 58b8
	JRS loc_0x005923
; ---------------------- ; 58ba
loc_0x0058BC:
	CP A,#00h ; 58bc
	JRS NZ,loc_0x005885 ; 58be
	LD [152Dh],L ; 58c0
	CP L,#00h ; 58c4
	JRS NZ,loc_0x0058D2 ; 58c7
	CP B,#0FFh ; 58c9
	JRS Z,loc_0x0058D2 ; 58cc
	LD [1527h],B ; 58ce
loc_0x0058D2:
	LD A,[1527h] ; 58d2
	CP A,#0FFh ; 58d6
	JRS Z,loc_0x0058FC ; 58d8
	CP A,B ; 58da
	JRS NZ,loc_0x00593B ; 58db
	LD A,#01h ; 58dd
	LD [152Ch],A ; 58df
	LD A,#00h ; 58e3
	LD B,#01h ; 58e5
	PUSH IP ; 58e7
	PUSH IX ; 58e8
	LD XP,#00h ; 58e9
	LD IX,#152Ah ; 58ec
	LD H,#00h ; 58ef
	CARL loc_0x004B3C ; 58f1
	POP IX ; 58f4
	POP IP ; 58f5
	LD IY,#0514h ; 58f6
	JRL loc_0x005885
; ---------------------- ; 58f9
loc_0x0058FC:
	LD A,[152Ah] ; 58fc
	CARL loc_0x005A0D ; 5900
	LD B,[152Dh] ; 5903
	LD EP,#00h ; 5907
	LD BR,#20h ; 590a
	LD [BR:27h],#0FFh ; 590c
	LD [BR:28h],#0FFh ; 590f
	LD [BR:29h],#0FFh ; 5912
	LD [BR:2Ah],#0FFh ; 5915
	POP HL ; 5918
	LD [BR:26h],L ; 5919
	LD [BR:PRC_MODE],H ; 591b
	POP HL ; 591d
	LD [BR:23h],L ; 591e
	LD [BR:24h],H ; 5920
	RET
; ---------------------- ; 5922
loc_0x005923:
	LD A,[152Ch] ; 5923
	CP A,#00h ; 5927
	JRS NZ,loc_0x005933 ; 5929
	LD A,#0FFh ; 592b
	LD [152Ah],A ; 592d
	JRS loc_0x0058FC
; ---------------------- ; 5931
loc_0x005933:
	LD A,#00h ; 5933
	LD [152Ah],A ; 5935
	JRS loc_0x0058FC
; ---------------------- ; 5939
loc_0x00593B:
	LD A,#03h ; 593b
	LD EP,#00h ; 593d
	LD BR,#20h ; 5940
	LD [BR:27h],#0FFh ; 5942
	LD [BR:28h],#0FFh ; 5945
	LD [BR:29h],#0FFh ; 5948
	LD [BR:2Ah],#0FFh ; 594b
	POP HL ; 594e
	LD [BR:26h],L ; 594f
	LD [BR:PRC_MODE],H ; 5951
	POP HL ; 5953
	LD [BR:23h],L ; 5954
	LD [BR:24h],H ; 5956
	RET
; ---------------------- ; 5958
loc_0x005959:
	LD EP,#00h ; 5959
	LD EP,#00h ; 595c
	LD BR,#20h ; 595f
	LD L,[BR:23h] ; 5961
	LD H,[BR:24h] ; 5963
	PUSH HL ; 5965
	LD L,[BR:26h] ; 5966
	LD H,[BR:PRC_MODE] ; 5968
	PUSH HL ; 596a
	LD [BR:23h],#00h ; 596b
	AND [BR:24h],#03h ; 596e
	AND [BR:26h],#3Fh ; 5971
	CARL loc_0x005A1D ; 5974
	CP A,#00h ; 5977
	JRL NZ,loc_0x0059E6 ; 5979
	LD [BR:PRC_MODE],#00h ; 597c
	LD A,#00h ; 597f
	LD [152Ch],A ; 5981
	LD A,[152Fh] ; 5985
	LD XP,#00h ; 5989
	LD IX,[152Ah] ; 598c
	LD IY,#0050h ; 598f
	CARL loc_0x004E79 ; 5992
	LD [152Ch],A ; 5995
	CP A,#0FFh ; 5999
	JRS Z,loc_0x0059EA ; 599b
	CP A,#01h ; 599d
	JRS Z,loc_0x0059F2 ; 599f
	CP A,#00h ; 59a1
	JRS NZ,loc_0x0059E6 ; 59a3
	LD [152Dh],L ; 59a5
	CP B,#0FFh ; 59a9
	JRS Z,loc_0x0059B5 ; 59ac
	LD A,[1527h] ; 59ae
	CP A,B ; 59b2
	JRS NZ,loc_0x0059EE ; 59b3
loc_0x0059B5:
	LD A,#00h ; 59b5
	LD B,#01h ; 59b7
	LD XP,#00h ; 59b9
	LD IX,#152Ch ; 59bc
	LD H,#01h ; 59bf
	CARL loc_0x004B3C ; 59c1
	LD A,#00h ; 59c4
loc_0x0059C6:
	LD EP,#00h ; 59c6
	LD BR,#20h ; 59c9
	LD [BR:27h],#0FFh ; 59cb
	LD [BR:28h],#0FFh ; 59ce
	LD [BR:29h],#0FFh ; 59d1
	LD [BR:2Ah],#0FFh ; 59d4
	POP HL ; 59d7
	LD [BR:26h],L ; 59d8
	LD [BR:PRC_MODE],H ; 59da
	POP HL ; 59dc
	LD [BR:23h],L ; 59dd
	LD [BR:24h],H ; 59df
	LD B,[152Dh] ; 59e1
	RET
; ---------------------- ; 59e5
loc_0x0059E6:
	LD A,#01h ; 59e6
	JRS loc_0x0059C6
; ---------------------- ; 59e8
loc_0x0059EA:
	LD A,#02h ; 59ea
	JRS loc_0x0059C6
; ---------------------- ; 59ec
loc_0x0059EE:
	LD A,#03h ; 59ee
	JRS loc_0x0059C6
; ---------------------- ; 59f0
loc_0x0059F2:
	LD A,#04h ; 59f2
	JRS loc_0x0059C6
; ---------------------- ; 59f4
loc_0x0059F6:

	LD EP,#00h ; 59f6
	LD BR,#20h ; 59f9

	OR [BR:IO_DATA],#20h ; 59fb
	AND [BR:26h],#7Fh ; 59fe
	LD [BR:2Ah],#80h ; 5a01

	RET

; ---------------------- ; 5a04
loc_0x005A05:
	LD B,#0FAh ; 5a05
loc_0x005A07:
	DJR NZ,loc_0x005A07 ; 5a07
	DEC A ; 5a09
	JRS NZ,loc_0x005A05 ; 5a0a
	RET
; ---------------------- ; 5a0c
loc_0x005A0D:
	CP A,#00h ; 5a0d
	JRS Z,loc_0x005A1B ; 5a0f
	CP A,#0FFh ; 5a11
	JRS Z,loc_0x005A19 ; 5a13
	LD A,#01h ; 5a15
	JRS loc_0x005A1B
; ---------------------- ; 5a17
loc_0x005A19:
	LD A,#02h ; 5a19
loc_0x005A1B:
	RET
; ---------------------- ; 5a1b
	DB 10h
; ---------------------- ; 5a1c
loc_0x005A1D:
	LD BR,#20h ; 5a1d
	LD A,[BR:PRC_RATE] ; 5a1f
	RR A ; 5a21
	AND A,#07h ; 5a23
	LD H,#00h ; 5a25
	LD L,A ; 5a27
	ADD HL,#5A56h ; 5a28
	PUSH EP ; 5a2b
	LD EP,#00h ; 5a2c
	LD B,[HL] ; 5a2f
	POP EP ; 5a30
	LD A,[BR:PRC_RATE] ; 5a31
	AND A,#0F0h ; 5a33
	CP A,B ; 5a35
	JRS NZ,loc_0x005A53 ; 5a36
	BIT [BR:PRC_MODE],#08h ; 5a38
	JRS Z,loc_0x005A53 ; 5a3b
	BIT [BR:PRC_MODE],#06h ; 5a3d
	JRS Z,loc_0x005A49 ; 5a40
	CP [BR:PRC_CNT],#16h ; 5a42
	JRS NC,loc_0x005A50 ; 5a45
	JRS loc_0x005A53
; ---------------------- ; 5a47
loc_0x005A49:
	CP [BR:PRC_CNT],#37h ; 5a49
	JRS NC,loc_0x005A50 ; 5a4c
	JRS loc_0x005A53
; ---------------------- ; 5a4e
loc_0x005A50:
	LD A,#01h ; 5a50
	RET
; ---------------------- ; 5a52
loc_0x005A53:
	LD A,#00h ; 5a53
	RET
; ---------------------- ; 5a55
loc_0x005A56:
	AND A,A ; 5a56
	LD L,A ; 5a57
	INC A ; 5a58
	LD A,#10h ; 5a59
	CP A,A ; 5a5b
	LD L,A ; 5a5c
	LD [IY],A ; 5a5d
	LD BR,#20h ; 5a5e
	LD HL,#lookup_5a7f ; 5a60
loc_0x005A63:
	LD [BR:10h],[HL] ; 5a63
	OR [BR:10h],#10h ; 5a65
	LD B,#32h ; 5a68
loc_0x005A6A:
	DJR NZ,loc_0x005A6A ; 5a6a
	AND [BR:10h],#0EFh ; 5a6c
	BIT [BR:10h],#20h ; 5a6f
	JRS Z,loc_0x005A7A ; 5a72
	INC HL ; 5a74
	CP [HL],#0FFh ; 5a75
	JRS NZ,loc_0x005A63 ; 5a78
loc_0x005A7A:
	ADD HL,#0004h ; 5a7a
	LD A,[HL] ; 5a7d
	RET
; ---------------------- ; 5a7e
lookup_5a7f:
	DB 0Bh, 09h, 08h, 0FFh, 03h, 02h, 01h, 00h
; ---------------------- ; 5a7f
loc_0x005A87:
	CP A,#12h ; 5a87
	JRS C,loc_0x005AAD ; 5a89
	CP A,#2Eh ; 5a8b
	JRS NC,loc_0x005AAD ; 5a8d
	LD EP,#00h ; 5a8f
	LD BR,#20h ; 5a92
	LD IX,#1FF5h ; 5a94
	LD B,A ; 5a97
	PUSH A ; 5a98
	CARL loc_0x00421C ; 5a9a
	POP A ; 5a9d
	JRS NZ,loc_0x005AAA ; 5a9f
	PUSH SC ; 5aa1
	LD SC,#80h ; 5aa2
	INT [4Ch] ; 5aa4
	POP SC ; 5aa6
	LD A,#00h ; 5aa7
	RET
; ---------------------- ; 5aa9
loc_0x005AAA:
	LD A,#01h ; 5aaa
	RET
; ---------------------- ; 5aac
loc_0x005AAD:
	LD A,#02h ; 5aad
	RET
; ---------------------- ; 5aaf
loc_0x005AB0:

	LD EP,#00h ; 5ab0
	LD BR,#20h ; 5ab3
	LD A,[0096h] ; 5ab5
	CP A,#00h ; 5ab9
	JRS NZ,loc_0x005AC4 ; 5abb

	LD A,[BR:00h] ; 5abd
	SRL A ; 5abf
	SRL A ; 5ac1

	RET

; ---------------------- ; 5ac3
loc_0x005AC4:

	LD A,[BR:00h] ; 5ac4
	AND A,#3Ch ; 5ac6

	RET

; ---------------------- ; 5ac8
loc_0x005AC9:

	CP A,#40h ; 5ac9
	JRS NC,loc_0x005AD6 ; 5acb

	PUSH SC ; 5acd
	LD SC,#80h ; 5ace

	INT [54h] ; 5ad0

	POP SC ; 5ad2

	LD A,#00h ; 5ad3

	RET

; ---------------------- ; 5ad5
loc_0x005AD6:

	LD A,#02h ; 5ad6

	RET

; ---------------------- ; 5ad8
loc_0x005AD9:
	BIT A,#0FEh ; 5ad9
	JRS NZ,loc_0x005AF1 ; 5adb
	LD EP,#00h ; 5add
	LD BR,#20h ; 5ae0
	LD IX,#1FF2h ; 5ae2
	LD B,A ; 5ae5
	CARL loc_0x00421C ; 5ae6
	JRS NZ,loc_0x005AEE ; 5ae9
	LD A,#00h ; 5aeb
	RET
; ---------------------- ; 5aed
loc_0x005AEE:
	LD A,#01h ; 5aee
	RET
; ---------------------- ; 5af0
loc_0x005AF1:
	LD A,#02h ; 5af1
	RET
; ---------------------- ; 5af3
loc_0x005AF4:
	CP A,#05h ; 5af4
	JRS NC,loc_0x005B0C ; 5af6
	LD EP,#00h ; 5af8
	LD BR,#20h ; 5afb
	LD IX,#1FF3h ; 5afd
	LD B,A ; 5b00
	CARL loc_0x00421C ; 5b01
	JRS NZ,loc_0x005B09 ; 5b04
	LD A,#00h ; 5b06
	RET
; ---------------------- ; 5b08
loc_0x005B09:
	LD A,#01h ; 5b09
	RET
; ---------------------- ; 5b0b
loc_0x005B0C:
	LD A,#02h ; 5b0c
	RET
; ---------------------- ; 5b0e
loc_0x005B0F:
	CP A,#03h ; 5b0f
	JRS NC,loc_0x005B27 ; 5b11
	LD EP,#00h ; 5b13
	LD BR,#20h ; 5b16
	LD IX,#1FF4h ; 5b18
	LD B,A ; 5b1b
	CARL loc_0x00421C ; 5b1c
	JRS NZ,loc_0x005B24 ; 5b1f
	LD A,#00h ; 5b21
	RET
; ---------------------- ; 5b23
loc_0x005B24:
	LD A,#01h ; 5b24
	RET
; ---------------------- ; 5b26
loc_0x005B27:
	LD A,#02h ; 5b27
	RET
; ---------------------- ; 5b29
minlib_splash_screen:

	LD SC,#80h ; 5b2a
	LD EP,#00h ; 5b2c
	LD XP,#00h ; 5b2f
	LD YP,#00h ; 5b32
	LD BR,#20h ; 5b35

	LD [1E7Dh],B ; 5b37
	LD [1E7Eh],A ; 5b3b

	LD B,[0096h] ; 5b3f
	CP B,#0CEh ; 5b43
	JRS NZ,loc_0x005B4E ; 5b46

	LD B,#0FFh ; 5b48
	LD [1E7Dh],B ; 5b4a

loc_0x005B4E:

	LD A,[BR:KEY_PAD] ; 5b4e
	CPL A ; 5b50
	LD [1E7Ch],A ; 5b52

	CARL loc_0x005E4A ; 5b56

	LD HL,#1539h ; 5b59
	LD A,#40h ; 5b5c
	DIV ; 5b5e
	LD B,H ; 5b60
	SUB A,B ; 5b61
	AND A,#3Fh ; 5b62
	LD B,#00h ; 5b64
	ADD BA,#1539h ; 5b66
	LD [1E78h],BA ; 5b69

	LD IY,#minlib_startup_logo_data ; 5b6c
	LD HL,#minlib_startup_logo_data_end ; 5b6f
	CARL loc_0x005E21 ; 5b72

	LD A,[game_id + 3] ; 5b75
	CP A,#'J' ; 5b79
	JRS Z,loc_0x005B95 ; 5b7b

	PUSH IP ; 5b7d

	LD YP,#00h ; 5b7e
	LD IX,[1E78h] ; 5b81
	ADD IX,#0180h ; 5b84
	LD HL,IX ; 5b87

	LD IY,[1E78h] ; 5b89

loc_0x005B8C:

	LD A,[IY] ; 5b8c
	LD [IX],A ; 5b8d

	INC IX ; 5b8e
	INC IY ; 5b8f

	CP HL,IY ; 5b90
	JRS NZ,loc_0x005B8C ; 5b92

	POP IP ; 5b94

loc_0x005B95:
	
	LD SC,#40h ; 5b95

	PUSH ALE ; 5b97
	CARL minlib_reset_audio_registers ; 5b99
	POP ALE ; 5b9c

	LD [BR:PRC_MODE],#06h ; 5b9e

	LD A,#00h ; 5ba1
	INT [7Eh] ; 5ba3

	LD [BR:PRC_MAP_LO],#@LOW(tilemap) ; 5ba5
	LD [BR:PRC_MAP_MID],#@HIGH(tilemap) ; 5ba8
	LD [BR:PRC_MAP_HI],#00h ; 5bab

	XOR A,A ; 5bae
	LD [BR:PRC_SCROLL_Y],A ; 5baf
	LD [BR:PRC_SCROLL_X],A ; 5bb1

	LD BA,[1E78h] ; 5bb3
	ADD BA,#0180h ; 5bb6

	LD [BR:PRC_SPR_LO],A ; 5bb9
	LD [BR:PRC_SPR_MID],B ; 5bbb
	LD [BR:PRC_SPR_HI],#00h ; 5bbd

	LD IX,#tilemap ; 5bc0

	XOR A,A ; 5bc3

loc_0x005BC4:

	LD [IX],A ; 5bc4

	INC IX ; 5bc5

	CP IX,#tilemap + 60h ; 5bc6
	JRS NZ,loc_0x005BC4 ; 5bc9

	PUSH ALE ; 5bcb
	CARL loc_0x0042CB ; 5bcd

	OR A,A ; 5bd0
	JRS NZ,loc_0x005C01 ; 5bd1

	LD EP,#00h ; 5bd3
	LD BR,#20h ; 5bd6

	LD IX,#1FF5h ; 5bd8
	CARL loc_0x00420C ; 5bdb
	JRS NZ,loc_0x005C01 ; 5bde

	CP B,#12h ; 5be0
	JRS NC,loc_0x005BE9 ; 5be3

	LD B,#12h ; 5be5
	JRS loc_0x005BF0

; ---------------------- ; 5be7
loc_0x005BE9:

	CP B,#2Eh ; 5be9
	JRS C,loc_0x005C03 ; 5bec

	LD B,#2Dh ; 5bee

loc_0x005BF0:

	LD EP,#00h ; 5bf0
	LD BR,#20h ; 5bf3

	LD IX,#1FF5h ; 5bf5

	PUSH B ; 5bf8
	CARL loc_0x00421C ; 5bfa
	POP B ; 5bfd

	JRS loc_0x005C03

; ---------------------- ; 5bff
loc_0x005C01:

	LD B,#1Fh ; 5c01

loc_0x005C03:

	LD A,B ; 5c03

	LD EP,#00h ; 5c04
	LD BR,#20h ; 5c07

	LD [1E7Ah],A ; 5c09

	LD HL,#REG_BASE + SYS_CTRL1 ; 5c0d
	LD B,[0096h] ; 5c10
	CP B,#0CEh ; 5c14
	JRS NZ,loc_0x005C22 ; 5c17

	AND A,#3Ch ; 5c19
	AND [HL],#0C3h ; 5c1b
	OR [HL],A ; 5c1e

	JRS loc_0x005C2B

; ---------------------- ; 5c20
loc_0x005C22:

	SLL A ; 5c22
	SLL A ; 5c24
	AND [HL],#03h ; 5c26
	OR [HL],A ; 5c29

loc_0x005C2B:

	CARL loc_0x0046B6 ; 5c2b
	CARL loc_0x004B13 ; 5c2e

	SUB SP,#0003h ; 5c31
	LD YP,#00h ; 5c35
	LD IY,SP ; 5c38
	LD IX,#1FF2h ; 5c3a
	LD HL,#0003h ; 5c3d

	LD EP,#00h ; 5c40
	LD BR,#20h ; 5c43

	CARL loc_0x0040AA ; 5c45

	LD YP,#00h ; 5c48
	LD IY,SP ; 5c4b
	LD B,#00h ; 5c4d
	LD A,[IY+02h] ; 5c4f
	CP A,#03h ; 5c52
	JRS C,loc_0x005C58 ; 5c54

	LD A,#02h ; 5c56

loc_0x005C58:

	SRL A ; 5c58
	RR B ; 5c5a
	SRL A ; 5c5c
	RR B ; 5c5e
	LD A,[IY+01h] ; 5c60
	CP A,#05h ; 5c63
	JRS C,loc_0x005C69 ; 5c65

	LD A,#04h ; 5c67

loc_0x005C69:

	SRL A ; 5c69
	RR B ; 5c6b
	SRL A ; 5c6d
	RR B ; 5c6f
	SRL A ; 5c71
	RR B ; 5c73
	LD A,[IY] ; 5c75
	CP A,#02h ; 5c76
	JRS C,loc_0x005C7C ; 5c78

	LD A,#01h ; 5c7a

loc_0x005C7C:

	SRL A ; 5c7c
	RR B ; 5c7e
	SRL B ; 5c80
	SRL B ; 5c82

	LD EP,#00h ; 5c84
	LD [1E7Fh],B ; 5c87

	ADD SP,#0003h ; 5c8b
	POP ALE ; 5c8f

	OR [BR:PRC_MODE],#08h ; 5c91

	CARL loc_0x005DAB ; 5c94

	XOR A,A ; 5c97
	LD B,#18h ; 5c98
	CARL loc_0x005DC7 ; 5c9a

	LD A,[1E7Dh] ; 5c9d
	BIT A,#04h ; 5ca1
	JRS Z,loc_0x005CB7 ; 5ca3

	LD A,YP ; 5ca5
	LD [mn_sfx_page],A ; 5ca7

	LD BA,#minlib_startup_audio_data ; 5cab
	LD [mn_sfx_index],BA ; 5cae

	LD A,#0FFh ; 5cb1
	LD [mn_pending_sfx],A ; 5cb3

loc_0x005CB7:

	XOR A,A ; 5cb7
	LD [1E7Bh],A ; 5cb8

loc_0x005CBC:

	CARL loc_0x005DF0 ; 5cbc

	LD A,[1E7Bh] ; 5cbf
	CP A,#0Ch ; 5cc3
	JRS NC,loc_0x005CD0 ; 5cc5

	LD B,#00h ; 5cc7
	CARL loc_0x005E0F ; 5cc9

	ADD A,#1Ah ; 5ccc
	JRS loc_0x005CD2

; ---------------------- ; 5cce
loc_0x005CD0:

	LD A,#1Ah ; 5cd0

loc_0x005CD2:

	LD B,A ; 5cd2
	LD A,#02h ; 5cd3

	PUSH B ; 5cd5
	CARL loc_0x005DD3 ; 5cd7
	POP A ; 5cda

	ADD A,#10h ; 5cdc
	LD B,A ; 5cde
	LD A,#03h ; 5cdf
	CARL loc_0x005DD3 ; 5ce1

	LD A,[1E7Bh] ; 5ce4
	CP A,#05h ; 5ce8
	JRS C,loc_0x005D01 ; 5cea

	CP A,#11h ; 5cec
	JRS NC,loc_0x005CF9 ; 5cee

	LD B,#0FBh ; 5cf0
	CARL loc_0x005E0F ; 5cf2
	ADD A,#30h ; 5cf5
	JRS loc_0x005CFB

; ---------------------- ; 5cf7
loc_0x005CF9:

	LD A,#30h ; 5cf9

loc_0x005CFB:

	LD B,A ; 5cfb
	LD A,#01h ; 5cfc
	CARL loc_0x005DD3 ; 5cfe

loc_0x005D01:

	LD A,[1E7Bh] ; 5d01
	CP A,#0Ah ; 5d05
	JRS C,loc_0x005D1E ; 5d07

	CP A,#16h ; 5d09
	JRS NC,loc_0x005D16 ; 5d0b

	LD B,#0F6h ; 5d0d
	CARL loc_0x005E0F ; 5d0f

	ADD A,#3Eh ; 5d12
	JRS loc_0x005D18

; ---------------------- ; 5d14
loc_0x005D16:

	LD A,#3Eh ; 5d16

loc_0x005D18:

	LD B,A ; 5d18
	LD A,#00h ; 5d19
	CARL loc_0x005DD3 ; 5d1b

loc_0x005D1E:

	LD A,[1E7Bh] ; 5d1e
	INC A ; 5d22
	LD [1E7Bh],A ; 5d23
	CP A,#28h ; 5d27
	JRL C,loc_0x005CBC ; 5d29

	CARL loc_0x005D94 ; 5d2c
	CARL loc_0x005DAB ; 5d2f
	CARL loc_0x005DF0 ; 5d32
	CARL loc_0x005E4A ; 5d35

	AND [BR:PRC_MODE],#0F7h ; 5d38

	LD A,#03h ; 5d3b
	INT [7Eh] ; 5d3d
	XOR A,A ; 5d3f

	LD [BR:PRC_MODE],A ; 5d40
	LD [BR:PRC_MAP_LO],A ; 5d42
	LD [BR:PRC_MAP_MID],A ; 5d44
	LD [BR:PRC_MAP_HI],A ; 5d46
	LD [BR:PRC_SCROLL_Y],A ; 5d48
	LD [BR:PRC_SCROLL_X],A ; 5d4a
	LD [BR:PRC_SPR_LO],A ; 5d4c
	LD [BR:PRC_SPR_MID],A ; 5d4e
	LD [BR:PRC_SPR_HI],A ; 5d50

	PUSH ALE ; 5d52
	CARL loc_0x0046A4 ; 5d54
	POP ALE ; 5d57

	LD H,[1E7Dh] ; 5d59
	LD L,[1E7Eh] ; 5d5d
	LD IY,HL ; 5d61
	LD H,[1E7Fh] ; 5d63
	LD IX,#sprite_oam ; 5d67
	XOR A,A ; 5d6a

loc_0x005D6B:

	LD [IX],A ; 5d6b
	INC IX ; 5d6c
	CP IX,#sprite_oam + 60h ; 5d6d
	JRS NZ,loc_0x005D6B ; 5d70

	LD IX,#1539h ; 5d72
	XOR A,A ; 5d75

loc_0x005D76:

	LD [IX],A ; 5d76
	INC IX ; 5d77
	CP IX,#1E80h ; 5d78
	JRS NZ,loc_0x005D76 ; 5d7b

	LD BA,IY ; 5d7d
	LD YP,#00h ; 5d7f
	LD XP,#00h ; 5d82
	LD IX,#0000h ; 5d85
	LD IY,IX ; 5d88

	LD EP,#00h ; 5d8a
	LD BR,#00h ; 5d8d
	LD L,#00h ; 5d8f
	LD SC,#80h ; 5d91

	RET

; ---------------------- ; 5d93
loc_0x005D94:

	LD A,[1E7Ah] ; 5d94

loc_0x005D98:

	LD [BR:0FEh],#81h ; 5d98
	LD [BR:0FEh],A ; 5d9b

	OR A,A ; 5d9d
	JRS Z,loc_0x005DAA ; 5d9e

	CARL loc_0x005DF0 ; 5da0

	SUB A,#04h ; 5da3
	JRS NC,loc_0x005DA8 ; 5da5

	XOR A,A ; 5da7

loc_0x005DA8:

	JRS loc_0x005D98

; ---------------------- ; 5da8
loc_0x005DAA:

	RET

; ---------------------- ; 5daa
loc_0x005DAB:

	LD B,#00h ; 5dab
	LD A,#10h ; 5dad
	LD IX,#sprite_oam ; 5daf

loc_0x005DB2:

	LD [IX],A ; 5db2
	LD [IX+03h],B ; 5db3

	ADD IX,#0004h ; 5db6
	ADD A,#10h ; 5db9
	CP A,#70h ; 5dbb
	JRS NZ,loc_0x005DC1 ; 5dbd

	LD A,#10h ; 5dbf

loc_0x005DC1:

	CP IX,#sprite_oam + 60h ; 5dc1
	JRS NZ,loc_0x005DB2 ; 5dc4

	RET

; ---------------------- ; 5dc6
loc_0x005DC7:
	LD IX,#sprite_oam + 2 ; 5dc7

loc_0x005DCA:

	LD [IX],A ; 5dca
	ADD IX,#0004h ; 5dcb
	INC A ; 5dce
	CP A,B ; 5dcf
	JRS NZ,loc_0x005DCA ; 5dd0

	RET

; ---------------------- ; 5dd2
loc_0x005DD3:

	LD L,#18h ; 5dd3
	MLT ; 5dd5
	CP B,#50h ; 5dd7
	JRS NC,loc_0x005DEF ; 5dda

	LD IX,#sprite_oam + 1 ; 5ddc
	ADD IX,HL ; 5ddf
	LD A,B ; 5de1
	LD B,#06h ; 5de2
	LD L,#08h ; 5de4

loc_0x005DE6:

	LD [IX],A ; 5de6
	LD [IX+02h],L ; 5de7

	ADD IX,#0004h ; 5dea
	DJR NZ,loc_0x005DE6 ; 5ded

loc_0x005DEF:

	RET

; ---------------------- ; 5def
loc_0x005DF0:

	PUSH BA ; 5df0

	LD [BR:27h],#80h ; 5df1

loc_0x005DF4:

	BIT [BR:27h],#80h ; 5df4
	JRS Z,loc_0x005DF4 ; 5df7

	LD B,[BR:KEY_PAD] ; 5df9
	CPL B ; 5dfb
	LD A,[1E7Ch] ; 5dfd
	LD [1E7Ch],B ; 5e01

	XOR A,B ; 5e05
	AND A,B ; 5e06
	BIT A,#80h ; 5e07
	JRS Z,loc_0x005E0D ; 5e09

	INT [48h] ; 5e0b

loc_0x005E0D:

	POP BA ; 5e0d

	RET

; ---------------------- ; 5e0e
loc_0x005E0F:

	ADD A,B ; 5e0f
	LD B,#00h ; 5e10
	LD IY,#minlib_startup_anim_data ; 5e12
	ADD IY,BA ; 5e15
	LD A,[IY] ; 5e17

	LD L,#7Fh ; 5e18
	MLT ; 5e1a
	LD B,H ; 5e1c
	LD A,#7Fh ; 5e1d
	SUB A,B ; 5e1f

	RET

; ---------------------- ; 5e20
loc_0x005E21:

	LD IX,[1E78h] ; 5e21

loc_0x005E24:

	LD A,[IY] ; 5e24
	INC IY ; 5e25
	CP A,#0F5h ; 5e26
	JRS NZ,loc_0x005E34 ; 5e28

	LD B,[IY] ; 5e2a
	INC IY ; 5e2b
	INC B ; 5e2c
	XOR A,A ; 5e2d

loc_0x005E2E:

	LD [IX],A ; 5e2e

	INC IX ; 5e2f
	DJR NZ,loc_0x005E2E ; 5e30

	JRS loc_0x005E45

; ---------------------- ; 5e32
loc_0x005E34:

	CP A,#0F6h ; 5e34
	JRS NZ,loc_0x005E43 ; 5e36

	LD A,[IY] ; 5e38
	INC IY ; 5e39
	LD B,[IY] ; 5e3a
	INC IY ; 5e3b
	INC B ; 5e3c

loc_0x005E3D:

	LD [IX],A ; 5e3d
	INC IX ; 5e3e
	DJR NZ,loc_0x005E3D ; 5e3f

	JRS loc_0x005E45

; ---------------------- ; 5e41
loc_0x005E43:

	LD [IX],A ; 5e43
	INC IX ; 5e44

loc_0x005E45:

	CP HL,IY ; 5e45
	JRS NZ,loc_0x005E24 ; 5e47

	RET

; ---------------------- ; 5e49
loc_0x005E4A:

	LD B,#00h ; 5e4a

	AND [BR:SYS_CTRL3],#0DFh ; 5e4c

	AND [BR:19h],#0CFh ; 5e4f

	LD [BR:23h],B ; 5e52
	AND [BR:24h],#0C3h ; 5e54
	LD [BR:25h],B ; 5e57
	LD [BR:26h],B ; 5e59

	OR [BR:IO_DIR],#0Ch ; 5e5b
	AND [BR:IO_DATA],#0FBh ; 5e5e
	OR [BR:IO_DATA],#08h ; 5e61
	OR [BR:IO_DATA],#04h ; 5e64
	LD [BR:IO_DATA],#20h ; 5e67
	LD [BR:IO_DIR],#32h ; 5e6a

	AND [BR:71h],#0FCh ; 5e6d

	RET

; ---------------------- ; 5e70
loc_0x005E71:
	CARL loc_0x005E7C ; 5e71
	CP A,#00h ; 5e74
	JRS NZ,loc_0x005E71 ; 5e76
	AND [BR:PRC_MODE],#0F7h ; 5e78
	RET
; ---------------------- ; 5e7b
loc_0x005E7C:
	LD BR,#20h ; 5e7c
	LD A,[BR:PRC_RATE] ; 5e7e
	RR A ; 5e80
	AND A,#07h ; 5e82
	LD H,#00h ; 5e84
	LD L,A ; 5e86
	ADD HL,#minlib_prc_rate_lookup_unknown ; 5e87
	PUSH EP ; 5e8a
	LD EP,#00h ; 5e8b
	LD B,[HL] ; 5e8e
	POP EP ; 5e8f
	LD A,[BR:PRC_RATE] ; 5e90
	AND A,#0F0h ; 5e92
	CP A,B ; 5e94
	JRS NZ,loc_0x005EB2 ; 5e95
	BIT [BR:PRC_MODE],#08h ; 5e97
	JRS Z,loc_0x005EB2 ; 5e9a
	BIT [BR:PRC_MODE],#06h ; 5e9c
	JRS Z,loc_0x005EA8 ; 5e9f
	CP [BR:PRC_CNT],#16h ; 5ea1
	JRS NC,loc_0x005EAF ; 5ea4
	JRS loc_0x005EB2
; ---------------------- ; 5ea6
loc_0x005EA8:
	CP [BR:PRC_CNT],#37h ; 5ea8
	JRS NC,loc_0x005EAF ; 5eab
	JRS loc_0x005EB2
; ---------------------- ; 5ead
loc_0x005EAF:
	LD A,#01h ; 5eaf
	RET
; ---------------------- ; 5eb1
loc_0x005EB2:
	LD A,#00h ; 5eb2
	RET
; ---------------------- ; 5eb4

minlib_prc_rate_lookup_unknown:
	DB 20h ; 5eb5
	ASCII "P" ; 5eb6
	DB 80h, 0B0h, 10h ; 5eb7
	ASCII "0Pp" ; 5eba

    include "src/splash.asm"

minlib_startup_audio_data:
    DB 00h
	DB 10h, 80h, 07h, 0C0h, 03h, 03h, 04h, 0E8h ; 6124
	DB 0Bh, 0F4h, 05h, 01h, 04h, 0E8h, 0Bh, 0F4h ; 612c
	DB 05h, 03h, 04h, 0ECh, 08h ; 6134
	ASCII "v" ; 6139
	DB 04h, 01h, 04h, 0ECh, 08h ; 613a
	ASCII "v" ; 613f
	DB 04h, 00h, 08h, 9Ch, 08h ; 6140
	ASCII "v" ; 6145
	DB 04h, 03h, 04h, 0AEh, 06h ; 6146
	ASCII "W" ; 614b
	DB 03h, 01h, 04h, 0AEh, 06h ; 614c
	ASCII "W" ; 6151
	DB 03h, 03h, 04h, 16h, 07h, 8Bh, 03h, 01h ; 6152
	DB 04h, 16h, 07h, 8Bh, 03h, 03h, 04h, 0ECh ; 615a
	DB 08h ; 6162
	ASCII "v" ; 6163
	DB 04h, 01h, 04h, 0ECh, 08h ; 6164
	ASCII "v" ; 6169
	DB 04h, 03h, 04h, 0F4h, 05h, 0FAh, 02h, 01h ; 616a
	DB 04h, 0F4h, 05h, 0FAh, 02h, 00h, 18h, 0C0h ; 6172
	DB 05h, 0DFh, 02h, 03h, 03h, 0AEh, 06h ; 617a
	ASCII "W" ; 6181
	DB 03h, 03h, 03h ; 6182
	ASCII "v" ; 6185
	DB 04h, 3Bh, 02h, 03h, 03h, 0FAh, 02h, 7Dh ; 6186
	DB 01h, 03h, 03h, 0F6h, 01h, 0FBh, 00h, 01h ; 618e
	DB 03h, 0FAh, 02h, 7Dh, 01h, 01h, 03h, 0F6h ; 6196
	DB 01h, 0FBh, 00h, 0FFh ; 619e
    
minlib_startup_anim_data:
	ASCII "ax" ; 61a2
	DB 8Eh, 0A2h, 0B5h, 0C5h, 0D4h, 0E1h, 0ECh, 0F4h ; 61a4
	DB 0FBh, 0FEh ; 61ac
	ASCIZ "MINLIB VERSION 1.35" ; 61ae