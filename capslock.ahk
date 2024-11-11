#Requires AutoHotkey v2.0
#SingleInstance Force

/*
Remaps Capslock to 3 functions:

Single press : Send Esc
Long single press : Toggle capslock state
Hold + key : Send Ctrl + key
*/

holdTime := 200
ih := InputHook("B L1 T1", "{Esc}")

*Capslock::
{
    ih.Start()
    reason := ih.Wait()
    if (reason = "Stopped") {
        if (A_TimeSincePriorHotkey > holdTime) {
            SetCapsLockState !GetKeyState("CapsLock", "T")
        } else {
            Send "{Esc}"
        }
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
