from PIL import Image

def tilestobytes(tiles: list) -> bytearray:
    ret = bytearray()
    
    for i in tiles:
        ret.extend(Image.frombytes("L", (8, 8), bytes(i)).transpose(Image.ROTATE_270).convert("1").tobytes())
    
    return ret

def spritestotiles(sprites: list) -> list:
    tiles = []
    
    mapping = [0, 4, 1, 5, 2, 6, 3, 7]
    
    for i in sprites:
        data = []
        transp = []
        for j in range(0, len(i), 4):
            if i[j:j + 3] == [0xFF, 0x00, 0xFF]:
                data.append(0xFF)
                transp.append(0xFF)
            elif i[j:j + 3] == [0x00, 0xFF, 0xFF]:
                data.append(0x00)
                transp.append(0xFF)
            else:
                data.append(i[j + 1] ^ 0xFF)
                transp.append(0x00)
        
        transp.extend(data)
        column = []
        for j in range(0, len(transp), (8 * 8 * 2)):
            for k in range(2):
                for l in range(8):
                    column.extend(transp[j + k * 8 + l * 16:j + k * 8 + l * 16 + 8])
        
        
        this = []
        for j in range(0, len(column), 8 * 8):
            this.append(column[j:j + 64])
        
        toadd = [None, None, None, None, None, None, None, None]
        
        for j in range(8):
            toadd[mapping[j]] = this[j]
        
        tiles.extend(toadd)
    
    return tiles

def spritesheettosprites(sheet: Image) -> list:
    data = sheet.convert("RGBA").tobytes()
    
    width = sheet.size[0] // 16
    
    sprites = []
    
    for i in range(len(data) // (16 * 16 * 4)):
        sprites.append([])
    
    for i in range(len(data)):
        sprites[((i // (16 * 4)) % width) + (i // (16 * 16 * width * 4)) * width].append(data[i])
    
    return sprites

def tilesheettotiles(sheet: Image) -> list:
    data = sheet.convert("L").tobytes()
    
    width = sheet.size[0] // 8
    
    tiles = []
    
    for i in range(len(data) // (8 * 8)):
        tiles.append([])
    
    for i in range(len(data)):
        tiles[((i // 8) % width) + (i // (width * 8 * 8)) * width].append(data[i] ^ 0xFF)
    
    return tiles

if __name__ == "__main__":
    import sys
    if len(sys.argv) < 4:
        print(f"Usage: {sys.argv[0]} mode infile outfile")
        sys.exit()
    
    infile = Image.open(sys.argv[2])
    
    if sys.argv[1] == "t":
        tiles = tilesheettotiles(infile)
    elif sys.argv[1] == "s":
        sprites = spritesheettosprites(infile)
        tiles = spritestotiles(sprites)
    else:
        print(f"Invalid mode {sys.argv[1]}")
        sys.exit()
    
    out = tilestobytes(tiles)
    
    if sys.argv[3].endswith(".asm") or sys.argv[3].endswith(".tiles") or sys.argv[3].endswith(".sprites"):
        from bin2asm import toasm
        asm = toasm(out)
        if len(sys.argv) > 4:
            asm.insert(0, sys.argv[4])
        if len(sys.argv) > 5:
            asm.append(sys.argv[5])
        out = bytearray("\n".join(asm).encode())
    
    with open(sys.argv[3], "wb") as outfile:
        outfile.write(out)