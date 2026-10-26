; In v2, continuation is done with ( at end of line or explicit line joining
; Simple multiline string concatenation
message := "This is line one"
    . " and this is line two"
    . " and line three"

; Multiline function call (standard across versions)
result := MyFunc(
    param1,
    param2,
    param3
)

; Nested function calls spanning lines
value := OuterFunc(
    InnerFunc(a, b),
    AnotherFunc(c)
)