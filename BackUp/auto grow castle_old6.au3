#include <ImageSearch.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <WindowsConstants.au3>
#RequireAdmin

HotKeySet("{Space}", "thoat")
HotKeySet("{F1}", "di_ai")
HotKeySet("{F2}", "click_quang_cao")

#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Main = GUICreate("Auto Grow Castle", 383, 179, 982, 247)
GUISetFont(12, 400, 0, "Tahoma")
$Label1 = GUICtrlCreateLabel("Bấm F1 để đi ải", 16, 40, 114, 23)
$Label2 = GUICtrlCreateLabel("Bấm F2 để click quảng cáo", 176, 40, 192, 23)
$Label3 = GUICtrlCreateLabel("Bấm Space để thoát", 80, 112, 142, 23)
$status = _GUICtrlStatusBar_Create($Main)
_GUICtrlStatusBar_SetText($status,"Vui lòng chọn chế độ auto")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd


Func di_ai()
	While 1
		Start_KoPlayer()
		check_toa_do_cua_so()
		Sleep(1000)
		$b = check_home()
		Sleep(1000)
		If $b = 1 Then
			$checkads = click_ads() ;kiem tra xem co ads ko
			If $checkads = 1 Then close_ads()
			Sleep(1000)
			Click_battle() ;vao tran
			Sleep(1000)
			Speed()
			Sleep(1000)
			skill()
			Sleep(1000)
		Else
			Start_game()
			Sleep(1000)
		EndIf
	WEnd
EndFunc   ;==>di_ai

Func click_quang_cao()
	While 1
		Start_KoPlayer()
		check_toa_do_cua_so()
		$b = check_home()
		Sleep(1000)
		If $b = 1 Then
			;click_ads()
			Click_battle() ;vao tran
			Sleep(2000)
			Speed()
			Sleep(2000)
			skill()
			Sleep(2000)
			$checkads = click_ads() ;kiem tra xem co ads ko
			Sleep(2000)
			If $checkads = 1 Then
				close_ads()
				Sleep(1000)
				ControlSend("KOPLAYER 1.4.1055", 0, 0, "{ESC}")
				Sleep(2000)
				ControlClick("KOPLAYER 1.4.1055", 0, 0, "left", 1, 386, 513 + 15)
				_GUICtrlStatusBar_SetText($status,"Khởi động lại game")
			EndIf
		Else
			Start_game()
			Sleep(1000)
		EndIf
	WEnd
EndFunc   ;==>click_quang_cao


Func Start_KoPlayer()
	$hWnd = WinExists("KOPLAYER 1.4.1055")
	If $hWnd <> 1 Then
		ShellExecute("D:\KOPLAYER\Lancher.exe", @SW_MAXIMIZE)
		_GUICtrlStatusBar_SetText($status,"Đợi 15s de khởi động Koplayer")
		ConsoleWrite("Doi 15s de khoi dong Koplayer" & @CRLF)
		Sleep(15000)
	EndIf
EndFunc   ;==>Start_KoPlayer

Func Start_game()
	Do
		Local $x = 0, $y = 0
		Local $search = _ImageSearch("checkloadgame.bmp", 1, $x, $y, 0)
		ConsoleWrite("dang check" & @CRLF)
		If $search = 1 Then
			ConsoleWrite("Game chua mo" & @CRLF)
			ControlClick("KOPLAYER 1.4.1055", 0, 0, "left", 1, $x, $y)
			ConsoleWrite("Click vao icon game" & @CRLF)
			Sleep(15000)
		Else
			Local $a = check_home()
			If $a = 1 Then
				ConsoleWrite("Da vao game" & @CRLF)
				ExitLoop
			EndIf
			Sleep(2000)
		EndIf
	Until $search = 1
	Sleep(10)
EndFunc   ;==>Start_game

Func check_home()
	Local $x = 0, $y = 0
	Local $search6 = _ImageSearchArea("home.bmp", 1, 76, 83, 186, 143, $x, $y, 0)
	If $search6 = 1 Then
		ConsoleWrite("Da vao man hinh home" & @CRLF)
		_GUICtrlStatusBar_SetText($status,"Đã vào màn hình home")
		Return 1
	Else
		ConsoleWrite("Chua vao man hinh home" & @CRLF)
		Return 0
	EndIf
	Sleep(10)
EndFunc   ;==>check_home

