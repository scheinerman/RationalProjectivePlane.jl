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

PLine(a::PPoint, b::PPoint) = a ∨ b

"""
    ∧(a::PLine, b::PLine)::PPoint

Given lines `a` and `b`, return the point at which they intersect.
"""
function ∧(a::PLine, b::PLine)::PPoint
    v = _op1(a.data, b.data)
    return PPoint(v)
end

PPoint(L::PLine, M::PLine) = L ∧ M


function _op2(a::HVector)
    M = reshape(a.data, 1, 3)
    N = nullspacex(M)
    v = N[:, 1]
    w = N[:, 2]
    return v, w
end


# for the two_points and two_lines functions we want to give 
# finite results whenever possible.


"""
    two_points(L::PLine)::Tuple{PPoint,PPoint}

Given a line `L` return a pair of distinct points on `L`. Unless `L`
is the line at infinity, return a pair of finite points. 
"""
function two_points(L::PLine)::Tuple{PPoint,PPoint}
    v, w = _op2(L.data)
    a, b = PPoint(v), PPoint(w)

    if isinf(L)   # if L is the line at infinity, can't avoid infinite points
        return a, b
    end

    if isinf(a)
        c = Vector(a) + Vector(b) |> PPoint
        return c, b
    end

    if isinf(b)
        c = Vector(a) + Vector(b) |> PPoint
        return a, c
    end

    return a, b
end

"""
    two_lines(a::PPoint)::Tuple{PLine, PLine}

Given a point `a` return a pair of distinct lines that contain `a`. Neither 
line returned is the line at infinity.
"""
function two_lines(a::PPoint)::Tuple{PLine,PLine}
    v, w = _op2(a.data)
    L, M = PLine(v), PLine(w)

    if isinf(L)
        L = Vector(L) + Vector(M) |> PLine
        return L, M
    end

    if isinf(M)
        M = Vector(L) + Vector(M) |> PLine
        return L, M
    end

    return L, M
end
