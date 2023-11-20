# matrix applied to ProjectiveObject-s

import Base: (*)



"""
    (*)(M::Matrix, a::PPoint)::PPoint
    (*)(M::Matrix, L::PLine)::PLine


`M*a` returns a new `PPoint` formed by multiplying `M` times the homogeneous
coordinates of `a`.

`M*L` returns a new `PLine` formed by applying `M` to the points of `L`. This is *not*
the same as multiplying `M` times the homogeneous coordinates of `L`.
"""
function (*)(M::Matrix, a::PPoint)::PPoint
    if detx(M) == 0
        throw(ArgumentError("Matrix must be nonsingular"))
    end
    v = M * Vector(a)
    return PPoint(v)
end


function (*)(M::Matrix, L::PLine)::PLine
    a, b = two_points(L)
    aa = M * a
    bb = M * b
    return aa ∨ bb
end
