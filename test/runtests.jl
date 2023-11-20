using Test, RationalProjectivePlane

@testset "Creations" begin
    p = PPoint(1, 1, 1)
    q = PPoint(-2, -2, -2)
    @test p == q

    L = PLine(3, 3, 3)
    M = PLine(q)
    @test L == M

    a = PPoint(0, 12, -9)
    v = Vector(a)
    @test a == PPoint(v)
end

@testset "Infinity" begin
    L = PLine(0, 0, 5)
    M = PLine(0, 5, 0)
    @test isinf(L)
    @test !isinf(M)

    a = PPoint(5, -4, 0)
    b = PPoint(0, 2, 3)
    @test isinf(a)
    @test !isinf(b)
end

@testset "Operations" begin
    a = PPoint(1, 2, 3)
    b = PPoint(1, 0, -2)
    L = a ∨ b
    @test a ∈ L
    @test L ∋ b

    M = PLine(10, 8, 12)
    x = L ∧ M
    @test x ∈ L
    @test M ∋ x
end

@testset "Transform" begin
    A = [6 5 -1; 9 4 9; -4 6 0]
    p = PPoint(3, 0, -5)
    q = PPoint(2, 2, 3)
    L = p ∨ q

    pp = A * p
    qq = A * q
    LL = A * L

    @test pp ∨ qq == LL

    B = Rational{Int}.(invx(A))
    @test B*pp == p

    L = PLine(2, 1, -1)
    M = PLine(0, 5, 2)
    x = L ∧ M

    LL = A * L
    MM = A * M
    xx = A * x

    @test xx ∈ LL
    @test xx ∈ MM

end
