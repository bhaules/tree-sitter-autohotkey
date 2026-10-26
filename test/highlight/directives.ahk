; Include directive
#Include somefile.ahk
; <- attribute

; Include with inline comment
#Include test.ahk ; with comment
; <- attribute
;                 ^ comment

; Include with path
#Include <Library>
; <- attribute

; Requires directive (v2)
#Requires AutoHotkey v2.0
; <- attribute

; SingleInstance directive
#SingleInstance Force
; <- attribute

#SingleInstance Ignore
; <- attribute

; NoTrayIcon directive
#NoTrayIcon
; <- attribute

; MaxThreads directive
#MaxThreads 2
; <- attribute

; MaxThreadsPerHotkey directive
#MaxThreadsPerHotkey 1
; <- attribute

; Warn directive
#Warn
; <- attribute

#Warn All, MsgBox
; <- attribute

; HotIf directive (v2 replaces #If and #IfWin*)
#HotIf WinActive("ahk_class Notepad")
; <- attribute

#HotIf
; <- attribute