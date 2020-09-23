---------------------
Diagnostic procedure                                                  Apr. 25 2001  Ver.1.01
---------------------

Check using the VDC0-2,OSCC,MODE,SVDON,HVLD,LCDC,LCD4.5V,LCD5.5V and EXLCD LEDs on the
PERIPHERAL CIRCUIT BOARD. If the below light statuses are verified following system reset,
it is normal.
The cycle count indicates a 1 second interval and the light status of the below LED ch-
anges every second. When it returns to 1 after 20, it then repeats the cycle again.

o:ON(lit)  -:OFF(not lit)  x:Blinking 
+-----------+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|Cycle count| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10| 11| 12| 13| 14| 15| 16| 17| 18| 19| 20|
+-----------+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| VDC0      | - | o | - | - | - | o | - | - | - | o | - | - | - | o | - | - | - | o | - | - |
| VDC1      | o | - | o | - | o | - | o | - | o | - | o | - | o | - | o | - | o | - | o | - |
| VDC2      | - | - | - | o | - | - | - | o | - | - | - | o | - | - | - | o | - | - | - | o |
| OSCC      | - | - | - | o | - | - | - | o | - | - | - | o | - | - | - | o | - | - | - | o |
| MODE      | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - |
| SVDON     | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x | x |
| HVLD      | - | x | - | o | - | x | - | o | - | x | - | o | - | x | - | o | - | x | - | o |
| LCDC      | o | o | o | o | o | o | o | o | o | o | o | o | o | o | o | o | o | o | - | o |
| LCD4.5V   | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - |
| LCD5.5V   | o | o | o | o | o | o | o | o | o | o | o | o | o | o | o | o | o | o | o | o |
| EXLCD     | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - |
+-----------+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
