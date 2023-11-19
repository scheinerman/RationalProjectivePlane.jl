function _op1(a::HVector, b::HVector)::Vector
    if a == b

    end
    if a == b
        throw(ArgumentError("Two arguments cannot be the same"))
    end
    A = [a.data'; b.data']

    N = nullspacex(A)
    return N[:, 1]
end

import AbstractLattices: ∨, ∧
export two_lines, two_points, ∨, ∧


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


function _op2(a::HVector)
    M = reshape(a.data, 1, 3)
    N = nullspacex(M)
    v = N[:, 1]
    w = N[:, 2]
    return v, w
end

"""
    two_points(L::PLine)::Tuple{PPoint,PPoint}

Given a line `L` return a pair of distinct points on `L`.
"""
function two_points(L::PLine)::Tuple{PPoint,PPoint}
    v, w = _op2(L.data)
    return PPoint(v), PPoint(w)
end

"""
    two_lines(a::PPoint)::Tuple{PLine, PLine}

Given a point `a` return a pair of distinct lines that contain `a`.
"""
function two_lines(a::PPoint)::Tuple{PLine,PLine}
    v, w = _op2(a.data)
    return PLine(v), PLine(w)
end
