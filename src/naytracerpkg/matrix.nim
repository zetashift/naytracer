import utils, nttuple

type
  Matrix*[W, H: static int] = array[W, array[H, float]]

func newMatrix*[W, H: static int](elements: array[W, array[H, float]]): Matrix[W, H] =
  result = elements

func `[]`*(m: Matrix, a, b: int): float =
  result = m[a][b]

## I should implement this too
proc `[]=`*(m: var Matrix, a, b: int) = discard

func `==`*[W,H](m1, m2: Matrix[W, H]): bool =
  result = true
  for x in 0 .. high(m1):
    for y in 0 .. high(m1):
      if not m1[x][y].equal(m2[x][y]):
        return false

func `*`*(m1, m2: Matrix): Matrix =
  # This only works for 4 x 4 matrices
  for row in 0 .. high(m1):
    for col in 0 .. high(m2[0]):
      # Compute the dot product of every row-column combination
      result[row][col] = (m1[row][0] * m2[0][col]) + (m1[row][1] * m2[1][col]) +
          (m1[row][2] * m2[2][col]) + (m1[row][3] * m2[3][col])

proc `*`*(m: Matrix, t: Tuple): Tuple =
  result = initTuple(0, 0, 0, 0)
  for row in 0 .. high(m):
    let rowAsTuple = initTuple(m[row][0], m[row][1], m[row][2], m[row][3])
    result[row] = rowAsTuple.dot(t)

proc identity*(m: Matrix): Matrix =
  result = [[1.0, 0.0, 0.0, 0.0],
            [0.0, 1.0, 0.0, 0.0],
            [0.0, 0.0, 1.0, 0.0],
            [0.0, 0.0, 0.0, 1.0]
          ].newMatrix

func transpose*(m: Matrix): Matrix =
  for row in 0 .. high(m):
    for col in 0 .. high(m[0]):
      result[row][col] = m[col][row]

func determinant*(m: Matrix): float =
  # This is for a 2 x 2 Matrix
  result = m[0][0] * m[1][1] - m[0][1] * m[1][0]

func submatrix*[W, H](m: Matrix[W, H]): Matrix[W - 1, H - 1] =
  # We need to remove the first row and last column
  for row in 1 .. high(m):
    for col in 0 ..< high(m[0]):
      result[row-1][col] = m[row][col]

# Remove specified row and column
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
      

        
        

