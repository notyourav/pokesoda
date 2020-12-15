def compress(data: bytearray, nonzero: int = 0xF6, zero: int = 0xF5) -> bytearray:
    comp = bytearray()
    
    length = 0
    
    index = 0
    while index < len(data):
        length = 0
        while index + length < len(data) and data[index + length] == data[index] and length < 256:
            length += 1
        
        if length > 3 and data[index] != 0:
            comp.extend([nonzero, data[index], length - 1])
            index += length
        elif length > 2 and data[index] == 0:
            comp.extend([zero, length - 1])
            index += length
        else:
            comp.append(data[index])
            index += 1
    
    return comp

if __name__ == "__main__":
    import sys
    if len(sys.argv) < 3:
        print(f"Usage: {sys.argv[0]} infile outfile")
        sys.exit()
    
    with open(sys.argv[1], "rb") as infile:
        f = bytearray(infile.read())
    
    with open(sys.argv[2], "wb") as outfile:
        outfile.write(compress(f))