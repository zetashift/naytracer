import unittest

type
  Matrix*[W, H: static int] = array[W, array[H, float]]
  
func newMatrix*[W, H: static int](elements: array[W, array[H, float]]): Matrix[W, H] =
  result = elements
 
func equal*(a, b: float): bool =
  const epsilon = 0.0001
  result = if abs(a - b) < epsilon:
             true
           else:
             false
  
func `==`*[W,H](m1, m2: Matrix[W, H]): bool =
  result = true
  for x in 0 .. high(m1):
    for y in 0 .. high(m1):
      if not m1[x][y].equal(m2[x][y]):
        return false
 
func submatrix*[W, H](m: Matrix[W, H], rowIdx, colIdx: int): Matrix[W - 1, H - 1] =
  for row in 0 .. high(m):
    var resultRow = row
    if row == rowIdx: continue
    elif row > rowIdx: resultRow.dec(1)
    for col in 0 .. high(m[0]):
      var resultCol = col
      if col == colIdx:
        continue
      elif col > colIdx: resultCol.dec(1)

      result[resultRow][resultCol] = m[row][col]
  
suite "submatrices":
  setup:
    let
      matrix4x4 = [[-6.0, 1.0, 1.0, 6.0],
                   [-8.0, 5.0, 8.0, 6.0],
                   [-1.0, 0.0, 8.0, 2.0],
                   [-7.0, 1.0, -1.0, 1.0]
                  ].newMatrix
  
  test "getting the submatrix of a 4 x 4 matrix with row / column indicators":
    check matrix4x4.submatrix(2, 1) == [[-6.0, 1.0, 6.0], 
                                        [-8.0, 8.0, 6.0], 
                                        [-7.0, -1.0, 1.0]
                                       ].newMatrix