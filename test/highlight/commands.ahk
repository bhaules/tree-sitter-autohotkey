; v2: No commands - everything uses function call syntax
MsgBox("Hello")
; <- function.builtin

Sleep(1000)
; <- function.builtin
;     ^^^^ number

Send("{Enter}")
; <- function.builtin

Run("notepad.exe")
; <- function.builtin

SetTimer(MyLabel, 1000)
; <- function.builtin

FileRead(&content, "file.txt")
; <- function.builtin

WinActivate("ahk_class Notepad")
; <- function.builtin

; User-defined function call
MyCustomFunc("arg1", "arg2")
; <- function

; Flow control functions
ExitApp()
; <- function.builtin