import naytracerpkg/[canvas, nttuple]

block createACanvas:
  let c = newCanvas(10, 20)
  doAssert c.width == 10 and c.height == 20
  for i in 0..<c.pixels.len:
    for j in 0..<c.pixels[i].len:
      doAssert c.pixels[i][j] == initColor(0, 0, 0)

block drawAPixel:
  var
    c = newCanvas(10, 20)
    red = initColor(1, 0, 0)
  c.writePixel(2, 3, red)
  doAssert c.pixelAt(2, 3) == red

## These tests all work but they output/overwrite an ppm file that we don't need
# block checkPPM:
#   var canvas = newCanvas(400, 400)
#   let ppm = canvas.toPPM
#   # doAssert ppm[0..2] ==
#   # """
#   # P3
#   # 5 3
#   # 255
#   # """

# block constructPPM:
#   var canvas = newCanvas(5, 3)
#   let
#     c1 = initColor(1.5, 0.0, 0.0)
#     c2 = initColor(0.0, 0.5, 0.0)
#     c3 = initColor(-0.5, 0.0, 1.0)
#   canvas.writePixel(0, 0, c1)
#   canvas.writePixel(2, 1, c2)
#   canvas.writePixel(4, 2, c3)
#   let ppm = canvas.toPPM()
#   writePPM(ppm)


