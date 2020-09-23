
/*** include header files ***/
#include 	<string.h>
#include	<stdlib.h>
#include	"ascifont.h"

/*** definition constant ***/
#define	VramStt			0xf800					//display start memory
#define	VramXmax		0x32					//X display memory max size
#define	VramYstep		0x100					//Y step memory size
#define	AscSizeX		6						//ASCII SIZE
#define	AscPosiMaxX		VramXmax-AscSizeX+1		//X Max Count
#define	AscPosiMaxY		3						//Y Max Count
#define	NULL			0

/*** function prototype ***/
unsigned char disp_stringY8(char x, char y, unsigned char *string);
unsigned char disp_charY8(char x, char y, unsigned char charac);
void set_reg(void);
void _interrupt(0x22) rtclock (void);
void _interrupt(0x0e) rtkeyscan(void);
/*** SFR definition ***/
_sfrbyte	sfr_lcd1	_at(0xff10);
_sfrbyte	sfr_lcd2	_at(0xff11);
_sfrbyte	sfr_intpri1	_at(0xff20);
_sfrbyte	sfr_intena1	_at(0xff22);
_sfrbyte	sfr_intena2	_at(0xff23);
_sfrbyte	sfr_intfnc1	_at(0xff24);
_sfrbyte	sfr_intfnc2	_at(0xff25);
_sfrbyte	sfr_wchtmr1	_at(0xff40);
_sfrbyte	sfr_sik1	_at(0xff50);
_sfrbyte	sfr_kcp1	_at(0xff52);
_sfrbyte	sfr_kd1		_at(0xff54);
_sfrbyte	sfr_r27		_at(0xff75);
_sfrbyte	sfr_r2xd	_at(0xff75);

/*** global variable ***/
char*	p_clkdata;
unsigned char g_intflg;					//BIT 2 	1 	 0		interrupt:1
										//	  reset stop start

