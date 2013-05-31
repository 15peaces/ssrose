Rem
	Copyright © 15peaces 2012 - 2013
endrem

'SuperStrict

Rem
	// server->client protocol version
	//        0 - pre-?
	//        1 - ?                    - 0x196
	//        2 - ?                    - 0x78, 0x79
	//        3 - ?                    - 0x1c8, 0x1c9, 0x1de
	//        4 - ?                    - 0x1d7, 0x1d8, 0x1d9, 0x1da
	//        5 - 2003-12-18aSakexe+   - 0x1ee, 0x1ef, 0x1f0, ?0x1c4, 0x1c5?
	//        6 - 2004-03-02aSakexe+   - 0x1f4, 0x1f5
	//        7 - 2005-04-11aSakexe+   - 0x229, 0x22a, 0x22b, 0x22c
	// 20061023 - 2006-10-23aSakexe+   - 0x6b, 0x6d
	// 20070521 - 2007-05-21aSakexe+   - 0x283
	// 20070821 - 2007-08-21aSakexe+   - 0x2c5
	// 20070918 - 2007-09-18aSakexe+   - 0x2d7, 0x2d9, 0x2da
	// 20071106 - 2007-11-06aSakexe+   - 0x78, 0x7c, 0x22c
	// 20080102 - 2008-01-02aSakexe+   - 0x2ec, 0x2ed , 0x2ee
	// 20081126 - 2008-11-26aSakexe+   - 0x1a2
	// 20090408 - 2009-04-08aSakexe+   - 0x44a (dont use as it overlaps with RE client packets)
	// 20080827 - 2008-08-27aRagexeRE+ - First RE Client
	// 20081217 - 2008-12-17aRagexeRE+ - 0x6d (Note: This one still use old Char Info Packet Structure)
	// 20081218 - 2008-12-17bRagexeRE+ - 0x6d (Note: From this one client use New Char Info Packet Structure)
	// 20090603 - 2009-06-03aRagexeRE+ - 0x7d7, 0x7d8, 0x7d9, 0x7da
	// 20090617 - 2009-06-17aRagexeRE+ - 0x7d9
	// 20090922 - 2009-09-22aRagexeRE+ - 0x7e5, 0x7e7, 0x7e8, 0x7e9
	// 20091103 - 2009-11-03aRagexeRE+ - 0x7f7, 0x7f8, 0x7f9
	// 20100105 - 2010-01-05aRagexeRE+ - 0x133, 0x800, 0x801
	// 20100126 - 2010-01-26aRagexeRE+ - 0x80e
	// 20100223 - 2010-02-23aRagexeRE+ - 0x80f
	// 20100413 - 2010-04-13aRagexeRE+ - 0x6b
	// 20100629 - 2010-06-29aRagexeRE+ - 0x2d0, 0xaa, 0x2d1, 0x2d2
	// 20100721 - 2010-07-21aRagexeRE+ - 0x6b, 0x6d
	// 20100727 - 2010-07-27aRagexeRE+ - 0x6b, 0x6d
	// 20100803 - 2010-08-03aRagexeRE+ - 0x6b, 0x6d, 0x827, 0x828, 0x829, 0x82a, 0x82b, 0x82c, 0x842, 0x843
	// 20101124 - 2010-11-24aRagexeRE+ - 0x856, 0x857, 0x858
	// 20110111 - 2011-01-11aRagexeRE+ - 0x6b, 0x6d
	// 20110928 - 2011-09-28aRagexeRE+ - 0x6b, 0x6d
	// 20111025 - 2011-10-25aRagexeRE+ - 0x6b, 0x6d
	// 20120307 - 2012-03-07aRagexeRE+ - 0x970
endrem

Const DEF_PACKETVER:Int = 20120410

'backward compatible PACKETVER 8 And 9
Global packetver:Int = DEF_PACKETVER

If DEF_PACKETVER = 8 Then packetver = 20070521
If DEF_PACKETVER = 9 Then packetver = 20071106

'Remove/Comment this line To disable sc_data saving.
Const ENABLE_SC_SAVING:Int = True 

'Remove/Comment this line To disable server-side hot-key saving support
'Note that newer clients no longer save hotkeys in the registry!
Const HOTKEY_SAVING:Int = True

'The number is the Max number of hotkeys To save
Global max_hotkeys:Int
If packetver < 20090603
	'(27 = 9 skills x 3 bars)(0x02b9,191)
	max_hotkeys = 27
ElseIf packetver < 20090617
	'(36 = 9 skills x 4 bars)(0x07d9,254)
	max_hotkeys = 36
Else
	'(38 = 9 skills x 4 bars & 2 Quickslots)(0x07d9,268)
	max_hotkeys = 38
EndIf