Func Click_battle()
	Local $x = 0, $y = 0
	Local $search2 = _ImageSearchArea("battle.bmp", 1, 868, 577, 1011, 628, $x, $y, 0)
	If $search2 = 1 Then
		ConsoleWrite("thay battle,click vao battle" & @CRLF)
		ControlClick("KOPLAYER 1.4.1055", 0, 0, "left", 1, $x, $y)
		sleep(100)
		;ControlClick("KOPLAYER 1.4.1055", 0, 0, "left", 1, 713, 236+30)
		_GUICtrlStatusBar_SetText($status,"Trong trận")
		Sleep(1000)
	Else
		ConsoleWrite("ko thay battle" & @CRLF)
	EndIf
	Sleep(10)
EndFunc   ;==>Click_battle

Func skill()
	While 1
		Local $x = 0, $y = 0
		Local $a = 0, $b = 0
		Local $search3 = _ImageSearchArea("skill.bmp", 1, 205, 79, 395, 334, $x, $y, 0)
		Sleep(100)
		If $search3 = 1 Then
			ConsoleWrite("dung skill" & @CRLF)
			Sleep(100)
			ControlClick("KOPLAYER 1.4.1055", 0, 0, "left", 1, $x, $y)
			Sleep(100)
			Local $search7 = _ImageSearch("battle.bmp", 1, $a, $b, 0)
			Sleep(100)
			If $search7 = 1 Then ExitLoop
		EndIf
		Sleep(100)
	WEnd
EndFunc   ;==>skill

Func click_ads()
	Local $x, $y
	$search4 = _ImageSearchArea("clickads.bmp", 1, 427, 490, 574, 592, $x, $y, 0)
	If $search4 = 1 Then
		ConsoleWrite("click ads" & @CRLF)
		ControlClick("KOPLAYER 1.4.1055", 0, 0, "left", 1, $x + 20, $y)
		_GUICtrlStatusBar_SetText($status,"Đang xem quảng cáo")
		Return 1
		Sleep(25000)
	Else
		;Return 0
		ConsoleWrite("ko thay ads" & @CRLF)
	EndIf
	Sleep(10)
EndFunc   ;==>click_ads


Func close_ads() ;close ads
	Local $x = 0, $y = 0
	Do
		$search5 = _ImageSearchArea("closeads.bmp", 1, 892, 42, 1029, 140, $x, $y, 0)
		If $search5 = 1 Then
			ConsoleWrite("close ads" & @CRLF)
			ControlClick("KOPLAYER 1.4.1055", 0, 0, "left", 1, $x, $y)
			_GUICtrlStatusBar_SetText($status,"Đã tắt quảng cáo")
			Sleep(1000)
		Else
			$search5 = _ImageSearchArea("ads2.bmp", 1, 915, 28, 1040, 137, $x, $y, 0)
			If $search5 = 1 Then
			ConsoleWrite("kiem tra ads 2" & @CRLF)
			ControlClick("KOPLAYER 1.4.1055", 0, 0, "left", 1, $x, $y)
			_GUICtrlStatusBar_SetText($status,"Đã tắt quảng cáo")
			EndIf
		EndIf
		Sleep(1000)
	Until $search5 = 1
EndFunc   ;==>close_ads

Func Speed()
	Local $x = 0, $y = 0
	$search6 = _ImageSearchArea("speed.bmp", 1, 10, 596, 77, 633, $x, $y, 0)
	If $search6 = 1 Then
		ConsoleWrite("speed x1,chuyen qua x2" & @CRLF)
		ControlClick("KOPLAYER 1.4.1055", 0, 0, "left", 1, 50, 553 + 20)
	EndIf
	Sleep(10)
EndFunc   ;==>Speed

Func check_toa_do_cua_so()
	Local $aPos = WinGetPos("KOPLAYER 1.4.1055")
	If $aPos[0] <> 0 And $aPos[1] <> 0 Then
		ConsoleWrite("vi tri cua so ko dung" & @CRLF)
		WinMove("KOPLAYER 1.4.1055", 0, 0, 0, 1088, 640)
		_GUICtrlStatusBar_SetText($status,"Đã chỉnh lại vị trí Koplayer")
		ConsoleWrite("da chinh lai vi tri moi" & @CRLF)
	Else
		ConsoleWrite("vi tri da chinh" & @CRLF)
	EndIf
EndFunc   ;==>check_toa_do_cua_so


Func thoat()
	Exit
	Sleep(10)
EndFunc   ;==>thoat
















