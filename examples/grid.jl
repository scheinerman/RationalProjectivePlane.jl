using RationalProjectivePlane, Clines, Plots, SimpleDrawing

"""
    grid(n::Int = 4)

Return a list of points and lines in which the points form an `n`-by-`n`
grid and the `2n` lines run horizontally and vertically through the grid.
"""
function grid(n::Int = 4)
    if n < 2
        throw(ArgumentError("Argument must be at least 2"))
    end

    plist = [PPoint(i, j, 1) for i = 1:n for j = 1:n]
    lines1 = [PPoint(i, 1, 1) ∨ PPoint(i, n, 1) for i = 1:n]
    lines2 = [PPoint(1, i, 1) ∨ PPoint(n, i, 1) for i = 1:n]

    return [plist; lines1; lines2]
end

function skewed_grid(n::Int = 4)
    M = [10 11 0; 11 10 0; 9 9 1]
    obs = grid(n)
    new_obs = M.(obs)
    return new_obs
end
