# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import naytracerpkg/[nttuple, canvas]

type
  Projectile = object
    pos: Point
    velocity: Vector
  Environment = object
    gravity: Vector
    wind: Vector

func tick(env: Environment, projectile: Projectile): Projectile =
  result = Projectile(pos: (projectile.pos + projectile.velocity).toPoint,
      velocity: (projectile.velocity + env.gravity + env.wind).toVector)


func initEnvironment(grav, wind: Vector): Environment =
  result = Environment(gravity: grav, wind: wind)

func initProjectile(pos: Point, vel: Vector): Projectile =
  result = Projectile(pos: pos, velocity: vel)

when isMainModule:
  var
    cvs = newCanvas(900, 550)
    env = initEnvironment(initVector(0, -0.1, 0), initVector(-0.05, 0, 0))
    velocity = (initVector(0.4, 0.8, 0).normalize * 8.25).toVector
    p = initProjectile(initPoint(0, 1, 0), velocity)
    color = initColor(0.8, 0.4, 0.2)
  
  while (p.pos.y > 0):
    cvs.writePixel(p.pos.x.int, cvs.height - p.pos.y.int, color)
    p = tick(env, p)
  cvs.toPPM.writePPM()