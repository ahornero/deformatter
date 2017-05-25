; Deformatter2.ahk - Press Ctrl-Shift-V to paste text without format.
; Alberto Hornero, 2017

;SingleInstance force
SetBatchLines,-1

applicationname = Deformatter
Gosub,TRAYMENU

$^+v::
ClipSaved := ClipboardAll	; Save the entire clipboard
clipboard := clipboard		; Convert any copied files, HTML, or other formatted text to plain text
Send ^v						; Paste the text
Sleep, 250					; Give some time for the text to be pasted.
Clipboard := ClipSaved  	; Restore the original clipboard contents
Return

TRAYMENU:
Menu,Tray,NoStandard 
Menu,Tray,DeleteAll 
Menu,Tray,Add,%applicationname%,ABOUT
Menu,Tray,Add,
Menu,Tray,Add,&About...,ABOUT
Menu,Tray,Add,E&xit,EXIT
Menu,Tray,Default,%applicationname%
Menu,Tray,Tip,%applicationname%
Return

ABOUT:
Gui,99:Destroy
Gui,99:Margin,20,20
Gui,99:Font,Bold
Gui,99:Add,Text,x+10 yp+10,%applicationname% v2.0
Gui,99:Font
Gui,99:Add,Text,y+10,Press Ctrl-Shift-V to paste text without format, like Chromium / Google Chrome.
Gui,99:Font,CBlue Underline
Gui,99:Add,Text,y+10 GURL,github.com/ahornero/deformatter
Gui,99:Font

Gui,99:Show,,%applicationname%
hCurs:=DllCall("LoadCursor","UInt",NULL,"Int",32649,"UInt") ;IDC_HAND
OnMessage(0x200,"WM_MOUSEMOVE") 
Return

URL:
  Run,https://github.com/ahornero/deformatter,,UseErrorLevel
Return

WM_MOUSEMOVE(wParam,lParam)
{
  Global hCurs
  MouseGetPos,,,,ctrl
  If ctrl in Static3
    DllCall("SetCursor","UInt",hCurs)
  Return
}
Return

EXIT:
ExitApp