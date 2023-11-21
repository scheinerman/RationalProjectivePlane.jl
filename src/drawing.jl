using SimpleDrawing

import SimpleDrawing: draw

const _ppoint_size = 5

function draw(a::PPoint)
    if isinf(a)
        draw(nothing)
    else
        x, y = cartesian(a)
        draw_point(x, y, marker = _ppoint_size, color = :black)
    end
end

function draw(L::PLine)
    if isinf(L)
        draw(nothing)
    else
        draw(Line(L))
    end
end


function draw(objs::Vector{T}) where {T<:ProjectiveObject}
    points = [it for it ∈ objs if it isa PPoint && !isinf(it)]
    lines = [it for it ∈ objs if it isa PLine && !isinf(it)]
    
    for p ∈ points
        draw(p)
    end

    expand_canvas()

    for L ∈ lines
        draw(L)
    end

    finish()
end