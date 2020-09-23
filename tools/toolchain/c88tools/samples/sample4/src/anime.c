/*** include header files ***/
#include	"anime.h"
/*** definition constant ***/
#define	VramStt			0xf800		//display start memory
#define	VramXmax		0x32		//X display memory max size
#define	VramYstep		0x100		//Y step memory size
#define	AscPosiMaxY		3			//COM COUNT
#define	NULL			0

/*** function prototype ***/
void _interrupt(0x06) rtpt1 (void);
void clear_vram(void);
void disp_char(unsigned char _far *ascfont) ;
int	 mulx(int ix,int iy);
/*** SFR definition ***/
_sfrbyte	sfr_lcd1		_at(0xff10);
_sfrbyte	sfr_lcd2		_at(0xff11);
_sfrbyte	sfr_intpri1		_at(0xff20);
_sfrbyte	sfr_intena1		_at(0xff22);
_sfrbyte	sfr_intfnc1		_at(0xff24);
_sfrbyte	sfr_intfunc2	_at(0xff25);
_sfrbyte	sfr_wchtmr1		_at(0xff40);
_sfrbyte	sfr_r2xd		_at(0xff75);

_sfrbyte	sfr_ptmode1		_at(0xff30);
_sfrbyte	sfr_ptmode2		_at(0xff31);
_sfrbyte	sfr_ptmode3		_at(0xff32);
_sfrbyte	sfr_reload1		_at(0xff33);
_sfrbyte	sfr_reload2		_at(0xff34);
_sfrbyte	sfr_count1		_at(0xff35);
_sfrbyte	sfr_count2		_at(0xff36);
_sfrbyte	sfr_intpri2		_at(0xff21);
_sfrbyte	sfr_intena2		_at(0xff23);

/*** global variable ***/
unsigned char gflag;
//========================================================================
//====  main routine  ====================================================
//========================================================================
int main(void) {
	//*** variable definition ***
	unsigned char aflag;

	//----------------------  set I/O register  ---------------------------
	// <display>
	sfr_lcd1 = 0x0;				    /*  5 x 8 dot font
									   1/32 duty */
	sfr_lcd2 = 0x17;				/* area 0
									   normal display
									   initial contrast = 7 */
	/*<Programable timer>*/
	sfr_ptmode1=0x13;
	sfr_reload1=0xff;				//timer 0 reload set
	sfr_reload2=0xff;				//timer 1 reload set
	sfr_ptmode2=0x16;
	sfr_intpri2|=0x0c;				//set interrupt priority 3
	sfr_intena2|=0x80;				//interrupt enable
	sfr_ptmode2|=0x01;				//run timer0
	
	//-------------------  clear MCU Vram  --------------------------------
	clear_vram();
	// <all interrupt enable>
	#pragma asm
		AND SC,#00111111b				; all interrupt enable
	#pragma endasm
	//global variable initial
	gflag=0;
	//---------------------  Main Loop  ----------------------------------
	do 
	{
		//<reset WDT>
		sfr_wchtmr1 |= 0x04;
		//<Halt>
		_halt();
		aflag=gflag;					//move global variable
		//------------------  display bitmap	--------------------------
		//mulx(gflag,DATA_SIZE)=aflag*DATA_SIZE
		disp_char((unsigned char _far *)AsciiFontTbl+ mulx(aflag,DATA_SIZE));
	} while(1);
}
//========================================================================
//====  display bitmap (y8bit)  	======================================
//========================================================================
void disp_char(unsigned char _far *ascfont) 
{
	unsigned char *vram;
	unsigned char i,j;
	for(i=0;i<=AscPosiMaxY;i++)
	{
		//mulx(i,VramYstep)=i*VramYstep
		vram = (unsigned char *)(VramStt + mulx(i,VramYstep));
		for (j=0 ; j <= VramXmax ; j++)
			*(vram++) = *(ascfont++);
	}
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
//====  <programable timer interrupt> ====================================
//========================================================================
void _interrupt(0x06) rtpt1 (void)
{
	//------------------  reset interrupt flag  --------------------------
	sfr_intfunc2=0x80;

	//display memory offset Adjustment 
	gflag++;

	if(gflag>=2)
		gflag=0;
}
//========================================================================
//====  <Multiplication (int)>		  ====================================
//========================================================================
int	 mulx(int ix,int iy)
{
	unsigned char i;
	int	ans=0;
	for(i=0;i<ix;i++)
	{
		ans+=iy;
	}
	return ans;
}
