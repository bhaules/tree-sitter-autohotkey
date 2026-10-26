; Identifiers (fallback - FIRST so others override)
(identifier) @variable

; Comments
(comment) @comment
(block_comment) @comment
(doc_comment) @comment

; Strings
(string) @string

; Escape sequences within strings
(escape_sequence) @string.escape

; Numbers
(number) @number

; Keywords
(keyword) @keyword

; Parameter modifier (&byref)
(parameter_modifier) @operator

[
  "if"
  "else"
  "while"
  "loop"
  "for"
  "in"
  "try"
  "catch"
  "finally"
  "switch"
  "case"
  "default"
  "return"
  "throw"
  "as"
  "class"
  "extends"
  "static"
  "and"
  "or"
  "not"
] @keyword

; Boolean literals
(boolean) @constant.builtin

; Control flow
(loop_type) @keyword
(catch_clause type: (identifier) @type)
(catch_clause exception: (identifier) @variable.parameter)

; Switch statements
(switch_statement "{" @punctuation.bracket)
(switch_statement "}" @punctuation.bracket)
(case_clause ":" @punctuation.delimiter)
(default_clause ":" @punctuation.delimiter)

; Statement blocks
(statement_block "{" @punctuation.bracket)
(statement_block "}" @punctuation.bracket)

; Parenthesized expressions
(parenthesized_expression "(" @punctuation.bracket)
(parenthesized_expression ")" @punctuation.bracket)

; Operators

; Assignment operators
(assignment_expression ":=" @operator)
(assignment_expression "+=" @operator)
(assignment_expression "-=" @operator)
(assignment_expression "*=" @operator)
(assignment_expression "/=" @operator)
(assignment_expression ".=" @operator)
(assignment_expression "||=" @operator)
(assignment_expression "&&=" @operator)
(assignment_expression "??=" @operator)

; Binary operators - Logical
(binary_expression "||" @operator)
(binary_expression "&&" @operator)
(binary_expression "??" @operator)

; Binary operators - Bitwise
(binary_expression "|" @operator)
(binary_expression "^" @operator)
(binary_expression "&" @operator)
(binary_expression "<<" @operator)
(binary_expression ">>" @operator)

; Binary operators - Equality
(binary_expression "=" @operator)
(binary_expression "==" @operator)
(binary_expression "!=" @operator)

; Binary operators - Comparison
(binary_expression "<" @operator)
(binary_expression ">" @operator)
(binary_expression "<=" @operator)
(binary_expression ">=" @operator)

; Binary operators - Arithmetic
(binary_expression "+" @operator)
(binary_expression "-" @operator)
(binary_expression "*" @operator)
(binary_expression "/" @operator)
(binary_expression "//" @operator)
(binary_expression "%" @operator)
(binary_expression "**" @operator)

; Binary operators - Concatenation
(binary_expression "." @operator)

; Unary operators
(unary_expression "&" @operator)
(unary_expression "!" @operator)
(unary_expression "~" @operator)
(unary_expression "-" @operator)
(unary_expression "+" @operator)

; Ternary operator
(ternary_expression "?" @operator)
(ternary_expression ":" @operator)

; Fat-arrow functions
(fat_arrow_function "=>" @operator)
(fat_arrow_function name: (identifier) @function)
(fat_arrow_function "(" @punctuation.bracket)
(fat_arrow_function ")" @punctuation.bracket)

; Hotkeys
(hotkey) @keyword

; Hotstrings
(hotstring_definition ":" @punctuation.delimiter)
(hotstring_definition "::" @punctuation.delimiter)
(hotstring_trigger) @string.special
(hotstring_options) @attribute
(hotstring_replacement) @string

; Directives - use @attribute instead of @preproc
(directive) @attribute
(directive name: (identifier) @attribute)
(directive_arguments) @string.special

