#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#MaxThreadsPerHotkey 2
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

autoClick := false
swingDelay := 850
foodDelay := 20000  ; 2 minutes
foodEnable := true

;;;;GUI Setup;;;;
Gui, New, +AlwaysOnTop, Minecraft AutoClicker

Gui, Add, Text, vswingDelayText, Swing Delay: %swingDelay%ms
Gui, Add, Slider, vswingDelay gUpdateSwingDelay range200-1000 TickInterval50 AltSubmit, %swingDelay%

Gui, Add, Text, , Weapon Slot:
Gui, Add, DropDownList, vslotWeaponList gUpdateSlotWeapon, 1|2|3|4|5|6|7|8|9


Gui, Add, Text, , 

Gui, Add, Text, vfoodDelayText, Food Delay: %foodDelay%ms
Gui, Add, Slider, vfoodDelay gUpdatefoodDelay range5000-60000 TickInterval1000 AltSubmit, %foodDelay%

Gui, Add, Text, , Food Slot:
Gui, Add, DropDownList, vslotFoodList gUpdateSlotFood, 1|2|3|4|5|6|7|8|9


Gui, Add, Text, , 
Gui, Add, Text, , Start/Stop ctrl+I/ctrl+O
Gui, Add, Text, ,Emergency stop ctrl+P

Gui, Show, w200


;;;;Main Loop;;;;
Loop{
  if (autoClick){

    if (foodCounter >= (foodDelay / swingDelay) && (foodEnable == true)){
      Send, %slotFood%
      Click Down Right
      Sleep, 2000
      Click Up Right
      Send, %slotWeapon%
      foodCounter := 0
    }else{
      Send, %slotWeapon%
      Click
      Sleep, swingDelay
      foodCounter++
    }
  }else{
    Sleep, 100
    ; MsgBox, Test
  }
}


^o::
  ;MsgBox, %autoClick%
  autoClick := 0
  foodCounter := 0
return

^i::
  ;MsgBox, %autoClick%
  autoClick := 1
  foodCounter := 0
return

^p::
  ExitApp, 0
return

GuiClose:
  ExitApp
return


UpdateSwingDelay:
  GuiControlGet, swingDelay
  GuiControl, , swingDelayText, Swing Delay: %swingDelay%ms
return

UpdateFoodDelay:
  GuiControlGet, foodDelay
  GuiControl, , foodDelayText, Food Delay: %foodDelay%ms
return

UpdateSlotWeapon:
  GuiControlGet, slotWeaponList
  slotWeapon := slotWeaponList
return

UpdateSlotFood:
  GuiControlGet, slotFoodList
  slotFood := slotFoodList
return