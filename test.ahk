#Requires AutoHotkey v2.0
#SingleInstance Force
#Include test.ahk

MsgBox("test")

ExitApp()
Reload()

; This is a comment
/* Block
comment */

/**
 * This is a doc comment
 * @param {Integer|Float} param1 The first parameter
 * @param {Integer|Float} param2 The second parameter
 * @return {Integer|Float} The sum of both parameters
 */
MyFunc(param1, param2) {
    return param1 + param2
}

test() {
    return false
}

emptyFunc() {
}

myFunc(file := someVar "\someString.json")

result := MyFunc(1, 2)
emptyFunc()

goto MyLabel

MyLabel:
    test("Hello")
return

^a:: {
    Send("test")
}

x := "hello world"
y := 'single quoted'
num := 123
hex := 0xFF
pi := 3.14

; === Control Flow ===
; If statement
if (enabled)
    DoSomething()

; If-else
if (condition) {
    x := 1
} else {
    x := 2
}

; If-else if-else chain
if (status) {
    MsgBox("Active")
} else if (pending) {
    MsgBox("Waiting")
} else {
    MsgBox("Inactive")
}

; While loop
while (running) {
    Process()
    if (done) {
        break
    }
}

; Simple loop (infinite)
loop {
    if (shouldStop) {
        break
    }
}

; Loop with count
loop 10 {
    counter += 1
}

; Loop with variable count
loop iterations {
    DoWork()
}

; Loop Parse (v2 syntax - no comma)
loop parse InputVar, "," {
    result .= A_LoopField
}

; Loop Files
loop files "C:\*.txt", "R" {
    FileRead(&content, A_LoopFileFullPath)
}

; Loop Read
loop read "input.txt" {
    line := A_LoopReadLine
}

; Loop Reg
loop reg "HKEY_LOCAL_MACHINE\SOFTWARE" {
    val := RegRead(A_LoopRegKey, A_LoopRegName)
}

; For-in with single variable
for item in collection {
    Process(item)
}

; For-in with key-value
for key, value in myObject {
    result .= key
}

; Nested control flow
if (outer) {
    while (inner) {
        loop 5 {
            for k, v in data {
                Handle(k, v)
            }
        }
    }
}

; === Switch Statement ===
switch action {
    case "save":
        Save()
    case "load":
        Load()
    default:
        MsgBox("Unknown action")
}

; Switch with multiple case values
switch errorCode {
    case 1, 2, 3:
        MsgBox("Minor error")
    case 100, 200:
        MsgBox("Major error")
    default:
        MsgBox("Unknown error: " errorCode)
}

; === Try/Catch/Finally ===
try {
    RiskyOperation()
}

; Try with catch (typed)
try {
    MightFail()
} catch TypeError as e {
    HandleError(e)
}

; Try with finally
try {
    AcquireResource()
} finally {
    ReleaseResource()
}

; Try with both catch and finally
try {
    DoWork()
} catch Error as err {
    LogError(err)
} finally {
    Cleanup()
}

; Catch without exception variable
try {
    x := 1
} catch {
    MsgBox("Something went wrong")
}

; === Operators ===
a := 1
b += 2
c -= 3
d *= 4
e /= 5
f .= "text"
g ??= "default"
h ||= "fallback"

; Comparison
equal := a == b
notEqual := a != b
greater := a > b
less := a < b
greaterEq := a >= b
lessEq := a <= b

; Arithmetic
sum := 1 + 2
diff := 5 - 3
prod := 4 * 2
quot := 10 / 2
intDiv := 10 // 3
power := 2 ** 8
modulo := 10 % 3

; Logical
both := a && b
either := a || b
negated := !a
nullable := a ?? b

; Bitwise
bitAnd := a & b
bitOr := a | b
bitXor := a ^ b
bitNot := ~a
shiftR := a >> 2
shiftL := a << 2

; Ternary
result := condition ? "yes" : "no"

; === Functions (v2: everything is a function call) ===
MsgBox("Hello World")
Sleep(1000)
Send("{Enter}")
Run("notepad.exe")
SetTimer(MyLabel, 1000)

; === Built-in Variables ===
path := A_ScriptDir
time := A_Now
idle := A_TimeIdle
version := A_AhkVersion

; === Object/Method Syntax ===
obj := {}
obj.name := "test"
obj.nested.value := 1
result := obj.GetValue()
obj.nested.Method(arg1, arg2)
x := obj.a.b.c

obj2 := {1: "one", 2: "two", "test": "three"}

; === Array Syntax ===
arr := [1, 2, 3]
empty := []
nested := [[1, 2], [3, 4]]
mixed := [1, "text", 3.14]

first := arr[1]
second := arr[2]

; === Escape Sequences ===
msg := "Hello`nWorld"
tabs := "col1`tcol2`tcol3"
quotes := "She said ``Hello``"
carriage := "line1`rline2"

; === Hotstrings ===
::btw::by the way
::omw::on my way

:*:btw2::by the way
:?:ing::ING
:C:BTW::BY THE WAY

; === Fat-Arrow Functions ===
double := (x) => x * 2
add := (x, y) => x + y
greet := (name) => "Hello, " name "!"

; Named fat-arrow (closure stored in variable)
result := ((x) => x + 1)(5)

; === By-Reference Parameters ===
Swap(&a, &b) {
    temp := a
    a := b
    b := temp
}

; === Variadic Parameters ===
Sum(nums*) {
    total := 0
    for n in nums
        total += n
    return total
}

total := Sum(1, 2, 3, 4, 5)

; === super keyword ===
class Base {
    Method() {
        return "base"
    }
}

class Child extends Base {
    Method() {
        return super.Method() " child"
    }
}

; === Throw Statement ===
if (!IsObject(obj)) {
    throw TypeError("obj must be an object")
}

; === Nullish Coalescing ===
value := maybeNull ?? "default"
nested := a.b?.c ?? "fallback"

; === #HotIf Directive ===
#HotIf WinActive("ahk_class Notepad")
^s:: {
    Send("^s")
}
#HotIf