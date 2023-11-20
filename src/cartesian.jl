export cartesian

"""
    cartesian(p::PPoint)::Vector

Given a finite point, return its Cartesian coordinates. That is, 
rational numbers `x` and `y` such that `p == PPoint(x,y,1)`.
"""
function cartesian(p::PPoint)::Vector
    if isinf(p)
        throw(ArgumentError("The point $p is at infinity"))
    end
    xyz = p.data.data
    return xyz[1:2]
end