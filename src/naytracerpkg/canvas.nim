import nttuple

type
  Canvas* = ref object
    width*, height*: int
    pixels*: seq[seq[Color]]

func newCanvas*(width, height: int): Canvas =
  var pixels: seq[seq[Color]] = newSeq[seq[Color]](width)
  for i in 0 ..< width:
    pixels[i] = newSeq[Color](height)
    for j in 0 ..< height:
      pixels[i][j] = initColor(0, 0, 0)
  result = Canvas(width: width, height: height, pixels: pixels)

proc writePixel*(c: var Canvas, x, y: int, color: Color) =
  c.pixels[x][y] = color

func pixelAt*(c: Canvas, x, y: int): Color =
  result = c.pixels[x][y]

func toPPM*(c: Canvas): string =
  result.add("P3\n")
  result.add($c.width & " " & $c.height & "\n")
  result.add("255\n")

  for i in 0 ..< c.width:
    for j in 0 ..< c.height:
      let
        pixel = c.pixels[i][j]
        ir = int(255.99 * pixel.red)
        ig = int(255.99 * pixel.green)
        ib = int(255.99 * pixel.blue)

      result.add($ir & " " & $ig & " " & $ib & "\n")

proc writePPM*(contents: string) =
  writeFile("output.ppm", contents)