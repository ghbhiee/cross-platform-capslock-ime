#Requires AutoHotkey v2.0
#SingleInstance Force

; Author: guohongbo <guohongbo@outlook.com>

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

; Make punctuation mode persistent across applications.
; This hotkey is active only while the Simplified Chinese input layout is active.
#HotIf IsSimplifiedChineseLayoutActive()
^.::
{
    TogglePersistentPunctuation()
}
#HotIf

IsSimplifiedChineseLayoutActive()
{
    activeWindow := WinExist("A")
    if !activeWindow
        return false

    processId := 0
    threadId := DllCall(
        "GetWindowThreadProcessId",
        "Ptr", activeWindow,
        "UInt*", &processId,
        "UInt"
    )
    keyboardLayout := DllCall("GetKeyboardLayout", "UInt", threadId, "UPtr")
    return (keyboardLayout & 0xFFFF) = 0x0804
}

TogglePersistentPunctuation()
{
    static settingsKey := "HKCU\Software\Microsoft\InputMethod\Settings\CHS"
    static valueName := "UseEnglishPunctuationsInChineseInputMode"

    currentValue := RegRead(settingsKey, valueName, 0)
    newValue := currentValue ? 0 : 1
    RegWrite newValue, "REG_DWORD", settingsKey, valueName

    ; Microsoft Pinyin does not reliably notice a direct registry write.
    ; Request English US, then Simplified Chinese, for the active window.
    activeWindow := WinExist("A")
    if activeWindow
    {
        windowSelector := "ahk_id " activeWindow
        PostMessage 0x0050, 0, 0x04090409, , windowSelector
        Sleep 50
        PostMessage 0x0050, 0, 0x08040804, , windowSelector
    }

    if newValue
        ToolTip "Punctuation: English  , . ! ?"
    else
        ToolTip "Punctuation: Chinese  ，。！？"

    SetTimer HidePunctuationToolTip, -1200
}

HidePunctuationToolTip()
{
    ToolTip
}
