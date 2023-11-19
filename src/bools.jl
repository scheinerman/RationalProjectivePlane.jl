# Various operations on ProjectiveObject types that result in a Bool

## Equality
import Base: (==), in, isinf


(==)(a::PPoint, b::PPoint) = a.data == b.data
(==)(a::PLine, b::PLine) = a.data == b.data

## Incidence
"""
    in(a::PPoint, L::PLine)

Test if `a` is on the line `L`.
"""
in(a::PPoint, L::PLine) = dot(a.data, L.data) == 0


## At infinity
"""
    isinf(x::PPoint)::Bool
    isinf(L::PLine)::Bool

Test if a point `x` is on the line at infinity 
or if a line `L` is the line at infinity.
"""
isinf(x::PPoint)::Bool = x.data.data[3] == 0
isinf(L::PLine)::Bool = L.data.data[1] == L.data.data[2] == 0