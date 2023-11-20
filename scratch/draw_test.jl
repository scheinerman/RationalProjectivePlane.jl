using SimpleDrawing, RationalProjectivePlane, Clines

function draw_test(n::Int = 5)
    newdraw()
    xy = [rand(Int, 2) .% 10 for _ = 1:n]
    plist = PPoint.(xy) |> unique
    n = length(plist)

    llist = [plist[i] ∨ plist[j] for i = 1:n-1 for j = i+1:n]

    obs = [plist; llist]
end

function draw_test_2()
    a = PPoint(0, 0)
    b = PPoint(1, 0)
    c = PPoint(1, 1)
    d = PPoint(0, 1)

    obs = [a,b,c,d, a∨b, b∨c, c∨d, d∨a]


end
