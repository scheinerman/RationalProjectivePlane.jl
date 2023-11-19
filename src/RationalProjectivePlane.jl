module RationalProjectivePlane
using LinearAlgebraX, AbstractLattices


export PPoint, PLine

abstract type ProjectiveObject end

"""
    _check(a,b,c)

Check that the three arguments are not all zero. Thrown an error if so.
"""
function _check(a, b, c)
    if a == b == c == 0
        throw(ArgumentError("Coordinates may not all be zero"))
    end
    nothing
end

"""
A `PPoint` is a point in the rational projective plane. Construct as follows:
* `PPoint(a,b,c)`
* `PPoint([a,b,c])`
where `a`, `b`, and `c` are integers or rationals (not all zero).
"""
struct PPoint <: ProjectiveObject
    data::HVector{Rational{Int}}
    function PPoint(a, b, c)
        _check(a, b, c)
        new(HVector([a, b, c]))
    end
end
PPoint(x::Vector) = PPoint(x...)
PPoint(x::HVector) = PPoint(Vector(x))
PPoint(x, y) = PPoint(x, y, 1)

"""
A `PLine` is a line in the rational projective plane. Construct as follows:
* `PLine(a,b,c)`
* `PLine([a,b,c])`
where `a`, `b`, and `c` are integers or rationals (not all zero).
"""
struct PLine <: ProjectiveObject
    data::HVector{Rational{Int}}
    function PLine(a, b, c)
        _check(a, b, c)
        new(HVector([a, b, c]))
    end
end
PLine(x::Vector) = PLine(x...)
PLine(x::HVector) = PLine(Vector(x))
PLine(x, y) = PLine(x, y, 1)


## Conversion/copy methods

PPoint(x::T) where {T<:ProjectiveObject} = PPoint(x.data)
PLine(x::T) where {T<:ProjectiveObject} = PLine(x.data)

# Convert to a `Vector{Rational}`

Vector(x::T) where {T<:ProjectiveObject} = x.data.data


include("io.jl")
include("bools.jl")
include("meet_join.jl")



end # module RationalProjectivePlane
