# matrix applied to ProjectiveObject-s

import Base: (*)



"""
    (*)(M::Matrix, a::PPoint)::PPoint
    (*)(M::Matrix, L::PLine)::PLine
    
`M*a` returns a new `PPoint` formed by multiplying `M` times the homogeneous
coordinates of `a`.

`M*L` returns a new `PLine` formed by applying `M` to the points of `L`. This is *not*
the same as multiplying `M` times the homogeneous coordinates of `L`.

This may also be accomplished as `M(a)` or `M(L)`.
"""
function (*)(M::Matrix, a::PPoint)::PPoint
    if detx(M) == 0
        throw(ArgumentError("Matrix must be nonsingular"))
    end
    v = M * Vector(a)
    return PPoint(v)
end

# matrix applied to ProjectiveObject

(M::Matrix)(o::T) where {T<:ProjectiveObject} = M * o


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



export transform


"""
    transform(a::PP, b::PP, c::PP = PP(0, 0, 1))::Matrix{Rational{Int}}

Create a matrix `M` with the property that `M(a)` is `(1 : 0 : 0)`,
`M(b)` is `(0 : 1 : 0)`, and `M(c)` is `(0 : 0 : 1)`.
"""
function transform(a::PP, b::PP, c::PP = PP(0, 0, 1))::Matrix{Rational{Int}}
    M = [Vector(a) Vector(b) Vector(c)] // 1
    return inv(M)
end

"""
    transform(a::PP, aa::PP, b::PP, bb::PP, c::PP, cc::PP)::Matrix{Rational{Int}}

Create a matrix `M` with the property that `M(a) == aa`, `M(b) == bb`, and `M(c) == cc`.
"""
function transform(a::PP, aa::PP, b::PP, bb::PP, c::PP, cc::PP)::Matrix{Rational{Int}}
    M1 = transform(a, b, c)
    M2 = transform(aa, bb, cc)
    return inv(M2) * M1
end
