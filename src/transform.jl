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



"""
    _inv_tr(M::Matrix)

Compute the transpose inverse of a matrix, reducing the precision
of the matrix to `Rational{Int}`.
"""
function _inv_tr(M::Matrix)
    A = copy(transpose(invx(M)))
    return Rational{Int}.(A)
end

function (*)(M::Matrix, L::PLine)::PLine
    if detx(M) == 0
        throw(ArgumentError("Matrix must be nonsingular"))
    end
    MM = _inv_tr(M)
    v = MM * Vector(L)
    return PLine(v)
end


# matrix applied to ProjectiveObject

(M::Matrix)(o::T) where T <: ProjectiveObject = M*o