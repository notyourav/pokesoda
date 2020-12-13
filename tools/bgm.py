notes = [
    "C",
    "CSHARP",
    "D",
    "DSHARP",
    "E",
    "F",
    "FSHARP",
    "G",
    "GSHARP",
    "A",
    "ASHARP",
    "B",
]

with open("../src/audio/bgm.inc", "w") as g:
    
    g.write("""DEFINE SONG_END "DB 0F0h"
DEFINE LOOP_START "DB 0F1h"
DEFINE LOOP_END "DB 0F2h"

DUTY MACRO WIDTH
DB (0C0h | WIDTH)
ENDM

TEMPO MACRO TEM
DB (0B0h | TEM)
ENDM

UNK_EFFECT MACRO UNK
DB (0A0h | UNK)
ENDM

EFFECT MACRO EFF
DB (90h | EFF)
ENDM

LENGTH MACRO LEN
DB (080h | LEN)
ENDM

""")
    
    for i in range(0x49):
        g.write(f"DEFINE NOTE_{notes[i % len(notes)] + str(i // len(notes) + 2)} \"DB {hex(i).lstrip('0x').upper().zfill(2)}h\"\n")
    g.write("DEFINE NOTE_REST \"DB 49h\"\n")