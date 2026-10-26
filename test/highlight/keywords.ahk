; if/else
if (x) {
; <- keyword
}

if (x) {
} else {
; ^^ keyword
}

; while loop
while (running) {
; <- keyword
}

; loop
loop {
; <- keyword
}

loop 10 {
; <- keyword
}

; for loop
for item in collection {
; <- keyword
;         ^^ keyword
}

; try/catch/finally
try {
; <- keyword
} catch Error as e {
; ^^^^^ keyword
;              ^^ keyword
} finally {
; ^^^^^^^ keyword
}

; Control flow
return
; <- keyword

return value
; <- keyword

break
; <- keyword

continue
; <- keyword

; throw
throw Error("oops")
; <- keyword

; class keywords
class MyClass {
; <- keyword
}

class Child extends Parent {
; <- keyword
;           ^^^^^^^ keyword
}

; static keyword
class Example {
    static value := 1
;   ^^^^^^ keyword

    static Method() {
;   ^^^^^^ keyword
    }
}

; unset keyword
x := unset
;    ^^^^^ keyword