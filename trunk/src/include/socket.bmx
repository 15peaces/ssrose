Rem
	Copyright © 15peaces 2012 - 2013
endrem

'SuperStrict

Type socket_data
	Field client_addr:Int 'remote client address

	Field rdata:Int 'read data
	Field wdata:Int 'write data
	Field max_rdata:Int
	Field max_wdata:int
	Field rdata_size:int
	Field wdata_size:int
	Field rdata_pos:int
	Field rdata_tick:Int 'time of last recv (For detecting timeouts); zero when timeout is disabled

	 
	'TODO: RecvFunc func_recv;
	'TODO: SendFunc func_send;
	'TODO: ParseFunc func_parse;

	Field session_data:Int 'stores application-specific data related To the session
endtype

' Global array of sockets
' fd is the position in the array
Global sock_arr:TSocket[]
'MARK: Global sock_arr_len = 0 really needed? BlitzMax can calculate arraysizes using SizeOf()... [15peaces]

'/ Returns the socket associated with the target fd.
'/
'/ @param fd Target fd.
'/ @Return Socket
Function fd2sock:TSocket(fd:Int , array:TSocket[])
	Return(array[fd])
endfunction

'/ Returns the first fd associated with the socket.
'/ Returns -1 If the socket is Not found.
'/
'/ @param s Socket
'/ @Return Fd Or -1
Function sock2fd:Int(s:TSocket,array:TSocket[])
	Local fd:int
	'search For the socket
	For fd = 0 To SizeOf(array)
		If( sock_arr[fd] == s )
			Next
		endif
	next
	If(fd == SizeOf(array))
		Return(-1) 'Not found
	endif
	Return fd
endfunction