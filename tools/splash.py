from PIL import Image

from graphics import tilestobytes, spritestotiles, spritesheettosprites
from rle import compress
from bin2asm import toasm

src = Image.open("src/splash.png")

sprites = spritesheettosprites(src)

tiles = spritestotiles(sprites)

tilesbin = tilestobytes(tiles)

comp = compress(tilesbin)

output = toasm(comp)

output.insert(0, "minlib_startup_logo_data:")
output.append("minlib_startup_logo_data_end:")

print("\n".join(output), file = open("src/splash.asm", "w"))