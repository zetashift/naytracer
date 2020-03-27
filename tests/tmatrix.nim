import naytracerpkg/[matrix, nttuple]
import unittest

suite "constructing matrices":
  # Construct 4x4 matrix
  setup:
    let
      elements = [[1.0, 2.0, 3.0, 4.0],
                  [5.5, 6.5, 7.5, 8.5],
                  [9.0, 10.0, 11.0, 12.0],
                  [13.5, 14.5, 15.5, 16.5]]
      m = newMatrix(elements)
  test "checking for succesfull construction":
    check m[0, 0] == 1.0
    check m[0, 3] == 4.0
    check m[1, 0] == 5.5
    check m[1, 2] == 7.5
    check m[2, 2] == 11.0
    check m[3, 0] == 13.5
    check m[3, 2] == 15.5

suite "testing for matrix equality":
  setup:
    let
      m1 = [[1.0, 2.0, 3.0, 4.0],
            [5.0, 6.0, 7.0, 8.0],
            [9.0, 8.0, 7.0, 6.0],
            [5.0, 4.0, 3.0, 2.0]
          ].newMatrix
      m2 = [[1.0, 2.0, 3.0, 4.0],
            [5.0, 6.0, 7.0, 8.0],
            [9.0, 8.0, 7.0, 6.0],
            [5.0, 4.0, 3.0, 2.0]
          ].newMatrix
      m3 = [[2.0, 3.0, 4.0, 5.0],
            [6.0, 7.0, 8.0, 9.0],
            [8.0, 7.0, 6.0, 5.0],
            [4.0, 3.0, 2.0, 1.0]
          ].newMatrix

  test "equality between matrices":
    check m1 == m2
    check m1 != m3

suite "multiplying matrix by matrix and tuple":
  setup:
    let
      m1 = [[1.0, 2.0, 3.0, 4.0],
            [5.0, 6.0, 7.0, 8.0],
            [9.0, 8.0, 7.0, 6.0],
            [5.0, 4.0, 3.0, 2.0]
          ].newMatrix
      m2 = [[-2.0, 1.0, 2.0, 3.0],
            [3.0, 2.0, 1.0, -1.0],
            [4.0, 3.0, 6.0, 5.0],
            [1.0, 2.0, 7.0, 8.0]
          ].newMatrix
      m3 = [[1.0, 2.0, 3.0, 4.0],
            [2.0, 4.0, 4.0, 2.0],
            [8.0, 6.0, 4.0, 1.0],
            [0.0, 0.0, 0.0, 1.0]
          ].newMatrix
      aTuple = initTuple(1.0, 2.0, 3.0, 1.0)

  test "multiplying by matrix":
    check (m1 * m2) == [[20.0, 22.0, 50.0, 48.0],
                        [44.0, 54.0, 114.0, 108.0],
                        [40.0, 58.0, 110.0, 102.0],
                        [16.0, 26.0, 46.0, 42.0]
                      ].newMatrix

  test "multiplying by tuple":
    check m3 * aTuple == initTuple(18.0, 24.0, 33.0, 1.0)

suite "identity matrices":
  setup:
    let
      m1 = [[0.0, 1.0, 2.0, 4.0],
            [1.0, 2.0, 4.0, 8.0],
            [2.0, 4.0, 8.0, 16.0],
            [4.0, 8.0, 16.0, 32.0]
          ].newMatrix

  test "multiply a matrix by the identity matrix":
    check m1 * m1.identity == m1

  test "multiply the identity matrix by a tuple":
    check m1.identity * initTuple(1.0, 2.0, 3.0, 4.0) == initTuple(1.0, 2.0,
        3.0, 4.0)

suite "transposing matrices":
  setup:
    let
      m1 = [[0.0, 9.0, 3.0, 0.0],
            [9.0, 8.0, 0.0, 8.0],
            [1.0, 8.0, 5.0, 3.0],
            [0.0, 0.0, 5.0, 8.0],
          ].newMatrix
      m1Transposed = [[0.0, 9.0, 1.0, 0.0],
                      [9.0, 8.0, 8.0, 0.0],
                      [3.0, 0.0, 5.0, 5.0],
                      [0.0, 8.0, 3.0, 8.0]
                    ].newMatrix

  test "transposing a matrix":
    check m1.transpose == m1Transposed

  test "transposing a identity matrix":
    check m1.identity.transpose == m1.identity

suite "determining determinants":
  setup:
    let
      m1 = [[1.0, 5.0], [-3.0, 2.0]].newMatrix

  test "calculate the determinant of a 2x2 matrix":
    check m1.determinant == 17.0

suite "submatrices":
  setup:
    let
      matrix3x3 = [[1.0, 5.0, 0.0],
                   [-3.0, 2.0, 7.0],
                   [0.0, 6.0, -3.0],
                  ].newMatrix
      matrix4x4 = [[-6.0, 1.0, 1.0, 6.0],
                   [-8.0, 5.0, 8.0, 6.0],
                   [-1.0, 0.0, 8.0, 2.0],
                   [-7.0, 1.0, -1.0, 1.0]
                  ].newMatrix
  
  test "getting the submatrix of a 3 x 3 matrix":
    check matrix3x3.submatrix == [[-3.0, 2.0], [0.0, 6.0]].newMatrix
  
  test "getting the submatrix of a 4 x 4 matrix with row / column indicators":
    check matrix4x4.submatrix(2, 1) == [[-6.0, 1.0, 6.0], 
                                        [-8.0, 8.0, 6.0], 
                                        [-7.0, -1.0, 1.0]
                                       ].newMatrix
                              