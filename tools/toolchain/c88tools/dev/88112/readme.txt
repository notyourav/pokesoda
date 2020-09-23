---------------------
Diagnostic procedure                                                  Jun. 6 2001  Ver.1.00
---------------------

Check using the VDC0-2,OSCC,LCDC,CMP0ON,CMP1ON,SVDON and HVLD LEDs on the Peripheral Circuit
Board. If the below light statuses are verified following system reset, it is normal. 
The cycle count indicates a 1 second interval and the light status of the below LED changes
every second. When it returns to 1 after 20, it then repeats the cycle again.

o:ON(lit)  -:OFF(not lit)  x:Brinking 
+-----------+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|Cycle count| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10| 11| 12| 13| 14| 15| 16| 17| 18| 19| 20|
+-----------+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| VDC0      | - | o | - | - | - | o | - | - | - | o | - | - | - | o | - | - | - | o | - | - |
| VDC1      | o | - | o | - | o | - | o | - | o | - | o | - | o | - | o | - | o | - | o | - |
| VDC2      | - | - | - | o | - | - | - | o | - | - | - | o | - | - | - | o | - | - | - | o |
| OSCC      | - | - | - | o | - | - | - | o | - | - | - | o | - | - | - | o | - | - | - | o |
| LCDC      | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - |
| CMP0ON    | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x |
| CMP1ON    | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x |
| SVDON     | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x |
| HVLD      | - | x | - | o | - | x | - | o | - | x | - | o | - | x | - | o | - | x | - | o |
+-----------+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
Note: HVLD x shows that the LED lights after blinking.