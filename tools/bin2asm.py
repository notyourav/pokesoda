import math

def toasm(data: bytearray, perLine: int = 8) -> list:
    numLines = len(data)
    output = ["\tDB "] * math.ceil(numLines / perLine)
    
    it = iter(data)
    for i, j in enumerate(it):
        output[i // perLine] += "{}h, ".format(hex(j).lstrip("0x").upper().zfill(2) if j < 0xA0 else "0" + hex(j).lstrip("0x").upper().zfill(2))
        if i % perLine == perLine - 1: 
            output[i // perLine] = output[i // perLine][:-2]
    if i % perLine != perLine - 1:
        output[-1] = output[-1][:-2]
    
    return output

if __name__ == "__main__":
    import sys
    if len(sys.argv) < 3:
        print(f"Usage: {sys.argv[0]} infile outfile")
        sys.exit()
    
    with open(sys.argv[1], "rb") as infile:
        f = bytearray(infile.read())
    
    with open(sys.argv[2], "w") as outfile:
        outfile.write("\n".join(toasm(f)))