; Conditional directives (#HotIf / #if)
(if_directive) @attribute

; Functions
(function_definition name: (identifier) @function)
(function_call name: (identifier) @function)

; Fat-arrow function definitions (anonymous closures)
; When used as an expression, the parens highlight as punctuation

; Member expressions - property access
(member_expression property: (identifier) @property)

; Method calls
(method_call method: (identifier) @function.method)

; Class references (PascalCase or _PascalCase) in method calls and member expressions
(method_call object: (identifier) @type
 (#match? @type "^_?[A-Z]"))

(member_expression object: (identifier) @type
 (#match? @type "^_?[A-Z]"))

; Standalone flow control and keywords
((identifier) @keyword
 (#match? @keyword "^(?i)(Reload|Exit|ExitApp|Pause|Suspend|unset)$"))

; Built-in functions (v2 - everything is a function)
; GUI and dialog
((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(MsgBox|InputBox|ToolTip|TrayTip|Progress|Gui|GuiCtrlFromHwnd|GuiFromHwnd)$"))

; Input/Output
((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(Send|SendInput|SendRaw|SendEvent|SendPlay|SendLevel|SendText|Click|MouseClick|MouseClickDrag|MouseGetPos|MouseMove|KeyWait|InputHook|Hotkey|HotIf|HotIfWinActive|HotIfWinExist|HotIfWinNotActive|HotIfWinNotExist|HotString)$"))

; Flow control
((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(Sleep|SetTimer|Pause|Suspend|Thread|Run|RunWait|RunAs|Reload|ExitApp|Exit|Shutdown|OnExit|OnError|OnMessage|CallbackCreate)$"))

; Window management
((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(WinActivate|WinActivateBottom|WinWait|WinWaitActive|WinWaitClose|WinClose|WinKill|WinMinimize|WinMaximize|WinRestore|WinMinimizeAll|WinMinimizeAllUndo|WinHide|WinShow|WinMove|WinSetTitle|WinMenuSelectItem|WinSetTransparent|WinSetTransColor|WinSetExStyle|WinSetStyle|WinSetAlwaysOnTop|WinSetEnabled|WinSetRegion|WinRedraw)$"))

((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(WinGetID|WinGetIDLast|WinGetPID|WinGetProcessName|WinGetProcessPath|WinGetCount|WinGetList|WinGetMinMax|WinGetControls|WinGetControlsHwnd|WinGetPos|WinGetClientPos|WinGetTitle|WinGetClass|WinGetText|WinGetStyle|WinGetExStyle|WinGetTransparent|WinGetTransColor)$"))

((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(WinExist|WinActive)$"))

; Control
((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(ControlClick|ControlFocus|ControlGetChecked|ControlGetChoice|ControlGetEnabled|ControlGetExStyle|ControlGetFocus|ControlGetHwnd|ControlGetIndex|ControlGetItems|ControlGetPos|ControlGetStyle|ControlGetText|ControlGetVisible|ControlHide|ControlHideDropDown|ControlMove|ControlSend|ControlSendText|ControlSetChecked|ControlSetChoice|ControlSetEnabled|ControlSetExStyle|ControlSetStyle|ControlSetText|ControlSetVisible|ControlShow|ControlShowDropDown)$"))

; File operations
((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(FileRead|FileAppend|FileDelete|FileCopy|FileMove|FileCopyDir|FileMoveDir|FileCreateDir|FileRemoveDir|FileCreateShortcut|FileGetShortcut|FileGetAttrib|FileSetAttrib|FileGetSize|FileGetTime|FileSetTime|FileGetVersion|FileSelect|DirSelect|FileRecycle|FileRecycleEmpty|FileEncoding|FileOpen|FileGetShortcut)$"))

; Registry and INI
((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(RegRead|RegWrite|RegDelete|RegDeleteKey|RegCreateKey|IniRead|IniWrite|IniDelete)$"))

; String functions (v2 - functions not commands)
((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(StrLen|SubStr|InStr|RegExMatch|RegExReplace|StrReplace|StrSplit|StrLower|StrUpper|StrTitle|Trim|LTrim|RTrim|Format|FormatTime|Number|Integer|Float|String|Chr|Ord|Asc)$"))

; Math functions
((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(Abs|Ceil|Floor|Round|Mod|Sqrt|Sin|Cos|Tan|ASin|ACos|ATan|Log|Ln|Max|Min|Random)$"))

; Object/Array functions
((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(Type|IsSet|IsObject|HasBase|HasMethod|HasProp|ObjAddRef|ObjRelease|ObjGetBase|ObjSetBase|ObjGetCapacity|ObjSetCapacity|ObjOwnPropCount|ObjRawGet|ObjRawSet|ObjBindMethod|Array|Map|Object|Buffer|Error|OSError|MemoryError|TimeoutError|TypeError|ValueError|UnsetError|UnsetItemError|PropertyError|MethodError|IndexError|KeyError|MemberError|TargetError|ZeroDivisionError)$"))

; COM and DLL
((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(DllCall|ComCall|ComObject|ComObjActive|ComObjCreate|ComObjConnect|ComObjFlags|ComObjFromPtr|ComObjGet|ComObjQuery|ComObjType|ComObjValue|NumGet|NumPut|StrGet|StrPut|VarSetStrCapacity)$"))

; Misc
((function_call name: (identifier) @function.builtin)
 (#match? @function.builtin "^(?i)(DriveGetCapacity|DriveGetFileSystem|DriveGetLabel|DriveGetList|DriveGetSerial|DriveGetStatus|DriveGetStatusCD|DriveGetType|DriveSetLabel|DriveEject|PostMessage|SendMessage|ProcessClose|ProcessExist|ProcessGetName|ProcessGetParent|ProcessGetPath|ProcessSetPriority|ProcessWait|ProcessWaitClose|SysGet|SysGetIPAddresses|Shutdown|BlockInput|GroupActivate|GroupAdd|GroupClose|GroupDeactivate|KeyHistory|ListHotkeys|ListLines|ListVars|ClipWait|A_Clipboard|EnvGet|EnvSet|SoundBeep|SoundGetInterface|SoundGetMute|SoundGetName|SoundGetVolume|SoundPlay|SoundSetMute|SoundSetVolume)$"))

; Goto command (keyword-like)
((function_call name: (identifier) @keyword)
 (#match? @keyword "^(?i)(Goto|Gosub)$"))

; Standalone Goto
((identifier) @keyword
 (#match? @keyword "^(?i)(Goto|Gosub)$"))

; Standalone debug commands (highlighted as function.builtin)
((identifier) @function.builtin
 (#match? @function.builtin "^(?i)(KeyHistory|ListHotkeys|ListLines|ListVars)$"))

; Variable references %var%
(variable_ref (identifier) @variable)
(variable_ref "%" @punctuation.special)

; Built-in variables (via #match? - highlights identifiers matching A_* patterns)
; Script properties
((identifier) @variable.special
 (#match? @variable.special "^(?i)A_(ScriptDir|ScriptName|ScriptFullPath|ScriptHwnd|WorkingDir|InitialWorkingDir|Args|LineNumber|LineFile|ThisFunc|ThisLabel|AhkVersion|AhkPath|IsUnicode|IsCompiled|ExitReason)$"))

; Date and time
((identifier) @variable.special
 (#match? @variable.special "^(?i)A_(Now|NowUTC|YYYY|MM|DD|MMMM|MMM|DDDD|DDD|WDay|YDay|YWeek|Hour|Min|Sec|MSec|TickCount)$"))

; Script settings
((identifier) @variable.special
 (#match? @variable.special "^(?i)A_(IsSuspended|IsPaused|IsCritical|BatchLines|ListLines|TitleMatchMode|TitleMatchModeSpeed|DetectHiddenWindows|DetectHiddenText|AutoTrim|StringCaseSense|FileEncoding|FormatInteger|FormatFloat)$"))

((identifier) @variable.special
 (#match? @variable.special "^(?i)A_(SendMode|SendLevel|StoreCapsLockMode|KeyDelay|KeyDuration|KeyDelayPlay|KeyDurationPlay|WinDelay|ControlDelay|MouseDelay|MouseDelayPlay|DefaultMouseSpeed)$"))

((identifier) @variable.special
 (#match? @variable.special "^(?i)A_(CoordModeToolTip|CoordModePixel|CoordModeMouse|CoordModeCaret|CoordModeMenu|RegView|IconHidden|IconTip|IconFile|IconNumber)$"))

; User idle time
((identifier) @variable.special
 (#match? @variable.special "^(?i)A_(TimeIdle|TimeIdlePhysical|TimeIdleKeyboard|TimeIdleMouse)$"))

; OS and user info
((identifier) @variable.special
 (#match? @variable.special "^(?i)(A_ComSpec|ComSpec|A_Temp|A_OSType|A_OSVersion|A_Is64bitOS|A_PtrSize|A_Language|A_ComputerName|A_UserName|A_WinDir|A_ProgramFiles)$"))

((identifier) @variable.special
 (#match? @variable.special "^(?i)A_(AppData|AppDataCommon|Desktop|DesktopCommon|StartMenu|StartMenuCommon|Programs|ProgramsCommon|Startup|StartupCommon|MyDocuments|IsAdmin)$"))

((identifier) @variable.special
 (#match? @variable.special "^(?i)A_(ScreenWidth|ScreenHeight|ScreenDPI|IPAddress1|IPAddress2|IPAddress3|IPAddress4)$"))

; Special characters and misc
((identifier) @variable.special
 (#match? @variable.special "^(?i)(A_Space|A_Tab|A_Cursor|A_CaretX|A_CaretY|A_Clipboard|Clipboard|ClipboardAll|A_LastError|True|False)$"))

; Loop variables
((identifier) @variable.special
 (#match? @variable.special "^(?i)A_(Index|LoopFileName|LoopFileExt|LoopFileFullPath|LoopFileLongPath|LoopFileShortPath|LoopFileShortName|LoopFileDir)$"))

((identifier) @variable.special
 (#match? @variable.special "^(?i)A_(LoopFileTimeModified|LoopFileTimeCreated|LoopFileTimeAccessed|LoopFileAttrib|LoopFileSize|LoopFileSizeKB|LoopFileSizeMB)$"))

((identifier) @variable.special
 (#match? @variable.special "^(?i)A_(LoopRegName|LoopRegType|LoopRegKey|LoopRegSubKey|LoopRegTimeModified|LoopReadLine|LoopField)$"))

; Window matching criteria (WinTitle parameters)
((identifier) @constant.builtin
 (#match? @constant.builtin "^(?i)ahk_(id|class|exe|pid|group)$"))

; Labels
(label . (identifier) @label)

; Arrays
(array_literal "[" @punctuation.bracket)
(array_literal "]" @punctuation.bracket)
(index_expression "[" @punctuation.bracket)
(index_expression "]" @punctuation.bracket)

; Object literals
(object_literal "{" @punctuation.bracket)
(object_literal "}" @punctuation.bracket)
(object_property key: (identifier) @property)
(object_property key: (string) @property)
(object_property key: (number) @property)
(object_property ":" @punctuation.delimiter)

; Class definitions
(class_definition name: (identifier) @type)
(class_definition parent: (identifier) @type)
(class_definition "{" @punctuation.bracket)
(class_definition "}" @punctuation.bracket)

; Method definitions
(method_definition name: (identifier) @function.method)

; Special method names (constructor, destructor, meta-functions)
(method_definition
  name: (identifier) @function.special
  (#match? @function.special "^__(New|Delete|Get|Set|Call|Item|Enum)$"))

; Class properties
(class_property name: (identifier) @property)

; this and super keywords
(this_expression) @variable.special
(super_expression) @variable.special

; Variadic parameter marker
(parameter_variadic) @operator