' simulate_block_all_monitors.vbs
Option Explicit

Dim ie, duration
duration = 20

' Create Internet Explorer window
Set ie = CreateObject("InternetExplorer.Application")
ie.ToolBar = 0
ie.StatusBar = 0
ie.AddressBar = 0
ie.Width = GetScreenWidth()
ie.Height = GetScreenHeight()
ie.Left = 0
ie.Top = 0
ie.Visible = True
ie.Resizable = False

' Write HTML content with countdown and ESC key handling
ie.Document.Write "<html><body style='background:black;color:white;font-family:Segoe UI;text-align:center;margin-top:150px;'>" & _
                  "<h1>INPUT SIMULATION — Disabled for:</h1>" & _
                  "<h1 id='counter' style='color:red;font-size:120px;'>" & duration & "</h1>" & _
                  "<p style='color:lightgray;font-size:16px;'>Press ESC to stop immediately.</p>" & _
                  "<script>" & _
                  "var dur=" & duration & ";" & _
                  "document.onkeydown = function(e){ if(e.keyCode==27){window.close();} };" & _
                  "setInterval(function(){ dur--; if(dur<0){window.close();} else{ document.getElementById('counter').innerHTML=dur;} },1000);" & _
                  "</script>" & _
                  "</body></html>"

' Wait until window is closed
Do While ie.Visible
    WScript.Sleep 100
Loop

' Clean up
Set ie = Nothing

' Functions to get screen size
Function GetScreenWidth()
    Dim wsh
    Set wsh = CreateObject("WScript.Shell")
    GetScreenWidth = CreateObject("WScript.Shell").RegRead("HKCU\Control Panel\Desktop\ScreenSaveActive") ' fallback
    GetScreenWidth = 800 ' fallback if registry fails
End Function

Function GetScreenHeight()
    GetScreenHeight = 600 ' fallback
End Function
