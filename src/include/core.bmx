Rem
	Copyright © 15peaces 2012 - 2013
endrem

'SuperStrict

Import "mmo.bmx"

'TODO: ALLE SERVER_STATE 's durch int variablen ersetzen!

Const SERVER_STATE_STOP:Int = 1
Const SERVER_STATE_RUN:Int = 2
Const SERVER_STATE_SHUTDOWN:int = 3

Rem
Extern arg_c:int
Extern char **arg_v;
Extern Int runflag;
Extern char *SERVER_NAME;
Extern char SERVER_TYPE;

Extern Int parse_console(Const char* buf);
Extern Const char *get_svn_revision(void);
Extern Int do_init(Int,char**);
Extern void set_server_type(void);
Extern void do_shutdown(void);
Extern void do_abort(void);
Extern void do_final(void) ;
endrem