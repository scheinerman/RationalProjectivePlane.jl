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
in(a::PPoint, L::PLine) = dot(a.data.data, L.data.data) == 0


## At infinity
"""
    isinf(x::PPoint)::Bool
    isinf(L::PLine)::Bool

Test if a point `x` is on the line at infinity 
or if a line `L` is the line at infinity.
"""
isinf(x::PPoint)::Bool = x.data.data[3] == 0
isinf(L::PLine)::Bool = L.data.data[1] == L.data.data[2] == 0

# collinearity and concurrency
import Clines: collinear
export collinear, concurrent

"""
    collinear(a::PPoint, b::PPoint, etc)::Bool
    collinear(plist::Vector{PPoint})::Bool

Test if points (or a list of points) are collinear.
"""
function collinear(plist::Vector{PPoint})::Bool
    np = length(plist)
    if np < 3
        return true 
    end

    M = zeros(Int, 3, np)
    for k=1:np
        M[:,k] = Vector(plist[k])
    end

    return rankx(M) < 3 
end


collinear(a::PPoint, b...)::Bool = collinear([a;collect(b)])
collinear(a::PPoint)::Bool = true
collinear()::Bool = true


"""
    concurrent(a::PLine, b::PLine, etc)::Bool
    concurrent(llist::Vector{PLine})::Bool

Test if lines (or a list of lines) are concurrent, i.e., all contain a common point. 
"""
function concurrent(llist::Vector{PLine})::Bool
    np = length(llist)
    if np < 3
        return true
    end
    M = zeros(Int, 3, np)
    for k=1:np
        M[:,k] = Vector(llist[k])
    end
    return rankx(M) < 3
end

concurrent(a::PLine, b...)::Bool = concurrent([a;collect(b)])
concurrent(a::PLine)::Bool = true
concurrent()::Bool = true