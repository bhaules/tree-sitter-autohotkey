; Braceless control flow
if (x) y := 1
; <- keyword

while (running) DoWork()
;^^^^ keyword

loop 5 count += 1
;^^^ keyword

for item in collection Process(item)
;^^ keyword
;        ^^ keyword

; Braceless if-else on separate lines
if (x) a := 1 else b := 2
; <- keyword
;             ^^^^ keyword

; Loop variants (v2 syntax - no comma prefix)
loop parse InputVar, ","
; <- keyword
;     ^^^^^ keyword

loop files "*.txt"
; <- keyword
;     ^^^^^ keyword

loop read "input.txt"
; <- keyword
;     ^^^^ keyword

loop reg "HKEY_LOCAL_MACHINE"
; <- keyword
;     ^^^ keyword