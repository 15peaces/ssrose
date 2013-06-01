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
Const START_ACCOUNT_NUM:Int	 = 2000000
Const END_ACCOUNT_NUM:Int	 = 100000000
Const START_CHAR_NUM:Int	 = 150000

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
Const IT_CASH:Int = 18			'18 CASH_POINT_ITEM
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
	Field identify:Int
	Field refine:Int
	Field attribute:Int
	Field card:Short[MAX_SLOTS]
	Field expire_time:Int
EndType

Type point
	Field map:Short
	Field xy:Short[2]
EndType

'TODO: ALLE e_skill_flag 's durch int variablen ersetzen!
Const SKILL_FLAG_PERMANENT:Int	 = 1
Const SKILL_FLAG_TEMPORARY:Int	 = 2
Const SKILL_FLAG_PLAGIARIZED:Int	 = 3
Const SKILL_FLAG_REPLACED_LV_0:Int = 4 'temporary skill overshadowing permanent skill of level 'N - SKILL_FLAG_REPLACED_LV_0'

Type s_skill
	Field id:Short
	Field lv:Int
	Field flag:Int 'see enum e_skill_flag
EndType

Type global_reg
	Field str:String
	Field value:String
EndType

'Holds array of Global registries, used by the char server And converter.
Type accreg
	Field account_id:Int
	Field char_id:Int
	Field reg_num:Int
	'TODO: struct global_reg reg[MAX_REG_NUM];
EndType

'For saving status changes across sessions.
Type status_change_data
	Field mtype:Short 'SC_type
	Field val1:Long
	Field val2:Long
	Field val3:Long
	Field val4:Long
	Field tick:Long 'Remaining duration.
EndType

Type storage_data
	Field storage_amount:Int
	'TODO: struct item items[MAX_STORAGE];
EndType

Type guild_storage
	Field dirty:Int
	Field guild_id:Int
	Field storage_status:Short
	Field storage_amount:Short
	'TODO: struct item items[MAX_GUILD_STORAGE];
EndType

Type s_pet
	Field account_id:Int
	Field char_id:Int
	Field pet_id:Int
	Field class:Short
	Field level:Short
	Field egg_id:Short 'pet egg id
	Field equip:Short 'pet equip name_id
	Field intimate:Short 'pet friendly
	Field hungry:Short 'pet hungry
	Field name:String
	Field rename_flag:String
	Field incuvate:String
EndType

Type s_homunculus
	Field name:String
	Field hom_id:Int
	Field char_id:Int
	Field class:Short
	Field hp:Int
	Field max_hp:Int
	Field sp:Int
	Field max_sp:Int
	Field intimacy:Int
	Field hunger:Short
	'TODO: struct s_skill hskill[MAX_HOMUNSKILL]; //albator
	Field skillpts:Short
	Field level:Short
	Field mexp:Int
	Field rename_flag:Short
	Field vaporize:Short
	Field str:Int
	Field agi:Int
	Field vit:Int
	Field int_:Int
	Field dex:Int
	Field luk:Int
EndType

Type s_mercenary
	Field mercenary_id:Int
	Field char_id:Int
	Field class:Short
	Field hp:Int
	Field sp:Int
	Field kill_count:Int
	Field life_time:Int
EndType

Type s_friend
	Field account_id:Int
	Field char_id:Int
	Field name:String
EndType

Type hotkey 'only needed if HOTKEY_SAVING = true
	Field id:Int
	Field lv:Short
	Field mtype:Int '0: item, 1: skill
EndType

