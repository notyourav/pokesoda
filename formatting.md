# Disasm formatting guidelines
This document is not designed to be definitive, but to assist me with consistency (I have bad memory).

## Routine header format
```arm
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; 0x000000 - Routine description
;   Args:
;     A: description of register use
;    IY: Another description
;   Returns:
;    SC: Description of return value
;   Clobbers:
;    IX, XP 
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
```
Only the first line is required. Clobbers are low priority.

## Symbol naming
Snake case, equates are capitalized.

General -> specific

EX: `MUDKIP_STATE_JUMP` or `gfx_toybox_feather`

## Line grouping

* Sorted by priority, descending
    * Routine labels have whitespace below
    * Local labels sit between whitespace
    * Last instruction sits between whitespace
    * Group `PUSH`, `POP` instructions
    * Group register swaps
    * Group `LD` with adjacent arithmetics performed on it
    * Group consecutive `LD` instructions for registers used more than once
    * Group Arguments with call or jump
    * Group `LD r, __`, `CP`, `JRS`
    * Group consecutive `JRS` condition checks
    * Group arithmetic operations
