#SingleInstance Force

LastTime := 0 ; ms ; delta only
MaxTime := 300 ; ms
DashKey := "-"

ui := Gui("", "Overwatch Double Tap")
ui.AddLink("", 'Overwatch Double Tap <a href="https://github.com/lyricwulf/OverwatchDoubleTap">by LyricWulf</a>')
ui.Opt("+Resize +MinSize320x240")
ui.AddText("", "Remaps a double-tap of the spacebar to a unique hotkey in Overwatch.")
ui.AddText("", "Currently uses the dash (hyphen) as the hotkey.")

TextField := ui.AddText(, "Interval (ms):")
IntervalEdit := ui.AddEdit("vIntervalInput Number")
ui.AddUpDown("vIntervalUpDown Range0-1000", MaxTime)
IntervalEdit.OnEvent("Change", OnIntervalChange)
OnIntervalChange(*)
{
    global MaxTime := IntervalEdit.Value
}

CloseBtn := ui.AddButton("vCloseButton", "Close")
CloseBtn.OnEvent("Click", CloseBtn_Click)
CloseBtn_Click(*)
{
    ExitApp
}

ui.Show()

#HotIf WinActive("ahk_class TankWindowClass") or WinActive("ahk_exe Overwatch.exe")
$Space::{
    global LastTime
    global MaxTime
    global DashKey

    If (A_TickCount - LastTime) > MaxTime
    {
        LastTime := A_TickCount
        Send("{Space down}")
        KeyWait("Space") ; prevent repeats from holding down the key
        Send ("{Space up}")
        Return
    }

    LastTime := 0
    Send(DashKey)
}
#HotIf