Const MAX_MAP_PER_SERVER:Int	 = 1500
Const MAX_INVENTORY:Int		 = 100
Const MAX_CHARS:Int		 = 9 'Max number of characters per account. Note that changing this setting alone is Not enough If the client is Not hexed To support more characters as well.
'Number of slots carded equipment can have. Never set To less than 4 as they are also used To keep the data of forged items/equipment.
'Note: The client seems unable To receive data For more than 4 slots due To all related packets having a fixed size.
Const MAX_SLOTS:Int		 = 4
Const MAX_AMOUNT:Int		 = 30000 'Max amount of a single stacked item
Const MAX_ZENY:Int			 = 1000000000
Const MAX_FAME:Int			 = 1000000000
Const MAX_CART:Int			 = 100
Const MAX_SKILL:Int		 = 3036
Const GLOBAL_REG_NUM:Int	 = 256
Const ACCOUNT_REG_NUM:Int	 = 64
Const ACCOUNT_REG2_NUM:Int	 = 16
Const MAX_REG_NUM:Int		 = 256 'Should hold the Max of Global/ACCOUNT/ACCOUNT2 (needed For some arrays that hold all three)
Const DEFAULT_WALK_SPEED:Int	 = 150
Const MIN_WALK_SPEED:Int	 = 0
Const MAX_WALK_SPEED:Int	 = 1000
Const MAX_STORAGE:Int		 = 600
Const MAX_GUILD_STORAGE:Int	 = 600
Const MAX_PARTY:Int		 = 12
Const MAX_GUILD:Int		 = 76 '16+10*6
Const MAX_GUILDPOSITION:Int	 = 20
Const MAX_GUILDEXPULSION:Int	 = 32
Const MAX_GUILDALLIANCE:Int	 = 16
Const MAX_GUILDSKILL:Int	 = 15
Const MAX_GUILDCASTLE:Int	 = 34
Const MAX_GUILDLEVEL:Int	 = 50
Const MAX_GUARDIANS:Int		 = 8	'Local Max per castle.
Const MAX_QUEST_DB:Int		 = 2000 'Max quests that the server will Load
Const MAX_QUEST_OBJECTIVES:Int= 3 'Max quest objectives For a quest

'For produce
Const MIN_ATTRIBUTE:Int		 = 0
Const MAX_ATTRIBUTE:Int		 = 4
Const ATTRIBUTE_NORMAL:Int	 = 0
Const MIN_STAR:Int			 = 0
Const MAX_STAR:Int			 = 3

Const MAX_STATUS_TYPE:Int = 5

Const WEDDING_RING_M:Int = 2634
Const WEDDING_RING_F:Int = 2635

'For character names, title names, guilds, maps, etc.
'Includes Null-terminator as it is the length of the array.
Const NAME_LENGTH:Int		 = 24 '(23 + 1)
'For item names, which tend To have much longer names.
Const ITEM_NAME_LENGTH:Int	 = 50
'For Map Names, which the client considers To be 16 in length including the .gat extension
Const MAP_NAME_LENGTH:Int	 = 12 '(11 + 1)
Global map_name_length_ext:Int= MAP_NAME_LENGTH + 4

Const MAX_FRIENDS:Int	 = 40
Const MAX_MEMOPOINTS:Int = 3

'Size of the fame list arrays.
Const MAX_FAME_LIST:Int = 10

'Limits To avoid ID collision with other game objects
Const START_ACCOUNT_NUM:Int		 = 2000000
Const END_ACCOUNT_NUM:Int		 = 100000000
Const define START_CHAR_NUM:Int	 = 150000

'Guilds
Const MAX_GUILDMES1:Int = 60
Const MAX_GUILDMES2:Int = 120

'Base Homun skill.
Const HM_SKILLBASE:Int			 = 8001
Const MAX_HOMUNSKILL:Int		 = 16
Const MAX_HOMUNCULUS_CLASS:Int	 = 16
Const HM_CLASS_BASE:Int			 = 6001
Global hm_class_max:Int			 = HM_CLASS_BASE + MAX_HOMUNCULUS_CLASS - 1

'Mail System
Const MAIL_MAX_INBOX:Int	 = 30
Const MAIL_TITLE_LENGTH:Int	 = 40
Const MAIL_BODY_LENGTH:Int	 = 200

'Mercenary System
Const MC_SKILLBASE:Int		 = 8201
Const MAX_MERCSKILL:Int		 = 40
Const MAX_MERCENARY_CLASS:Int = 44

'TODO: ALLE item_types 's durch int variablen ersetzen!
Const IT_HEALING:Int = 0		'0  HEAL
Const IT_UNKNOWN:Int = 1		'1  SCHANGE
Const IT_USABLE:Int = 2			'2  SPECIAL
Const IT_ETC:Int = 3			'3  EVENT
Const IT_WEAPON:Int = 4			'4  ARMOR
Const IT_ARMOR:Int = 5			'5  WEAPON
Const IT_CARD:Int = 6			'6  CARD
Const IT_PETEGG:Int = 7			'7  QUEST
Const IT_PETARMOR:Int = 8		'8  BOW
Const IT_UNKNOWN2:Int = 9		'9  BOTHHAND
Const IT_AMMO:Int = 10			'10 ARROW
Const IT_DELAYCONSUME:Int = 11	'11 ARMORTM
							'12 ARMORTB
							'13 ARMORMB
							'14 ARMORTMB
							'15 GUN
							'16 AMMO
							'17 THROWWEAPON
Const IT_CASH:Int = 18,			'18 CASH_POINT_ITEM
							'19 CANNONBALL
Const IT_MAX:Int = 20 

'TODO: Questlog system 1
'typedef enum quest_state { Q_INACTIVE, Q_ACTIVE, Q_COMPLETE } quest_state;

Type quest
	Field quest_id:Int
	Field time:Int
	Field count:Int[MAX_QUEST_OBJECTIVES]
	'TODO: Questlog system 2
	'Field quest_state state; 'for Questlog system
EndType

Type item
	Field id:Int
	Field nameid:Short
	Field amount:Short
	Field equip:Short 'location(s) where item is equipped (using enum equip_pos For bitmasking)
	Field identify:Byte
	Field refine:Byte
	Field attribute:Byte
	Field card:Short[MAX_SLOTS]
	Field expire_time:Int
EndType

Type point
	Field map:Short
	Field xy:Short[2]
EndType
