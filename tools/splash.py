from PIL import Image


src = Image.open("src/splash.png").convert("RGBA").tobytes()

sprites = []

for i in range(len(src) // (16 * 16 * 4)):
    sprites.append([])

for i in range(len(src)):
    sprites[((i // (16 * 4)) % 6) + (i // (16 * 16 * 6 * 4)) * 6].append(src[i])

tiles = []

mapping = [0, 4, 1, 5, 2, 6, 3, 7]

for i in sprites:
    data = []
    transp = []
    for j in range(0, len(i), 4):
        data.append(i[j] ^ 0xFF)
        transp.append(i[j + 3] ^ 0xFF)
    
    transp.extend(data)
    column = []
    for j in range(0, len(transp), (8 * 8 * 2)):
        for k in range(2):
            for l in range(8):
                column.extend(transp[j + k * 8 + l * 16:j + k * 8 + l * 16 + 8])
    
    
    this = []
    for j in range(0, len(column), 8 * 8):
        this.append(Image.frombytes("L", (8, 8), bytes(column[j:j + 64])))
    
    toadd = [None, None, None, None, None, None, None, None]
    
    for j in range(8):
        toadd[mapping[j]] = this[j]
    
    tiles.extend(toadd)

h = bytearray()

for i in tiles:
    h.extend(i.transpose(Image.ROTATE_270).convert("1").tobytes())



comp = bytearray()

length = 0

index = 0
while index < len(h):
    length = 0
    while index + length < len(h) and h[index + length] == h[index] and length < 256:
        length += 1
    
    if length > 3 and h[index] != 0:
        comp.extend([0xF6, h[index], length - 1])
        index += length
    elif length > 2 and h[index] == 0:
        comp.extend([0xF5, length - 1])
        index += length
    else:
        comp.append(h[index])
        index += 1


import math

numLines = len(comp)
output = ["\tDB "] * math.ceil(numLines / 8)

data = iter(comp)
for i, j in enumerate(data):
    output[i // 8] += "{}h, ".format(hex(j).lstrip("0x").upper().zfill(2) if j < 0xA0 else "0" + hex(j).lstrip("0x").upper().zfill(2))
    if i % 8 == 7: 
        output[i // 8] = output[i // 8][:-2]

if i % 8:
    output[-1] = output[-1][:-2]
        
output.insert(0, "minlib_startup_logo_data:")
output.append("minlib_startup_logo_data_end:")

print("\n".join(output), file = open("src/splash.asm", "w"))