//========================================================================
//====  main routine  ====================================================
//========================================================================
int main(void) {
	//*** variable definition ***
	unsigned char *vram;
	unsigned char x=0,y=0,err=0;

	vram = (unsigned char *) VramStt;

	//----------------------  set I/O register  ---------------------------
	// <display>
	sfr_lcd1 = 0x00;				/* 5 x 8 dot font
									   1/32 duty */
	sfr_lcd2 = 0x17;				/* area 0
									   normal display
									   initial contrast = 7 */
	/*<clock>*/
	sfr_intpri1 |= 0x03;			// set interrupt priority 3
	sfr_wchtmr1 |= 0x02;			// reset clock timer
	sfr_intena1 |= 0x01;			// 1Hz interrupt enable
	sfr_wchtmr1 |= 0x01;			// run clock timer
	/*<Key>*/
	sfr_r27=0x7f;					// R27 0 OUTPUT
	sfr_intpri1 |= 0xc0;			// set interrupt priority 3
	sfr_intena2	|=0x08;				// K00Å`K03 interrupt enable
	sfr_sik1=0x07;					// K00Å`K02 interrupt enable
	sfr_kcp1=0xff;					// interrupt select reg

	//-------------------  clear MCU Vram  --------------------------------
	do {
		do {
        	*(vram + x) = 0;
		} while ((x++) <= VramXmax);

		vram += VramYstep;
		x = 0;
		y++;
	} while (y < 4);

	p_clkdata=(char*)malloc(10);
	strcpy((char*)p_clkdata,"00:00:00");
	// <all interrupt enable>
	#pragma asm
		AND SC,#00111111b				; all interrupt enable
	#pragma endasm
	//flag clear
	g_intflg=0;
	//---------------------  Main Loop  ----------------------------------
	do {
		//<reset WDT>
		sfr_wchtmr1 |= 0x04;
		//<Halt>
		_halt();
		//<check K0x port input>
		set_reg();
		//<display clock data>
		err = disp_stringY8(0,0,(unsigned char *)p_clkdata);
	} while(1);
//    free((char*)p_clkdata);
}
//========================================================================
//====  display string (y8bit)  ==========================================
//========================================================================
unsigned char disp_stringY8(char x, char y, unsigned char *string) {
	unsigned char err = 0; 

	while ((*string != NULL) || err !=0) {
		err = disp_charY8(x,y,*string);
		string ++;
		x += AscSizeX;
	}

	return (err);

}
//========================================================================
//====  display character (y8bit)  =======================================
//========================================================================
unsigned char disp_charY8(char x, char y, unsigned char charac) {
	unsigned char *vram, *ascfont;
	unsigned char i = 0, err = 0; 

	charac -= AscCodeMin;

	if ((x <= AscPosiMaxX) && (y <= AscPosiMaxY) && (charac <= AscCodeMax)){
		vram = (unsigned char *)(VramStt + x + y * VramYstep);
		ascfont = (unsigned char *)(AsciiFontTbl + charac * AscFontStp);

		for (i=0 ; i < AscFontStp ; i++){
			*(vram++) = *(ascfont++);
		}
	}
	else {
		err = 1;
	}

	return (err);

}
//========================================================================
//====  <1Hz clock interrupt> clock  =====================================
//========================================================================
void _interrupt(0x22) rtclock (void) {
	char*	pdata;
	//------------------  reset interrupt flag  --------------------------
	sfr_intfnc1 = 1;

	//------------------  second increment  ------------------------------
    pdata=p_clkdata;
	if ((*(pdata+7)+=1) > 0x39) 
	{
		*(pdata+7) = 0x30;
		if ((*(pdata+6)+=1) > 0x35) 
		{
			*(pdata+6) = 0x30;
			if ((*(pdata+4)+=1) > 0x39) 
			{
				*(pdata+4)= 0x30;
				if ((*(pdata+3)+=1) > 0x35) 
				{
					*(pdata+3)= 0x30;
					if ((*(pdata+1)+=1) > 0x34) 
					{
						*(pdata+1) = 0x30;
						if ((*pdata+=1) > 0x32) 
						{
							*pdata = 0x30;
						}
					}
				}
			}
		}
	}
}
//========================================================================
//====  <Key input interrupt>        =====================================
//========================================================================
void _interrupt(0x0e) rtkeyscan(void)
{
	//------------------  reset interrupt flag  --------------------------
	sfr_intfnc2	=0x08;
	
	//------------------  K port read			--------------------------
	if((sfr_kd1 & 0x01)==0x00)				//k00 input
	{
		//--------------  timer start			--------------------------
		if((sfr_wchtmr1 & 0x01)==0x00)
			g_intflg|=0x01;					// flag set
	}
	if((sfr_kd1 & 0x02)==0x00)				// k01 input
	{
		//--------------  timer stop			--------------------------
		if((sfr_wchtmr1 & 0x01)==0x01)
			g_intflg|=0x02;					// flag set
	}
	if((sfr_kd1 & 0x04)==0x00)				// k02 input
	{
		//--------------  timer reset			--------------------------
		g_intflg|=0x04;						// flag set
	}
}
//========================================================================
//====  <regster set>		         =====================================
//========================================================================
void set_reg(void)
{
	unsigned char flag;
	flag=g_intflg;
	//--------------  timer start			--------------------------
	if((flag & 0x01)==0x01)
	{
		sfr_wchtmr1 |= 0x01;				// run clock timer
		sfr_intena1 |= 0x01;				// 1Hz interrupt enable
		g_intflg &= 0xfe;					// flag clear
	}
	//--------------  timer stop			--------------------------
	if((flag & 0x02)==0x02)
	{
		sfr_intena1 &= 0xfe;				// 1Hz interrupt enable
		sfr_wchtmr1 &= 0xfe;				// stop clock timer
		g_intflg &= 0xfd;					// flag clear
	}
	//--------------  timer reset			--------------------------
	if((flag & 0x04)==0x04)
	{
		strcpy( (char*)p_clkdata,"00:00:00");	// data clear
		sfr_wchtmr1 |= 0x02;				// reset clock timer
		g_intflg &= 0xfb;					// flag clear
	}
}