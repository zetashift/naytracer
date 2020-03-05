import naytracerpkg/nttuple, math

when isMainModule:
  block vectorOrPoint:
    let examplePoint = initTuple(4.3, -4.2, 3.1, 1.0)
    let exampleVector = initTuple(4.3, -4.2, 3.1, 0.0)
    doAssert examplePoint.isPoint
    doAssert exampleVector.isVector
    doAssert examplePoint == initPoint(examplePoint)
    doAssert exampleVector == initVector(exampleVector)

  block addTuples:
    let
      tuple1 = initTuple(3, -2, 5, 1)
      tuple2 = initTuple(-2, 3, 1, 0)
      res = tuple1 + tuple2
    doAssert res == initTuple(1, 1, 6, 1)

  block subtractTuples:
    let
      point1 = initPoint(3, 2, 1)
      point2 = initPoint(5, 6, 7)
      v1 = point1 - point2
      point3 = point1 - initVector(5, 6, 7)
      v2 = initVector(3, 2, 1)
      v3 = initVector(5, 6, 7)
    doAssert v1 == initVector(-2, -4, -6) # point - point gives a new vector
    doAssert point3 == initPoint(-2, -4, -6)
    doAssert v2 - v3 == initVector(-2, -4, -6) # vector - vector gives a new vector

  block multiplyTupleByScalar:
    let tuple1 = initTuple(1, -2, 3, -4)

    doAssert (tuple1 * 3.5) == initTuple(3.5, -7, 10.5, -14)
    doAssert (tuple1 * 0.5) == initTuple(0.5, -1, 1.5, -2)

  block divideTupleByScalar:
    let tuple1 = initTuple(1, -2, 3, -4)
    doAssert (tuple1 / 2.0) == initTuple(0.5, -1, 1.5, -2)
  
  block magnitudeOfVector:
    let 
      v1 = initVector(1, 0, 0)
      v2 = initVector(0, 2, 0)
      v3 = initVector(0, 0, 3)
      v4 = initVector(1, 2, 3)
      v5 = initVector(-1, -2, -3)
    doAssert v1.magnitude == 1
    doAssert v2.magnitude == 2
    doAssert v3.magnitude == 3
    doAssert v4.magnitude == sqrt(14.0)
    doAssert v5.magnitude == sqrt(14.0)
  
  block normalizeVectors:
    let
      v1 = initVector(4, 0, 0)
      v2 = initVector(1, 2, 3)
    
    doAssert v1.normalize == initVector(1, 0, 0)
    doAssert v2.normalize == initVector(0.26726, 0.53452, 0.80178)
    doAssert v2.normalize.magnitude == 1
  
  block dotProduct:
    let
      v1 = initVector(1, 2, 3)
      v2 = initVector(2, 3, 4)
    
    doAssert dot(v1, v2) == 20.0

    # This part is for the cross dot product
    # Order matters here!
    doAssert cross(v1, v2) == initVector(-1, 2, -1)
    doAssert cross(v2, v1) == initVector(1, -2, 1)