DEFSECT ".ram", CODE AT 1000H
SECT ".ram"

global screenbuf
screenbuf: DS 300h

global sprite_oam
sprite_oam: DS 60h

global tilemap
tilemap: DS 0C0h