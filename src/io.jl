import Base: string, show



function _string(x::ProjectiveObject)::String
    x, y, z = Vector(x)
    return "$x : $y : $z"
end


string(x::PPoint) = "(" * _string(x) * ")"
string(x::PLine) = "[" * _string(x) * "]"


function show(io::IO, x::ProjectiveObject)
    print(io, string(x))
end


