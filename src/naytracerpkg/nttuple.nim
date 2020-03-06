import math, utils

type
  Tuple* = object of RootObj
    x*, y*, z*, w*: float # Our coordinates in a tuple
                          # If w = 0 it's a Vector else it's a Point
  Vector* = object of Tuple
  Point* = object of Tuple
  Color* = object
    red*, green*, blue*: float

func initTuple*(x, y, z, w: float): Tuple =
  result = Tuple(x: x, y: y, z: z, w: w)

func initPoint*(x, y, z: float): Point =
  result = Point(x: x, y: y, z: z, w: 1)

func initVector*(x, y, z: float): Vector =
  result = Vector(x: x, y: y, z: z, w: 0)

func initColor*(r, g, b: float): Color =
  result = Color(red: r, green: g, blue: b)

func toVector*(t: Tuple): Vector =
  case t.w:
    of 0: result = Vector(x: t.x, y: t.y, z: t.z, w: t.w)
    of 1: raise newException(Exception, "This is not a Vector but a Point!")
    else: raise newException(Exception, "Wrong value for w parameter")

func toPoint*(t: Tuple): Point =
  case t.w:
    of 0: raise newException(Exception, "This is not a valid Point but a Vector")
    of 1: result = Point(x: t.x, y: t.y, z: t.z, w: t.w)
    else: raise newException(Exception, "Wrong value for w parameter")

func isVector*(t: Tuple): bool =
  result = t.w == 0.0

func isPoint*(t: Tuple): bool =
  result = t.w == 1.0

func `==`*(t1, t2: Tuple): bool =
  result = t1.x.equal(t2.x) and t1.y.equal(t2.y) and t1.z.equal(t2.z) and
      t1.w.equal(t2.w)

func `==`*(c1, c2: Color): bool =
  result = c1.red.equal(c2.red) and c1.green.equal(c2.green) and c1.blue.equal(c2.blue)

func `+`*(t1, t2: Tuple): Tuple =
  if t1.w + t2.w == 1:
    result = initTuple(t1.x + t2.x, t1.y + t2.y, t1.z + t2.z, t1.w + t2.w)
  else:
    result = initTuple(t1.x + t2.x, t1.y + t2.y, t1.z + t2.z, t1.w + t2.w)

func `+`*(c1, c2: Color): Color =
  result = initColor(c1.red + c2.red, c1.green + c2.green, c1.blue + c2.blue)

func `-`*(p1, p2: Point): Vector =
  result = initVector(p1.x - p2.x, p1.y - p2.y, p1.z - p2.z)

func `-`*(p: Point, v: Vector): Point =
  result = initPoint(p.x - v.x, p.y - v.y, p.z - v.z)

func `-`*(v1, v2: Vector): Vector =
  result = initVector(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)

func `-`*(t: Tuple): Tuple =
  result = initTuple(-t.x, -t.y, -t.z, t.w)

func `-`*(c1, c2: Color): Color =
  result = initColor(c1.red - c2.red, c1.green - c2.green, c1.blue - c2.blue)

func `*`*(t: Tuple, scalar: float): Tuple =
  result = initTuple(t.x * scalar, t.y * scalar, t.z * scalar, t.w * scalar)

func `*`*(scalar: float, t: Tuple): Tuple =
  result = t * scalar

func `*`*(c1, c2: Color): Color =
  result = initColor(c1.red * c2.red, c1.green * c2.green, c1.blue * c2.blue)

func `*`*(c: Color, scalar: float): Color =
  result = initColor(c.red * scalar, c.green * scalar, c.blue * scalar)

func `*`*(scalar: float, c: Color): Color =
  result = c * scalar

func `/`*(t: Tuple, scalar: float): Tuple =
  result = initTuple(t.x / scalar, t.y / scalar, t.z / scalar, t.w / scalar)

func `/`*(t: Tuple, scalar: int): Tuple =
  result = t / scalar.float

func `/`*(scalar: int, t: Tuple): Tuple =
  result = t / scalar

func `/`*(scalar: float, t: Tuple): Tuple =
  result = t / scalar

func magnitude*(v: Tuple): float =
  result = (v.x.pow(2) + v.y.pow(2) + v.z.pow(2)).sqrt

func normalize*(v: Vector): Tuple =
  let mag = magnitude(v)
  result = initTuple(v.x / mag, v.y / mag, v.z / mag, v.w / mag)

func dot*(t1, t2: Tuple): float =
  result = (t1.x * t2.x) + (t1.y * t2.y) + (t1.z * t2.z) + (t1.w * t2.w)

func cross*(v1, v2: Vector): Vector =
  result = initVector(v1.y * v2.z - v1.z * v2.y,
                      v1.z * v2.x - v1.x * v2.z,
                      v1.x * v2.y - v1.y * v2.x)
