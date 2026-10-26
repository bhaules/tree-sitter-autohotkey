; Function definitions
MyFunc() {
; <- function
}

MyFunc(x, y) {
; <- function
}

; Function with by-reference parameter (v2: & instead of ByRef)
MyFunc(&x) {
; <- function
;      ^ operator
}

MyFunc(&x, y, &z) {
; <- function
;      ^ operator
;              ^ operator
}

MyFunc(&x := 10) {
; <- function
;      ^ operator
}

; Function with variadic parameter
MyFunc(args*) {
; <- function
;          ^ operator
}

; Fat-arrow functions
double := (x) => x * 2
;              ^^ operator

add := (x, y) => x + y
;             ^^ operator

; Named fat-arrow
greet(name) => "Hello " name
; <- function

; Function calls
result := MyFunc()
;         ^^^^^^ function

result := MyFunc(42)
;         ^^^^^^ function

result := MyFunc(a, b)
;         ^^^^^^ function

; Nested function calls
result := Outer(Inner())
;         ^^^^^ function
;               ^^^^^ function

; Method calls
obj.method()
;   ^^^^^^ function.method

obj.method(arg)
;   ^^^^^^ function.method

obj.prop.method()
;        ^^^^^^ function.method

; Class references (PascalCase or _PascalCase as object in method calls)
_Logger.exception()
; <- type
;       ^^^^^^^^^ function.method

Database.connect()
; <- type
;        ^^^^^^^ function.method

; Special methods in class
class Example {
    __New() {
;   ^^^^^ function.special
    }

    __Delete() {
;   ^^^^^^^^ function.special
    }

    __Get(key, params) {
;   ^^^^^ function.special
    }

    __Set(key, params, value) {
;   ^^^^^ function.special
    }

    __Call(method, params) {
;   ^^^^^^ function.special
    }
}

; Standalone flow control
ExitApp
; <- keyword

Exit
; <- keyword