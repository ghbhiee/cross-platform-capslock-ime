#Requires AutoHotkey v2.0
#SingleInstance Force

; Capture physical keyboard events reliably.
InstallKeybdHook

; Keep Caps Lock disabled as a letter-case toggle.
SetCapsLockState "AlwaysOff"

; Use the physical Caps Lock key as the Windows input-language switch.
; The key-down event is suppressed. On release, send Left Alt + Left Shift.
*SC03A::Return
*SC03A Up::
{
    SendEvent "{LAlt down}{LShift down}"
    Sleep 30
    SendEvent "{LShift up}{LAlt up}"
}

; Disable the mouse side buttons' default Back/Forward behavior globally.
; This helps prevent accidental navigation and loss of unsaved form input.
; Reuse the buttons for fast vertical scrolling instead.
XButton1::Send "{WheelDown 6}"
XButton2::Send "{WheelUp 6}"
