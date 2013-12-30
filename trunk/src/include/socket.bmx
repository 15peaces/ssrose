Rem
	Copyright © 15peaces 2012 - 2013
endrem

'SuperStrict

Type socket_data
	Field client_addr:Int 'remote client address

	Field rdata:Int 'read data
	Field wdata:Int 'write data
	Field max_rdata:Int
	Field max_wdata:Int
	Field rdata_size:Int
	Field wdata_size:Int
	Field rdata_pos:Int
	Field rdata_tick:Int 'time of last recv (For detecting timeouts); zero when timeout is disabled

	 
	'TODO: RecvFunc func_recv;
	'TODO: SendFunc func_send;
	'TODO: ParseFunc func_parse;

	Field session_data:Int 'stores application-specific data related To the session
EndType

' Global array of sockets
' fd is the position in the array
Global sock_arr:TSocket[]
'MARK: Global sock_arr_len = 0 really needed? BlitzMax can calculate arraysizes using SizeOf()... [15peaces]

' Maximum packet size in bytes, which the client is able To handle.
' Larger packets cause a buffer overflow And stack corruption.
Global socket_max_client_packet:int = 20480

' initial recv buffer size (this will also be the Max. size)
' biggest known packet: S 0153 <Len>.w <emblem data>.?B -> 24x24 256 color .bmp (0153 + Len.w + 1618/1654/1756 bytes)
Const RFIFO_SIZE:Int = 2048 '2+1024
' initial send buffer size (will be resized as needed)
Const WFIFO_SIZE:Int = 16384 '16*1024

' Maximum size of pending data in the write fifo. (For non-server connections)
' The connection is closed If it goes over the limit.
Const WFIFO_MAX:Int = 1048576 '1*1024*1024

'/ Returns the socket associated with the target fd.
'/
'/ @param fd Target fd.
'/ @Return Socket
Function fd2sock:TSocket(fd:Int , array:TSocket[])
	Return(array[fd])
EndFunction

'/ Returns the first fd associated with the socket.
'/ Returns -1 If the socket is Not found.
'/
'/ @param s Socket
'/ @Return Fd Or -1
Function sock2fd:Int(s:TSocket,array:TSocket[])
	Local fd:Int
	'search For the socket
	For fd = 0 To SizeOf(array)
		If( sock_arr[fd] = s )
			Next
		EndIf
	Next
	If(fd = SizeOf(array))
		Return(-1) 'Not found
	EndIf
	Return fd
EndFunction

'/ Inserts the socket into the Global array of sockets.
'/ Returns a New fd associated with the socket.
'/ If there are too many sockets it closes the socket, sets an error And 
'  returns -1 instead.
'/ Since fd 0 is reserved, it returns values in the range [1,FD_SETSIZE[.
'/
'/ @param s Socket
'/ @Return New fd Or -1
Function sock2newfd:Int(s:TSocket)
	Local fd:int

	' find an empty position
	For fd = 1 To fd < SizeOf(sock_arr); fd:+1 )
		If( sock_arr[fd] = False ) Then Next 'empty position
	If( fd = SizeOf(sock_arr) )
		CloseSocket(s) ;
		DebugLog(ShowDebug("Socket array-size overflow @ sock2newfd!"))
		Return -1
	endif
	
	sock_arr[fd] = s
	Return fd
endfunction

Function sAccept:Int(fd:int)
	Local s:tsocket

	'accept connection
	s = SocketAccept(fd2sock(fd))
	If(s = False) Then Return -1' error
	Return sock2newfd(s)
endfunction

Function sClose:Int(fd:int)
	ret:int = CloseSocket(fd2sock(fd))
	fd2sock(fd) = false
	Return ret
endfunction

Function sSocket:Int(protocol:Int = 0)
	Local s:tsocket

	'Create socket
	
	If(protocol = 1)
		s = CreateUDPSocket()
	else
		s = CreateTCPSocket()
	endif
	If( s = False) Then Return -1 'error
	Return sock2newfd(s);
endfunction