import naytracerpkg/nttuple, math
import unittest

suite "Tuples/Vectors/Points/Colors":
  setup:
    let 
      examplePoint = initTuple(4.3, -4.2, 3.1, 1.0)
      exampleVector = initTuple(4.3, -4.2, 3.1, 0.0)
      tuple1 = initTuple(3, -2, 5, 1)
      tuple2 = initTuple(-2, 3, 1, 0)
  
  test "checking for equality":
    check examplePoint.isPoint
    check exampleVector.isVector
    check examplePoint == examplePoint.toPoint
    check exampleVector == exampleVector.toVector

  test "add tuples":
    check (tuple1 + tuple2) == initTuple(1, 1, 6, 1)

suite "subtract tuples":
  setup:
    let
      point1 = initPoint(3, 2, 1)
      point2 = initPoint(5, 6, 7)
      v1 = point1 - point2
      point3 = point1 - initVector(5, 6, 7)
      v2 = initVector(3, 2, 1)
      v3 = initVector(5, 6, 7)
  test "subtracting vectors and points":
    check v1 == initVector(-2, -4, -6) # point - point gives a new vector
    check point3 == initPoint(-2, -4, -6)
    check v2 - v3 == initVector(-2, -4, -6) # vector - vector gives a new vector

suite "multiply/divide tuple by scalar":
  setup:
    let tuple1 = initTuple(1, -2, 3, -4)
  
  test "multiplying tuple by scalar":
    check (tuple1 * 3.5) == initTuple(3.5, -7, 10.5, -14)
    check (tuple1 * 0.5) == initTuple(0.5, -1, 1.5, -2)
  
  test "dividing tuple by scalar":
    check (tuple1 / 2.0) == initTuple(0.5, -1, 1.5, -2)

suite "magnitude of vector":
  setup:
    let 
      v1 = initVector(1, 0, 0)
      v2 = initVector(0, 2, 0)
      v3 = initVector(0, 0, 3)
      v4 = initVector(1, 2, 3)
      v5 = initVector(-1, -2, -3)
  
  test "magnitude of vector":
    check v1.magnitude == 1
    check v2.magnitude == 2
    check v3.magnitude == 3
    check v4.magnitude == sqrt(14.0)
    check v5.magnitude == sqrt(14.0)

suite "normalizing vectors":
  setup:
    let
      v1 = initVector(4, 0, 0)
      v2 = initVector(1, 2, 3)
  test "normalizing vectors":
    check v1.normalize == initVector(1, 0, 0)
    check v2.normalize == initVector(0.26726, 0.53452, 0.80178)
    check v2.normalize.magnitude == 1

suite "dot product of 2 vectors":
  setup:
    let
      v1 = initVector(1, 2, 3)
      v2 = initVector(2, 3, 4)
  test "dot product":
    check dot(v1, v2) == 20.0
  
  test "cross dot product":
    # This part is for the cross dot product
    # Order matters here!
    doAssert cross(v1, v2) == initVector(-1, 2, -1)
    doAssert cross(v2, v1) == initVector(1, -2, 1)

suite "creating colors":
  setup:
    let c = initColor(-0.5, 0.4, 1.7)
  test "create colors":
    check c.red == -0.5
    check c.green == 0.4
    check c.blue == 1.7

suite "color operations":
  setup:
    let
      c1 = initColor(0.9, 0.6, 0.75)
      c2 = initColor(0.7, 0.1, 0.25)
      c3 = initColor(0.2, 0.3, 0.4)
      c4 = initColor(1.0, 0.2, 0.4)
      c5 = initColor(0.9, 1.0, 0.1)
  test "basic color operations":
    check c1 + c2 == initColor(1.6, 0.7, 1.0)
    check c1 - c2 == initColor(0.2, 0.5, 0.5)
    check c3 * 2.0 == initColor(0.4, 0.6, 0.8)
    check c4 * c5 == initColor(0.9, 0.2, 0.04)
  