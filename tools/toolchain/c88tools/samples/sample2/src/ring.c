//========================================================================
//====  ring buffer	  ====================================================
//========================================================================
extern unsigned char g_keybuffer[10];

//========================================================================
//====  set data 	  ====================================================
//========================================================================
unsigned char* ring_setkey(unsigned char* key,unsigned char *pnext)
{
	*pnext=*key;
	pnext++;
	if(g_keybuffer+sizeof(g_keybuffer)==pnext)
		pnext=g_keybuffer;

	return pnext;
}

//========================================================================
//====  get data 	  ====================================================
//========================================================================
unsigned char* ring_getkey(unsigned char* key,unsigned char *pnow)
{
	*key=*pnow;
	pnow++;
	if(g_keybuffer+sizeof(g_keybuffer)==pnow)
		pnow=g_keybuffer;

	return pnow;
}
