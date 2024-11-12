#Requires AutoHotkey v2.0
#SingleInstance Force

/*
Remaps Capslock to 2 functions:
Single press => Send Esc
Hold + key => Send Ctrl + key
*/

ih := InputHook("B L1 T1", "{Esc}")

*Capslock::
{
    ih.Start()
    reason := ih.Wait()
    if (reason = "Stopped") {
        Send "{Esc}"
    } else if (reason = "Max") {
        Send "{Blind}{Ctrl down}" ih.Input
    }
}

*Capslock up::
{
    if (ih.InProgress) {
        ih.Stop()
    } else {
        Send "{Ctrl up}"
    }
}

; Press both shift keys to toggle caps lock
<+RShift::
>+LShift::
{
    SetCapsLockState !GetKeyState("CapsLock", "T")
}
