#Requires AutoHotkey v2.0
#SingleInstance Force

/*
Remaps Capslock to 3 functions:

Single press : Send Esc
Double tap : Toggle capslock state
Hold + key : Send Ctrl + key
*/

ih := InputHook("B L1 T1", "{Esc}")

*Capslock::
{
    if (A_TimeSincePriorHotkey && A_TimeSincePriorHotkey < 150) {
        SetCapsLockState !GetKeyState("CapsLock", "T")
    } else {
        ih.Start()
        reason := ih.Wait()
        if (reason = "Stopped") {
            Send "{Esc}"
        } else if (reason = "Max") {
            Send "{Blind}{Ctrl down}" ih.Input
        }
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
