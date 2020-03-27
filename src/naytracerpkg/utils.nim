
func equal*(a, b: float): bool =
  const epsilon = 0.0001
  result = if abs(a - b) < epsilon:
             true
           else:
             false