Type mmo_charstatus
	Field char_id:Int
	Field account_id:Int
	Field partner_id:Int
	Field father:Int
	Field mother:Int
	Field child:Int

	Field base_exp:Int
	Field job_exp:Int
	Field zeny:Int

	Field class:Int
	Field status_point:Int
	Field skill_point:Int
	Field hp:Int
	Field max_hp:Int
	Field sp:Int
	Field max_sp:Int
	Field option:Int
	Field manner:Short
	Field karma:Int
	Field hair:Short
	Field hair_color:Short
	Field clothes_color:Short
	Field party_id:Int
	Field guild_id:Int
	Field pet_id:Int
	Field hom_id:Int
	Field mer_id:Int
	Field fame:Int

	' Mercenary Guilds Rank
	Field arch_faith:Int
	Field arch_calls:Int
	Field spear_faith:Int
	Field spear_calls:Int
	Field sword_faith:Int
	Field sword_calls:Int

	Field weapon:Short 'weapon_type
	Field shield:Short 'view-id
	Field head_top:Short
	Field head_mid:Short
	Field head_bottom:Short
	Field robe:Short

	Field name:String
	Field base_level:Short
	Field job_level:Short
	Field str:Short
	Field agi:Short
	Field vit:Short
	Field int_:Short
	Field dex:Short
	Field luk:Short
	Field slot:Int
	Field sex:Int

	Field mapip:Int
	Field mapport:Short

	'TODO: struct point last_point,save_point,memo_point[MAX_MEMOPOINTS];
	'TODO: struct item inventory[MAX_INVENTORY],cart[MAX_CART];
	'TODO: struct storage_data storage;
	'TODO: struct s_skill skill[MAX_SKILL];

	'TODO: struct s_friend friends[MAX_FRIENDS]; //New friend system [Skotlex]

	'TODO: struct hotkey hotkeys[MAX_HOTKEYS];

	Field show_equip:Byte
	Field rename:Int

	Field delete_date:Int
EndType

'TODO: mail_status
'typedef enum mail_status {
'	MAIL_NEW,
'	MAIL_UNREAD,
'	MAIL_READ,
'} mail_status;

Type mail_message
	Field id:Int
	Field send_id:Int
	Field send_name:String
	Field dest_id:Int
	Field dest_name:String
	Field title:String
	Field body:String

	'TODO: mail_status status;
	Field timestamp:Int 'marks when the message was sent

	Field zeny:Int
	'TODO: struct item item;
EndType

Type mail_data
	Field amount:Short
	Field full:Byte
	Field unchecked:Short
	Field unread:Short
	'TODO: struct mail_message msg[MAIL_MAX_INBOX];
EndType

Type auction_data
	Field auction_id:Int
	Field seller_id:Int
	Field seller_name:String
	Field buyer_id:Int
	Field buyer_name:String
	
	'TODO struct item item;
	' This data is required For searching, as itemdb is Not read by char server
	Field item_name:String
	Field mtype:Short

	Field hours:Short
	Field price:Int
	Field buynow:Int
	Field timestamp:Int 'auction's end time
	Field auction_end_timer:Int
EndType

Type registry
	Field global_num:Int
	'TODO struct global_reg Global[GLOBAL_REG_NUM];
	Field account_num:Int
	'TODO struct global_reg account[ACCOUNT_REG_NUM];
	Field account2_num:Int
	'TODO struct global_reg account2[ACCOUNT_REG2_NUM];
EndType

Type party_member
	Field account_id:Int
	Field char_id:Int
	Field name:String
	Field class:Short
	Field map:Short
	Field lv:Short
	Field leader:Byte
	Field online:Byte
EndType

Type party
	Field party_id:Int
	Field name:String
	Field count:Short 'Count of online characters.
	Field mexp:Byte 'Party-Share (round-robin)
	Field item:Byte 'pickup style: shared
	'TODO: struct party_member member[MAX_PARTY];
EndType

'TODO: struct map_session_data;

Type guild_member
	Field account_id:Int
	Field char_id:Int
	Field hair:Short
	Field hair_color:Short
	Field gender:Short
	Field class_,lv:Short
	Field mexp:Int
	Field exp_payper:Int
	Field online:Short
	Field position:Short
	Field name:String
	'TODO: struct map_session_data *sd;
	Field modified:Byte
EndType

Type guild_position
	Field name:String
	Field mode:Int
	Field exp_mode:Int
	Field modified:Byte
EndType

Type guild_alliance
	Field opposition:Int
	Field guild_id:Int
	Field name:String
EndType

Type guild_expulsion
	Field name:String
	Field mes:String 'TODO: max. should be 40 bytes...
	Field account_id:Int
EndType

