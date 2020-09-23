/*** include header files ***/
#include	"ascifont.h"
#include 	<stdlib.h>
#include 	<string.h>
#include 	<stdio.h>

/*** definition constant ***/
#define	VramStt			0xf800					//display start memory
#define	VramXmax		0x32					//X display memory max size
#define	VramYstep		0x100					//Y step memory size
#define	AscSizeX		6						//ASCII SIZE
#define	AscPosiMaxX		VramXmax-AscSizeX+1		//X Max Count
#define	AscPosiMaxY		3						//Y Max Count
#define	NULL			0

/*** function prototype ***/
void _interrupt(0x1E) rtclock (void);
unsigned char disp_stringY8(char x, char y, unsigned char *string);
unsigned char disp_charY8(char x, char y, unsigned char charac);
void keyscan(int *key);
void clear_vram(void);
void clear_variable(void);
unsigned char calculate(unsigned char *buffer,unsigned char *answer);
void wait(int time);
void analysis(void);
/*** extern function prototype ***/ 
extern unsigned char* ring_setkey(unsigned char* key,unsigned char *pnext);
extern unsigned char* ring_getkey(unsigned char* key,unsigned char *pnow);

/*** SFR definition ***/
_sfrbyte	sfr_lcd1		_at(0xff10);
_sfrbyte	sfr_lcd2		_at(0xff11);
_sfrbyte	sfr_intpri1		_at(0xff20);
_sfrbyte	sfr_intena1		_at(0xff22);
_sfrbyte	sfr_intfnc1		_at(0xff24);
_sfrbyte	sfr_intfunc2	_at(0xff25);
_sfrbyte	sfr_wchtmr1		_at(0xff40);
_sfrbyte	sfr_k00			_at(0xff54);		//K00Å`K07 PORT
_sfrbyte	sfr_k10			_at(0xff55);		//K10,K11  PORT
_sfrbyte	sfr_p10s		_at(0xff61);
_sfrbyte	sfr_p10			_at(0xff63);		//P10Å`P17 PORT
_sfrbyte	sfr_r2xd		_at(0xff75);

