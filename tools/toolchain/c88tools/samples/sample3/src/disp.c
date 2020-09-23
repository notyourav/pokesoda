/*** include header files ***/
#include	"ascifont.h"
/*** definition constant ***/
#define	VramStt			0xf800					//display start memory
#define	VramXmax		0x32					//X display memory max size
#define	VramYstep		0x100					//Y step memory size
#define	AscSizeX		6						//ASCII DATA X size
#define	AscPosiMaxX		VramXmax-AscSizeX+1
#define	AscPosiMaxY		3						//COM count
#define	NULL			0

/*** function prototype ***/
unsigned char disp_charY8(char x, char y, int charac);
void _interrupt(0x20) rtclock (void);
void clear_vram(void);
void display(void);
/*** SFR definition ***/
_sfrbyte	sfr_lcd1		_at(0xff10);
_sfrbyte	sfr_lcd2		_at(0xff11);
_sfrbyte	sfr_intpri1		_at(0xff20);
_sfrbyte	sfr_intena1		_at(0xff22);
_sfrbyte	sfr_intfnc1		_at(0xff24);
_sfrbyte	sfr_intfunc2	_at(0xff25);
_sfrbyte	sfr_wchtmr1		_at(0xff40);
_sfrbyte	sfr_r2xd		_at(0xff75);

/*** global variable ***/
unsigned char g_posX;		//display count
int g_offset;				//display data offset
//========================================================================
//====  main routine  ====================================================
//========================================================================
int main(void) {
	//*** variable definition ***
	

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
	sfr_intena1 |= 0x02;			// 8Hz interrupt enable
	sfr_wchtmr1 |= 0x01;			// run clock timer
	
	//-------------------  clear MCU Vram  --------------------------------
	clear_vram();
	//-------------------  initial global variable	-----------------------
	g_posX=0;
	g_offset=0;

	// <all interrupt enable>
	#pragma asm
		AND SC,#00111111b				; all interrupt enable
	#pragma endasm

	//---------------------  Main Loop  ----------------------------------
	do 
	{
		//<reset WDT>
		sfr_wchtmr1 |= 0x04;
		//<Halt>
		_halt();
		//<scroll display>
		display();
	} while(1);
}
//========================================================================
//====  display character (y8bit)  =======================================
//========================================================================
unsigned char disp_charY8(char x, char y, int charac) 
{
	unsigned char *vram;
	unsigned char _far *ascfont;
	unsigned char i = 0, err = 0; 
	

	if ((x <= AscPosiMaxX) && (y <= AscPosiMaxY) )
	{
		vram = (unsigned char *)(VramStt + x + y * VramYstep);
		ascfont = (unsigned char _far *)(AsciiFontTbl + charac );
		for (i=0 ; i < AscFontStp ; i++)
		{
			*(vram++) = *(ascfont++);
		}
	}
	else 
	{
		err = 1;
	}
	return (err);
}
//========================================================================
//====  <2Hz clock interrupt> clock  =====================================
//========================================================================
void _interrupt(0x20) rtclock (void) {
	//------------------  reset interrupt flag  --------------------------
	sfr_intfnc1 = 2;

	//------------------  display data offset inc	----------------------
	g_offset++;
	if(g_offset>AscDataSize)
		g_offset=0;

	//------------------  display count inc			----------------------
	g_posX++;
	if(g_posX>=8)
		g_posX=8;
}
//========================================================================
//====  <Vram Clear>				          ============================
//========================================================================
void clear_vram(void)
{
	unsigned char *vram;
	unsigned char x=0,y=0;
	
	vram = (unsigned char *) VramStt;
	//-------------------  clear MCU Vram  --------------------------------
	do
	{
		do
		{
        	*(vram + x) = 0;
		} while ((x++) <= VramXmax);
		vram += VramYstep;
		x = 0;
		y++;
	} while (y < 4);
}
//========================================================================
//====  <Scroll Data Display>		          ============================
//========================================================================
void display(void)
{
	unsigned char ci,posx,x=0;
	int	charp,offset;
	
	posx=g_posX;									//move global variable
	offset=g_offset;
	for(ci=0;ci<posx;ci++)							//posx==display ascii count
	{
		x = (7-ci)*AscSizeX;						//x position

		//------------  display data offset set	--------------------------
		if((offset-ci)<0)
			charp=(AscDataSize+(offset-ci)+1)*AscFontStp;
		else
			charp=(offset-ci)*AscFontStp;
		//------------	display				------------------------------
		if(disp_charY8(x,0,charp)==1)
			break;
	}
}