Type guild_skill
	Field id:Int
	Field lv:Int
EndType

Type guild
	Field guild_id:Int
	Field guild_lv:Short
	Field connect_member:Short
	Field max_member:Short
	Field average_lv:Short
	Field mexp:Int
	Field next_exp:Int
	Field skill_point:Int
	Field name:String
	Field master:String
	'TODO: struct guild_member member[MAX_GUILD];
	'TODO: struct guild_position position[MAX_GUILDPOSITION];
	Field mes1:String
	Field mes2:String
	Field emblem_len:Int
	Field emblem_id:Int
	Field emblem_data:Byte[2048]
	'TODO: struct guild_alliance alliance[MAX_GUILDALLIANCE];
	'TODO: struct guild_expulsion expulsion[MAX_GUILDEXPULSION];
	'TODO: struct guild_skill skill[MAX_GUILDSKILL];

	Field save_flag:Short; 'For TXT saving
EndType

Type guild_castle
	Field castle_id:Int
	Field mapindex:Int
	Field castle_name:String
	Field castle_event:String
	Field guild_id:Int
	Field economy:Int
	Field defense:Int
	Field triggerE:Int
	Field triggerD:Int
	Field nextTime:Int
	Field payTime:Int
	Field createTime:Int
	Field visibleC:Int
	'TODO: struct {
	'TODO: 	unsigned visible : 1;
	'TODO: 	Int id; // Object id
	'TODO: } guardian[MAX_GUARDIANS];
	Field temp_guardians:Int Ptr 'ids of temporary guardians (mobs)
	Field temp_guardians_max:Int
EndType

Type fame_list
	Field id:Int
	Field fame:Int
	Field name:String
EndType


Const GBI_EXP:Int		 = 1
Const GBI_GUILDLV:Int	 = 2
Const GBI_SKILLPOINT:Int = 3
Const GBI_SKILLLV:Int	 = 4


Const GMI_POSITION		 = 0
Const GMI_EXP			 = 1
Const GMI_HAIR			 = 2
Const GMI_HAIR_COLOR	 = 3
Const GMI_GENDER		 = 4
Const GMI_CLASS		 = 5
Const GMI_LEVEL		 = 6

Const GD_SKILLBASE:Int		 = 10000
Const GD_APPROVAL:Int		 = 10000
Const GD_KAFRACONTRACT:Int	 = 10001
Const GD_GUARDRESEARCH:Int	 = 10002
Const GD_GUARDUP:Int		 = 10003
Const GD_EXTENSION:Int		 = 10004
Const GD_GLORYGUILD:Int		 = 10005
Const GD_LEADERSHIP:Int		 = 10006
Const GD_GLORYWOUNDS:Int	 = 10007
Const GD_SOULCOLD:Int		 = 10008
Const GD_HAWKEYES:Int		 = 10009
Const GD_BATTLEORDER:Int	 = 10010
Const GD_REGENERATION:Int	 = 10011
Const GD_RESTORE:Int		 = 10012
Const GD_EMERGENCYCALL:Int	 = 10013
Const GD_DEVELOPMENT:Int	 = 10014
'Below skill disabled Until we find out If its still used.
'Const GD_ITEMEMERGENCYCALL:int= 10015
Const GD_MAX:Int			 = 10015


'These mark the ID of the jobs, as expected by the client.
Const JOB_NOVICE:Int			 = 0
Const JOB_SWORDMAN:Int			 = 1
Const JOB_MAGE	:Int				 = 2
Const JOB_ARCHER:Int			 = 3
Const JOB_ACOLYTE:Int			 = 4
Const JOB_MERCHANT:Int			 = 5
Const JOB_THIEF:Int			 = 6
Const JOB_KNIGHT:Int			 = 7
Const JOB_PRIEST:Int			 = 8
Const JOB_WIZARD:Int			 = 9
Const JOB_BLACKSMITH:Int		 = 10
Const JOB_HUNTER:Int			 = 11
Const JOB_ASSASSIN:Int			 = 12
Const JOB_KNIGHT2:Int			 = 13
Const JOB_CRUSADER:Int			 = 14
Const JOB_MONK:Int				 = 15
Const JOB_SAGE:Int				 = 16
Const JOB_ROGUE:Int			 = 17
Const JOB_ALCHEMIST:Int			 = 18
Const JOB_BARD:Int				 = 19
Const JOB_DANCER:Int			 = 20
Const JOB_CRUSADER2:Int			 = 21
Const JOB_WEDDING:Int			 = 22
Const JOB_SUPER_NOVICE:Int		 = 23
Const JOB_GUNSLINGER:Int		 = 24
Const JOB_NINJA:Int			 = 25
Const JOB_XMAS:Int				 = 26
Const JOB_SUMMER:Int			 = 27
Const JOB_HANBOK:Int			 = 28
Const JOB_MAX_BASIC:Int			 = 29

