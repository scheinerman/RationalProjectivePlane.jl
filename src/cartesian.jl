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

import Clines: Line

"""
    Line(L::PLine)

Convert a projective line into a `Line` (from the `Clines`) module.
If `L` is the line at infinity, return `nothing`.
"""
function Line(L::PLine)::Union{Nothing, Line}
    if isinf(L)
        return nothing
    end

    a,b = two_points(L)
    ax, ay = cartesian(a)
    bx, by = cartesian(b)
    
    return Line(ax,ay,bx,by)
end
