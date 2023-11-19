function _op1(a::HVector, b::HVector)::Vector
    if a==b

    end
    if a==b
        throw(ArgumentError("Two arguments cannot be the same"))
    end
    A = [ a.data'; b.data' ]

    N = nullspacex(A)
    return N[:,1] 
end

import AbstractLattices: ∨, ∧


"""
    ∨(a::PPoint, b::PPoint)::PLine

Given points `a` and `b`, return the line containing them both.
"""
function ∨(a::PPoint, b::PPoint)::PLine
    v = _op1(a.data, b.data)
    return PLine(v)
end


"""
    ∧(a::PLine, b::PLine)::PPoint

Given lines `a` and `b`, return the point at which they intersect.
"""
function ∧(a::PLine, b::PLine)::PPoint
    v = _op1(a.data, b.data)
    return PPoint(v)
end