Const JOB_NOVICE_HIGH:Int		 = 4001
Const JOB_SWORDMAN_HIGH:Int		 = 4002
Const JOB_MAGE_HIGH:Int			 = 4003
Const JOB_ARCHER_HIGH:Int		 = 4004
Const JOB_ACOLYTE_HIGH:Int		 = 4005
Const JOB_MERCHANT_HIGH:Int		 = 4006
Const JOB_THIEF_HIGH:Int		 = 4007
Const JOB_LORD_KNIGHT:Int		 = 4008
Const JOB_HIGH_PRIEST:Int		 = 4009
Const JOB_HIGH_WIZARD:Int		 = 4010
Const JOB_WHITESMITH:Int		 = 4011
Const JOB_SNIPER:Int			 = 4012
Const JOB_ASSASSIN_CROSS:Int		 = 4013
Const JOB_LORD_KNIGHT2:Int		 = 4014
Const JOB_PALADIN:Int			 = 4015
Const JOB_CHAMPION:Int			 = 4016
Const JOB_PROFESSOR:Int			 = 4017
Const JOB_STALKER:Int			 = 4018
Const JOB_CREATOR:Int			 = 4019
Const JOB_CLOWN:Int			 = 4020
Const JOB_GYPSY:Int			 = 4021
Const JOB_PALADIN2:Int			 = 4022

Const JOB_BABY:Int				 = 4023
Const JOB_BABY_SWORDMAN:Int		 = 4024
Const JOB_BABY_MAGE:Int			 = 4025
Const JOB_BABY_ARCHER:Int		 = 4026
Const JOB_BABY_ACOLYTE:Int		 = 4027
Const JOB_BABY_MERCHANT:Int		 = 4028
Const JOB_BABY_THIEF:Int		 = 4029
Const JOB_BABY_KNIGHT:Int		 = 4030
Const JOB_BABY_PRIEST:Int		 = 4031
Const JOB_BABY_WIZARD:Int		 = 4032
Const JOB_BABY_BLACKSMITH:Int	 = 4033
Const JOB_BABY_HUNTER:Int		 = 4034
Const JOB_BABY_ASSASSIN:Int		 = 4035
Const JOB_BABY_KNIGHT2:Int		 = 4036
Const JOB_BABY_CRUSADER:Int		 = 4037
Const JOB_BABY_MONK:Int			 = 4038
Const JOB_BABY_SAGE:Int			 = 4039
Const JOB_BABY_ROGUE:Int		 = 4040
Const JOB_BABY_ALCHEMIST:Int		 = 4041
Const JOB_BABY_BARD:Int			 = 4042
Const JOB_BABY_DANCER:Int		 = 4043
Const JOB_BABY_CRUSADER2:Int		 = 4044
Const JOB_SUPER_BABY:Int		 = 4045

Const JOB_TAEKWON:Int			 = 4046
Const JOB_STAR_GLADIATOR:Int		 = 4047
Const JOB_STAR_GLADIATOR2:Int	 = 4048
Const JOB_SOUL_LINKER:Int		 = 4049

Const JOB_GANGSI:Int			 = 4050
Const JOB_DEATH_KNIGHT:Int		 = 4051
Const JOB_DARK_COLLECTOR:Int		 = 4052

