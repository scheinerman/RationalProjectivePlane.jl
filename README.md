# RationalProjectivePlane

Points and lines in the rational projective plane. Both are represented using homogenous coordinates. 

> Homogenous coordinates are triples of rational numbers that are not all zero. The triple `(a ,b, c)` is the same as the triple `(ma, mb, mc)` where `m` is any nonzero rational. 

## Creating points and lines

A point in the projective plane is created by one of the following methods:
* `PPoint(a,b,c)` where `a`, `b`, and `c` are rational numbers that are not all zero.
* `PPoint(a,b)` is the same as `PPoint(a,b,1)`.
* `PPoint([a,b,c])` or `PPoint([a,b])`.

Likewise, lines are created with `PLine`.

Points are printed as triples `(a,b,c)` where `a`, `b`, and `c` are relatively prime integers.

Similarly, lines are printed as `[a,b,c]`.

```
julia> PPoint(2, 3//5, 1)
(10 : 3 : 5)

julia> PPoint(2,-2)
(2 : -2 : 1)

julia> PLine(2,4,6)
[1 : 2 : 3]

julia> PLine(2,2)
[2 : 2 : 1]
```

Note that `PPoint(0,0,0)` and `PLine(0,0,0)` throw errors. 

### Conversion between points and lines

Points and lines are not the same, but it is possible to convert a point to a line 
(and vice versa). For a point `a`, use `PLine(a)` to create a line with the same
homogenous coordinates as `a`. Conversely, for a line `L` use `PPoint(L)` to create a
point with the same homogenous coordinates as `L`.

```
julia> a = PPoint(2,3,-1)
(-2 : -3 : 1)

julia> L = PLine(2,3,-1)
[-2 : -3 : 1]

julia> a == L
false

julia> a == PPoint(L)
true

julia> PLine(a)
[-2 : -3 : 1]
```

### Conversion to a `Vector`

Give a point or line, `x`, use `Vector(x)` to convert `x` into a vector of rational 
numbers. The vector version is scaled such that the last nonzero coordinate is `1`.
```
julia> a = PPoint(-3, 3//2, 5)
(-6 : 3 : 10)

julia> Vector(a)
3-element Vector{Rational{Int64}}:
 -3//5
  3//10
  1//1
  ```


## Incidence

Any of the following may be used to see if a point `a` is on a line `L`:
* `in(a,L)`
* `a in L`
* `a ∈ L`
* `L ∋ a`

> The symbol `∈` can is typed `\in<tab>` and the symbol `∋` is typed `\ni<tab>`.

```
julia> a = PPoint(2,1,1)
(2 : 1 : 1)

julia> L = PLine(-1,1,1)
[-1 : 1 : 1]

julia> a ∈ L
true
```

## Operations


Given distinct points `a` and `b`, use `a ∨ b` to give the unique line that contains
both points.

Given distinct lines `L` and `M`, use `L ∧ M` to give the unique point that lines 
on both lines. 

> The symbol `∨` is typed `\vee<tab>` and the symbol `∧` is typed `\wedge<tab>`.


```
julia> a = PPoint(2,3,5)
(2 : 3 : 5)

julia> b = PPoint(-1,-4,2)
(-1 : -4 : 2)

julia> L = a ∨ b
[-26 : 9 : 5]

julia> a ∈ L
true

julia> b ∈ L
true
```


Given a single point `a`, `two_lines(a)` returns a pair of distinct lines that both
contain the point `a`

Given a singe line `L`, `two_points(L)` returns a pair of distince points that are
both on the line `L`.

```
julia> L = PLine(2, 3//5, -1)
[-10 : -3 : 5]

julia> a,b = two_points(L)
((-3 : 10 : 0), (1 : 0 : 2))

julia> a ∨ b
[-10 : -3 : 5]
```

## Infinity

The function `isinf` is used to tell if a point lies on the line at infinity as well
as checking if a line is the line at infinity. 
```
julia> a = PPoint(1,2,3)
(1 : 2 : 3)

julia> isinf(a)
false

julia> b = PPoint(1,2,0)
(1 : 2 : 0)

julia> isinf(b)
true
```

## To Do List

* For a finite point `a`, create a method that returns `(x,y)` such that `(x,y,1)` are the homogenous coordinates of `a`. In this way, `a=PPoint(x,y)`. This `(x,y)` represents the point in the Euclidean plane corresponding to `a` (since it's not at infinity). [This will be easy.]
* Transformation methods.
* Should `Vector` be changed to give the integer version that we use to print?
* Should I export `ProjectiveObject`?
* Visualization via `SimpleDrawing`. I fear this is going to be difficult. 