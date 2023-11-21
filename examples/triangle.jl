using RationalProjectivePlane, Clines, Plots, SimpleDrawing

"""
    triangle()

Return a list of the vertices and lines of a triangle in the projective plane, 
suitable for drawing.
"""
function triangle()
    a = PPoint(0, 0)
    b = PPoint(2, 0)
    c = PPoint(1, 17 // 10)
    return [a, b, c, a ∨ b, a ∨ c, b ∨ c]
end