Const JOB_RUNE_KNIGHT:Int		 = 4054
Const JOB_WARLOCK:Int			 = 4055
Const JOB_RANGER:Int			 = 4056
Const JOB_ARCH_BISHOP:Int		 = 4057
Const JOB_MECHANIC:Int			 = 4058
Const JOB_GUILLOTINE_CROSS:Int	 = 4059

Const JOB_RUNE_KNIGHT_T:Int		 = 4060
Const JOB_WARLOCK_T:Int		 = 4061
Const JOB_RANGER_T:Int			 = 4062
Const JOB_ARCH_BISHOP_T:Int		 = 4063
Const JOB_MECHANIC_T:Int		 = 4064
Const JOB_GUILLOTINE_CROSS_T:Int	 = 4065

Const JOB_ROYAL_GUARD:Int		 = 4066
Const JOB_SORCERER:Int			 = 4067
Const JOB_MINSTREL:Int			 = 4068
Const JOB_WANDERER:Int			 = 4069
Const JOB_SURA:Int				 = 4070
Const JOB_GENETIC:Int			 = 4071
Const JOB_SHADOW_CHASER:Int		 = 4072

Const JOB_ROYAL_GUARD_T:Int		 = 4073
Const JOB_SORCERER_T:Int		 = 4074
Const JOB_MINSTREL_T:Int		 = 4075
Const JOB_WANDERER_T:Int		 = 4076
Const JOB_SURA_T:Int			 = 4077
Const JOB_GENETIC_T:Int			 = 4078
Const JOB_SHADOW_CHASER_T:Int	 = 4079

Const JOB_RUNE_KNIGHT2:Int		 = 4080
Const JOB_RUNE_KNIGHT_T2:Int		 = 4081
Const JOB_ROYAL_GUARD2:Int		 = 4082
Const JOB_ROYAL_GUARD_T2:Int		 = 4083
Const JOB_RANGER2:Int			 = 4084
Const JOB_RANGER_T2:Int			 = 4085
Const JOB_MECHANIC2:Int			 = 4086
Const JOB_MECHANIC_T2:Int		 = 4087
Const JOB_RUNE_KNIGHT3:Int		 = 4088
Const JOB_RUNE_KNIGHT_T3:Int		 = 4089
Const JOB_RUNE_KNIGHT4:Int		 = 4090
Const JOB_RUNE_KNIGHT_T4:Int		 = 4091
Const JOB_RUNE_KNIGHT5:Int		 = 4092
Const JOB_RUNE_KNIGHT_T5:Int		 = 4093
Const JOB_RUNE_KNIGHT6:Int		 = 4094
Const JOB_RUNE_KNIGHT_T6:Int		 = 4095

Const JOB_BABY_RUNE:Int			 = 4096
Const JOB_BABY_WARLOCK:Int		 = 4097
Const JOB_BABY_RANGER:Int		 = 4098
Const JOB_BABY_BISHOP:Int		 = 4099
Const JOB_BABY_MECHANIC:Int		 = 4100
Const JOB_BABY_CROSS:Int		 = 4101
Const JOB_BABY_GUARD:Int		 = 4102
Const JOB_BABY_SORCERER:Int		 = 4103
Const JOB_BABY_MINSTREL:Int		 = 4104
Const JOB_BABY_WANDERER:Int		 = 4105
Const JOB_BABY_SURA:Int			 = 4106
Const JOB_BABY_GENETIC:Int		 = 4107
Const JOB_BABY_CHASER:Int		 = 4108

Const JOB_BABY_RUNE2:Int		 = 4109
Const JOB_BABY_GUARD2:Int		 = 4110
Const JOB_BABY_RANGER2:Int		 = 4111
Const JOB_BABY_MECHANIC2:Int		 = 4112

Const JOB_SUPER_NOVICE_E:Int		 = 4190
Const JOB_SUPER_BABY_E:Int		 = 4191

Const JOB_KAGEROU:Int			 = 4211
Const JOB_OBORO:Int			 = 4212

Const JOB_MAX:Int				 = 4213

Const SEX_FEMALE:Int	 = 0
Const SEX_MALE:Int		 = 1
Const SEX_SERVE:Int	 = 2