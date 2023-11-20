# matrix applied to ProjectiveObject

import Base: (*)

function (*)(M::Matrix{T}, a::S) where {T<:Union{Rational,Integer}, S<:RationalProjectivePlane.ProjectiveObject}
    if detx(M) == 0
        throw(ArgumentError("Matrix must be nonsingular"))
    end
    v = M * Vector(a)
    return S(v)
end