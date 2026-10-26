; Assignment operators
a := 1
; <- variable
;   ^^ operator

b += 2
;  ^^ operator

c -= 3
;  ^^ operator

d *= 4
;  ^^ operator

e /= 5
;  ^^ operator

f .= "text"
;  ^^ operator

g ??= "default"
;  ^^^ operator

h ||= "fallback"
;  ^^^ operator

; Comparison operators
equal := a == b
;          ^^ operator

notEqual := a != b
;             ^^ operator

greater := a > b
;            ^ operator

less := a < b
;         ^ operator

greaterEq := a >= b
;              ^^ operator

lessEq := a <= b
;           ^^ operator

; Arithmetic operators
sum := 1 + 2
;        ^ operator

diff := 5 - 3
;         ^ operator

prod := 4 * 2
;         ^ operator

quot := 10 / 2
;          ^ operator

intDiv := 10 // 3
;            ^^ operator

power := 2 ** 8
;           ^^ operator

modulo := 10 % 3
;            ^ operator

; Logical operators
both := a && b
;         ^^ operator

either := a || b
;           ^^ operator

negated := !a
;          ^ operator

nullable := a ?? b
;             ^^ operator

; Bitwise operators
bitAnd := a & b
;           ^ operator

bitOr := a | b
;          ^ operator

bitXor := a ^ b
;           ^ operator

bitNot := ~a
;         ^ operator

shiftR := a >> 2
;           ^^ operator

shiftL := a << 2
;           ^^ operator

; Ternary operator
result := condition ? "yes" : "no"
;                   ^ operator
;                           ^ operator

; Concatenation
combined := a . b
;             ^ operator

; Fat-arrow
fn := (x) => x + 1
;          ^^ operator