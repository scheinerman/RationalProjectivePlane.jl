import Base: string, show


function _integerize(x::ProjectiveObject)::Vector{Int}
    dlist = denominator.(Vector(x.data))
    d = lcm(dlist...)
    Int.(d * x.data.data)
end

function _string(x::ProjectiveObject)::String
    x, y, z = _integerize(x)
    return "$x : $y : $z"
end


string(x::PPoint) = "(" * _string(x) * ")"
string(x::PLine) = "[" * _string(x) * "]"


function show(io::IO, x::ProjectiveObject)
    print(io, string(x))
end


