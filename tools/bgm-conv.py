import sys

if len(sys.argv) > 1:
    filename = sys.argv[1]
else:
    filename = "bgm.bin"

with open(filename, "rb") as file:
    f = bytearray(file.read())

lookup = {
    0x49: "NOTE_REST",
    
    0x80: "LENGTH 0",
    0x81: "LENGTH 1",
    0x82: "LENGTH 2",
    0x83: "LENGTH 3",
    0x84: "LENGTH 4",
    0x85: "LENGTH 5",
    0x86: "LENGTH 6",
    0x87: "LENGTH 7",
    0x88: "LENGTH 8",
    
    0x90: "EFFECT 0",
    0x91: "EFFECT 1",
    0x92: "EFFECT 2",
    0x93: "EFFECT 3",
    0x94: "EFFECT 4",
    0x95: "EFFECT 5",
    0x96: "EFFECT 6",
    0x97: "EFFECT 7",
    0x98: "EFFECT 8",
    0x99: "EFFECT 9",
    0x9A: "EFFECT 10",
    
    0xA0: "UNK_EFFECT 0",
    0xA1: "UNK_EFFECT 1",
    0xA2: "UNK_EFFECT 2",
    0xA3: "UNK_EFFECT 3",
    0xA4: "UNK_EFFECT 4",
    0xA5: "UNK_EFFECT 5",
    0xA6: "UNK_EFFECT 6",
    0xA7: "UNK_EFFECT 7",
    0xA8: "UNK_EFFECT 8",
    0xA9: "UNK_EFFECT 9",
    0xAA: "UNK_EFFECT 10",
    0xAB: "UNK_EFFECT 11",
    0xAC: "UNK_EFFECT 12",
    0xAD: "UNK_EFFECT 13",
    0xAE: "UNK_EFFECT 14",
    0xAF: "UNK_EFFECT 15",
    
    0xB0: "TEMPO 0",
    0xB1: "TEMPO 1",
    0xB2: "TEMPO 2",
    0xB3: "TEMPO 3",
    0xB4: "TEMPO 4",
    0xB5: "TEMPO 5",
    0xB6: "TEMPO 6",
    0xB7: "TEMPO 7",
    0xB8: "TEMPO 8",
    
    0xC0: "DUTY 0",
    0xC1: "DUTY 1",
    0xC2: "DUTY 2",
    0xC3: "DUTY 3",
    0xC4: "DUTY 4",
    0xC5: "DUTY 5",
    
    0xF0: "SONG_END",
    0xF1: "LOOP_START",
    0xF2: "LOOP_END",
    
}

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

for i in range(0x49):
    lookup[i] = f"NOTE_{notes[i % len(notes)] + str(i // len(notes) + 2)}"

with open(filename.replace(".bin", ".asm"), "w") as g:

    for i in f:
        g.write("\t" + lookup[i] + "\n")
    