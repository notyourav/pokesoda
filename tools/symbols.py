map_filename = "soda.map"

out_filename = "syms.txt"

map_file = open(map_filename, "r").readlines()

start = 0

while not map_file[start].startswith("Symbols:"): start += 1

start += 3

end = start

while not map_file[end] == "\n": end += 1

ram_symbols = {}
rom_symbols = {}

def parseSymbol(line):
    offset = int(line[-7:-1], 16)
    
    end = len(line) - 12
    start = end
    
    while line[start - 1] != " ": start -= 1
    
    symbol = line[start:end]
    
    if offset < 0x2100:
        ram_symbols[offset] = symbol
    else:
        rom_symbols[offset] = symbol

for i in map_file[start:end]:
    parseSymbol(i)
    
with open(out_filename, "w") as g:

    g.write("RAM addresses:\n")
    
    for i in ram_symbols:
        g.write(f"\t{i:04X}:\t{ram_symbols[i]}\n")
    
    g.write("\nROM addresses:\n")
    
    for i in rom_symbols:
        g.write(f"\t{i:06X}:\t{rom_symbols[i]}\n")