/*** global variable ***/
int oldkey[3]={0xffff,0xffff,0xffff};
unsigned char keyposX;							//display X position
unsigned char keyposY;							//display Y position
unsigned char g_keybuffer[10];					//input key ringbuffer
unsigned char* pNow;							//key display pointer
unsigned char* pNext;							//key input pointer
unsigned char save_data[255];					//keybuffer
unsigned char saveflg;							//keybuffer flag
//========================================================================
//====  main routine  ====================================================
//========================================================================
int main(void) {
	//*** variable definition ***
	

	//----------------------  set I/O register  ---------------------------
	// <display>
	//sfr_r2xd |= 0x60;				// set R25(CL),R26(FR) output data to H
	sfr_lcd1 = 0x0;					/* 5 x 8 dot font
									   1/32 duty */
	sfr_lcd2 = 0x17;				/* area 0
									   normal display
									   initial contrast = 7 */
	/*<clock>*/
	sfr_intpri1 |= 0x03;			// set interrupt priority 3
	sfr_wchtmr1 |= 0x02;			// reset clock timer
	sfr_intena1 |= 0x04;			// 8Hz interrupt enable
	sfr_wchtmr1 |= 0x01;			// run clock timer
	
	sfr_p10s=0xff;					// set output P10Å`P17
	//-------------------  clear MCU Vram  --------------------------------
	clear_vram();
	pNow=pNext=g_keybuffer;

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
		//<display input key>
	 	analysis();
	} while(1);
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
unsigned char disp_charY8(char x, char y, unsigned char charac) 
{
	unsigned char *vram, *ascfont;
	unsigned char i = 0, err = 0; 

	charac -= AscCodeMin;
	if ((x <= AscPosiMaxX) && (y <= AscPosiMaxY) && (charac <= AscCodeMax))
	{
		vram = (unsigned char *)(VramStt + x + y * VramYstep);
		ascfont = (unsigned char *)(AsciiFontTbl + charac * AscFontStp);
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
//====  <8Hz clock interrupt> clock  =====================================
//========================================================================
void _interrupt(0x1E/*0x20*/) rtclock (void) 
{
	const unsigned char keytable[]={'.',' ',' ','4','5','6','7',' ','9',' ',
									'1','2','3','-','=',' ',' ','8',' ','0',
									'*','/','+',' ',' ',' ',' ',' ',' ',' '};
	int keydata[3],old;
	int *key;
	unsigned char cx,cy,cz;
	//------------------  reset interrupt flag  --------------------------
	sfr_intfnc1 = 4;
	//------------------  key scan			    --------------------------
	key=&keydata;
	keyscan(key);

	//------------------  keydata Analysis 	    --------------------------
	for(cx=0;cx<3;cx++)									//P15,P16,P17
	{
		if(oldkey[cx]!=*key)							//last input key is 
		{												//different from the input key
			old=oldkey[cx];
			oldkey[cx]=*key;							//save key
			for(cy=0;cy<10;cy++)						//K00Å`K07,K10,K11
			{
				cz=cx*10+cy;
				if(keytable[cz]!=' ')
				{
					if((*key & 0x01)==0x00				//key push?
								&& (old & 0x01)==0x01)	
						pNext=ring_setkey(				//save push key into ring buffer
								(unsigned char*)&keytable[cz]
								,pNext);
				}
				*key>>=1;								//Next Key
				old>>=1;
			}
		}
		key++;											//Next Port
	}
}
//========================================================================
//====  <Key Scan>					          ============================
//========================================================================
void keyscan(int *key)
{
	//		K00 K01 K02 K03 K04 K05 K06 K07 K10 K11	
	//P15   Esc           4   5   6   7       9		
	//P16     1   2   3   -   =           8       0	
	//P17     *   /   +								

	sfr_p10|=0xff;
	sfr_p10&=0xdf;		//P15 OUTPUT
	*key=sfr_k00;		//key data save
    *key|=(sfr_k10<<8);
	sfr_p10|=0xff;
	key++;
	wait(20);

	sfr_p10&=0xbf;		//R16 OUTPUT
	*key=sfr_k00;		//key data save
    *key|=(sfr_k10<<8);
	sfr_p10|=0xff;
	key++;
	wait(20);

	sfr_p10&=0x7f;		//R17 OUTPUT
	*key=sfr_k00;		//key data save
    *key|=(sfr_k10<<8);
	sfr_p10|=0xff;
}
//========================================================================
//====  <Vram Clear>				          ============================
//========================================================================
void clear_vram(void)
{
	unsigned char *vram;
	unsigned char x=0,y=0;
	
	vram = (unsigned char *) VramStt;
	//-------------------  clear MCU Vram  -------------------------------
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
	//-------------------  clear global variable  ------------------------
	clear_variable();
}
//========================================================================
//====  <Global Variable Clear>		          ============================
//========================================================================
void clear_variable(void)
{
	unsigned char cx;
	keyposX=0;
	keyposY=0;
	for(cx=0;cx<255;cx++)
		save_data[cx]=0;
	saveflg=0;
}
//========================================================================
//====  <calculate>					          ============================
//========================================================================
unsigned char calculate(unsigned char *buffer,unsigned char *answer)
{
	//in	*buffer:input key data 
	//in	*answer:Operation result

	const char	operation[]="+-*/";
	char	delim[16]={0};
	char	*token;
	unsigned char	i,flg=0,cnt=0,err=0;
	int		ans[16]={0},*pbuff;

	//-------------------Operation extraction 		----------------------
	token=strpbrk((char*)buffer, operation );		//seek "+-*/"
	while(token!=NULL  || flg==16)
	{
		token=strpbrk(token,operation);				//next seek "+-*/"
		if(token!=NULL)
		{
			delim[flg]=*token;						//save operation code
			token++;
			flg++;									//input key count(Operation)
		}
	}
	//-------------------Numerical value extraction ----------------------
	token = strtok((char*) buffer, operation );		//seek "+-*/"
	pbuff=&ans[0];
	while( token != NULL)
	{
		if(atol(token)>32767 || atol(token)<-32767)
		{
			err=1;
			return err;								//overflow error
		}
		*pbuff=atoi(token);							//save numerical value
		pbuff++;
		cnt++;
		token = strtok( NULL, operation );			//next seek "+-*/"
	}
	if(flg>=cnt)
		return err=1;
	//-------------------Operation 					 ----------------------
	for(i=0;i<flg;i++)
	{
		switch (delim[i])
		{
			case	'+':
				ans[i+1]=ans[i]+ans[i+1];
				break;
			case	'-':
				ans[i+1]=ans[i]-ans[i+1];
				break;
			case	'*':
				ans[i+1]=ans[i]*ans[i+1];
				break;
			case	'/':
				ans[i+1]=ans[i]/ans[i+1];
				break;
			default:
				ans[i+1]=ans[i];
				break;
		}
	}
	sprintf((char*)answer,"%d",ans[flg]);
	return err;
}
//========================================================================
//====  <input key data analysis>	          ============================
//========================================================================
void analysis(void)
{
	unsigned char x,err,key,answer[8];
	unsigned char* pnext;

	pnext=pNext;
	while (pNow!=pnext)
	{
		pNow=ring_getkey(&key,pNow);		//get input key data
		if(key=='.')						//clear
		{
			//<clear display>
			clear_vram();
		}
		else
		{
			save_data[saveflg]=key;
			saveflg++;
			if(saveflg>sizeof(save_data))	//buffer overflow 
			{
				clear_vram();
				err=disp_stringY8(0,0,(unsigned char*)"err");
				break;
			}
			x =keyposX*AscSizeX;
			//---------<display push key>---------------------
			err = disp_charY8(x,keyposY,key);
			keyposX++;
			//Indication position adjustment.
			if(keyposX>=8)
			{
				keyposY++;
				keyposX=0;
				if(keyposY>=AscPosiMaxY)
					keyposY=0;
			}
			if(key=='=')					//answer
			{
				//------<calcuate>-----------------------------
				err=calculate(&save_data,&answer);
				//------<answer display>-----------------------
				if(err==0)
					disp_stringY8(0,3,&answer);
				else
					err=disp_stringY8(0,3,(unsigned char*)"err");	//over flow
				clear_variable();
			}
		}
	}
}
//========================================================================
//====  <wait>						          ============================
//========================================================================
#pragma asm
    _wait:
		DEC	BA						; 2 cycle
		JRS	NZ,_wait				; 2 cycle
		RET
#pragma endasm

