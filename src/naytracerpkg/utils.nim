const epsilon = 0.00001

proc equal*(a, b: float): bool =
  result = if abs(a - b) < epsilon:
             true
           else:
             false
