Rem
	Copyright © 15peaces 2012 - 2013
endrem

Extern "Win32"
	Function SetConsoleTextAttribute:Int(hConsoleOutput:Int Ptr,wAttributes:Int)
	Function GetStdHandle:Int Ptr(nStdHandle:Int)
End Extern

Const STD_OUTPUT_HANDLE:Int	= -11
Const CL_RESET:Int			= $0008

'#define CL_CLS		"\033[2J"
'#define CL_CLL		"\033[K"


' font settings
'const CL_BOLD		"\033[1m"
Const CL_NORM:Int		= $0008
Const CL_NORMAL:Int	= $0008
Const CL_NONE:Int		= $0008

' foreground color And bold font (bright color on windows)
Const CL_BLACK:Int		= $0000
Const CL_BLUE:Int 		= $0001
Const CL_GREEN:Int 	= $0002 
Const CL_CYAN:Int 		= $0003
Const CL_RED:Int		= $0004
Const CL_MAGENTA:Int	= $0005
Const CL_YELLOW:Int 	= $0006
Const CL_GREY:Int 		= $0007
Const CL_WHITE:Int 	= $0008

' background color
Const CL_BG_BLACK:Int	= $0000
Const CL_BG_BLUE:Int 	= $0001
Const CL_BG_GREEN:Int 	= $0002 
Const CL_BG_CYAN:Int 	= $0003
Const CL_BG_RED:Int	= $0004
Const CL_BG_MAGENTA:Int	= $0005
Const CL_BG_YELLOW:Int 	= $0006
Const CL_BG_GREY:Int 	= $0007
Const CL_BG_WHITE:Int 	= $0008

' foreground color And normal font (normal color on windows)
Const CL_LT_BLACK:Int	= $0000
Const CL_LT_BLUE:Int 	= $0001
Const CL_LT_GREEN:Int 	= $0002 
Const CL_LT_CYAN:Int 	= $0003
Const CL_LT_RED:Int	= $0004
Const CL_LT_MAGENTA:Int	= $0005
Const CL_LT_YELLOW:Int 	= $0006
Const CL_LT_GREY:Int 	= $0007
Const CL_LT_WHITE:Int 	= $0008

' foreground color And bold font (bright color on windows)
Const CL_BT_BLACK:Int	= $0000
Const CL_BT_BLUE:Int 	= $0001
Const CL_BT_GREEN:Int 	= $0002 
Const CL_BT_CYAN:Int 	= $0003
Const CL_BT_RED:Int	= $0004
Const CL_BT_MAGENTA:Int	= $0005
Const CL_BT_YELLOW:Int 	= $0006
Const CL_BT_GREY:Int 	= $0007
Const CL_BT_WHITE:Int 	= $0008

'#define CL_WTBL			"\033[37;44m"	// white on blue
'#define CL_XXBL			"\033[0;44m"	// Default on blue
'#define CL_PASS			"\033[0;32;42m"	// green on green

Const CL_SPACE:String = "           "	' space aquivalent of the Print messages

Const MSG_NONE:Int			 = 0
Const MSG_STATUS:Int		 = 1
Const MSG_SQL:Int			 = 2
Const MSG_INFORMATION:Int	 = 3
Const MSG_NOTICE:Int		 = 4
Const MSG_WARNING:Int		 = 5
Const MSG_DEBUG:Int		 = 6
Const MSG_ERROR:Int		 = 7
Const MSG_FATALERROR:Int	 = 8

Const DEBUGLOGMAP:String		 = "log\map-server.log"
Const DEBUGLOGCHAR:String	 = "log\char-server.log"
Const DEBUGLOGLOGIN:String	 = "log\login-server.log"

global msg_silent:Int = 0 'Specifies how silent the console is.

Function SetConsoleColor(Color:Int,Background:Int = False)
	If Background = True Then Color:*$0010
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),Color)	
End Function

Function _vShowMessage:Int(flag:Int, str:String = "")
	Local prefix:string
	
	If(str = "")
		ShowError("Empty string passed to _vShowMessage().~n")
		Return 1
	endif
	
	If((flag = MSG_INFORMATION And msg_silent = 1) Or (flag = MSG_STATUS And msg_silent=2) Or (flag = MSG_NOTICE And msg_silent=4) Or (flag = MSG_WARNING And msg_silent=8) Or (flag = MSG_ERROR And msg_silent=16) Or (flag = MSG_SQL And msg_silent=16) Or (flag = MSG_DEBUG And msg_silent=32)) Then Return 0 'Do Not Print it.

	select(flag)
		Case MSG_NONE ' direct print replacement
			prefix = ""
		Case MSG_STATUS 'Bright Green (To inform about good things)
			prefix = "[Status]"
		Case MSG_SQL 'Bright Violet (For dumping out anything related with SQL) <- Actually, this is mostly used For SQL errors with the database, as successes can as well just be anything Else... [Skotlex]
			prefix = "[SQL]"
		Case MSG_INFORMATION 'Bright White (Variable information)
			prefix = "[Info]"
		Case MSG_NOTICE 'Bright White (Less than a warning)
			prefix = "[Notice]"
		Case MSG_WARNING 'Bright Yellow
			prefix = "[Warning]"
		Case MSG_DEBUG 'Bright Cyan, important stuff!
			prefix = "[Debug]"
		Case MSG_ERROR 'Bright Red  (Regular errors)
			prefix = "[Error]"
		Case MSG_FATALERROR 'Bright Red (Fatal errors, abort(); If possible)
			prefix = "[Fatal Error]"
		Default
			ShowError("In function _vShowMessage() -> Invalid flag passed.~n")
			Return 1
	endselect

	Print SetConsoleColor(flag)+prefix+SetConsoleColor(CL_RESET)+": "+str

	Return 0
endfunction

Function ShowMessage:Int(mes:String)
	Return(_vShowMessage(MSG_NONE, mes))
endfunction

Function ShowStatus:Int(mes:string)
	Return(_vShowMessage(MSG_STATUS, mes))
endfunction

Function ShowSQL:Int(mes:string)
	Return(_vShowMessage(MSG_SQL, mes))
endfunction

Function ShowInfo:Int(mes:string)
	Return(_vShowMessage(MSG_INFORMATION, mes))
endfunction

Function ShowNotice:Int(mes:string)
	Return(_vShowMessage(MSG_NOTICE, mes))
endfunction

Function ShowWarning:Int(mes:string)
	Return(_vShowMessage(MSG_WARNING, mes))
endfunction

Function ShowDebug:Int(mes:string)
	Return(_vShowMessage(MSG_DEBUG, mes))
endfunction

Function ShowError:Int(mes:String)
	Return(_vShowMessage(MSG_ERROR, mes))
endfunction

Function ShowFatalError:Int(mes:string)
	Return(_vShowMessage(MSG_FATALERROR, mes))
endfunction