Rem
	Copyright © 15peaces 2012 - 2013
endrem

'SuperStrict

Import "mmo.bmx"
Import "showmsg.bmx"
Import "socket.bmx"

Rem
// generate a hex dump of the first 'length' bytes of 'buffer'
void WriteDump(FILE* fp, const void* buffer, size_t length);
void ShowDump(const void* buffer, size_t length);

void findfile(const char *p, const char *pat, void (func)(const char*));
bool exists(const char* filename);
size_t filesize(FILE* fp);

//Caps values to min/max
#define cap_value(a, min, max) ((a >= max) ? max : (a <= min) ? min : a)

/// calculates the value of A / B, in percent (rounded down)
unsigned int get_percentage(const unsigned int A , const unsigned int B) ;
endrem