# Quest/NPC 字段全量穷举扫描报告

- 输入目录: `D:\TitanGames\GhostOnline\zChina\Script`
- Quest 脚本文件数: `30`
- Quest ID 数量: `2605`
- NPC 脚本文件数: `468`
- NPC 函数调用总数: `16174`
- NPC 未解析调用数: `3`

## 第一部分：Quest 结构字段穷举

### Quest 层字段

| field | count | layer | example | example_quest_id | example_file |
|---|---:|---|---|---:|---|
| answer | 90962 | Quest | [???? ??? ????., ?? ?? ??????.] | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| contents | 90962 | Quest | [?? ??? ????? ??? ?? ??? ????. ???? ???? ??? ?? ???? ?????., ??? ??? ?? ??? ??????. ??? {0xFFFFFF00}[?????]? 3?{END}? ??? ??? ??? ??????. ] | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| id | 90962 | Quest | 2 | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| name | 90962 | Quest | "[ ????? ?? ]" | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| bQLoop | 89642 | Quest | 0 | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| info | 89642 | Quest | [???? {0xFFFFFF00}[?????] 3?{END}? ????. ????? ??.] | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| needLevel | 89636 | Quest | 2 | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| npcsay | 89578 | Quest | [] | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| reward | 78150 | Quest | {money=200} | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| goal | 74194 | Quest | {getItem=[{id=8910031, count=3}]} | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| requstItem | 20766 | Quest | [{meetcnt=0, itemid=8990002, itemcnt=1}] | 3 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| deleteItem | 3120 | Quest | [{meetcnt=1, itemid=8990004, itemcnt=1}] | 13 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| needQuest | 150 | Quest | 3 | 4 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| needItem | 30 | Quest | 11572 | 13 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |

### Goal 层字段

| field | count | layer | example | example_quest_id | example_file |
|---|---:|---|---|---:|---|
| count | 65278 | Goal | 3 | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| id | 65278 | Goal | 8910031 | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| getItem | 45810 | Goal | [{id=8910031, count=3}] | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| killMonster | 30418 | Goal | [{id=1001201, count=1}] | 8 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| meetNpc | 7350 | Goal | [4214004] | 13 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| fame | 420 | Goal | 99 | 169 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| timeOut | 150 | Goal | 1800 | 436 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| getitem | 60 | Goal | [{id=8980007, count=1}] | 2005 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| exp | 30 | Goal | 10000 | 1418 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| meetNPC | 30 | Goal | [300012] | 700 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |

### Reward 层字段

| field | count | layer | example | example_quest_id | example_file |
|---|---:|---|---|---:|---|
| exp | 45360 | Reward | 30 | 3 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| getItem | 32940 | Reward | [{id=8810011, count=99}, {id=8820011, count=99}] | 7 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| count | 32340 | Reward | 99 | 7 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| id | 32340 | Reward | 8810011 | 7 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| money | 14220 | Reward | 200 | 2 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| fame | 14040 | Reward | 1 | 3 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| getSkill | 8190 | Reward | [10101] | 22 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| pvppoint | 570 | Reward | 3 | 802 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| mileage | 120 | Reward | 20 | 1804 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |
| getitem | 60 | Reward | [{id=8890212, count=1}] | 2005 | D:\TitanGames\GhostOnline\zChina\Script\idem1.1653151773806862013.luc |

### 指定字段命中统计

- `goal`: count=`74194`, example=`{getItem=[{id=8910031, count=3}]}`
- `reward`: count=`78150`, example=`{money=200}`
- `requstItem`: count=`20766`, example=`[{meetcnt=0, itemid=8990002, itemcnt=1}]`
- `needItem`: count=`30`, example=`11572`
- `deleteItem`: count=`3120`, example=`[{meetcnt=1, itemid=8990004, itemcnt=1}]`
- `needQuest`: count=`150`, example=`3`

## 第二部分：NPC 行为字段穷举

### 指定方法调用统计

- `NPC_SAY`: `3553`
- `ADD_QUEST_BTN`: `1382`
- `SET_QUEST_STATE`: `1516`
- `CHECK_ITEM_CNT`: `1583`

### 全部函数调用统计

| function_name | count |
|---|---:|
| QSTATE | 3986 |
| NPC_SAY | 3549 |
| GET_PLAYER_LEVEL | 1677 |
| CHECK_ITEM_CNT | 1583 |
| SET_QUEST_STATE | 1516 |
| ADD_QUEST_BTN | 1382 |
| CHECK_INVENTORY_CNT | 404 |
| GET_PLAYER_JOB1 | 297 |
| SET_MEETNPC | 187 |
| NPC_QSAY | 119 |
| GET_PLAYER_JOB2 | 98 |
| ADD_NEW_SHOP_BTN | 87 |
| SET_INFO | 63 |
| SET_PLAYER_SEX | 62 |
| CHECK_SKILL | 60 |
| GET_PLAYER_FACTION | 51 |
| GET_PLAYER_FAME | 30 |
| SET_QUEST_COMPLETE_USEQUESTITEM | 30 |
| NPC_WARP_THEME_1 | 28 |
| NPC_WARP_THEME_10 | 28 |
| NPC_WARP_THEME_15 | 27 |
| NPC_WARP_THEME_16 | 27 |
| NPC_WARP_THEME_42 | 27 |
| NPC_WARP_THEME_12 | 26 |
| NPC_WARP_THEME_20 | 26 |
| NPC_WARP_THEME_25 | 26 |
| NPC_WARP_THEME_26 | 26 |
| NPC_WARP_THEME_27 | 26 |
| NPC_WARP_THEME_39 | 26 |
| NPC_WARP_THEME_46 | 26 |
| NPC_WARP_TO_CHUNGUM_MARKET_PLACE | 26 |
| NPC_WARP_THEME_50 | 25 |
| ADD_NPC_WARP_INDUN_EXIT | 24 |
| NPC_WARP_THEME_18 | 24 |
| NPC_WARP_THEME_34_6 | 24 |
| NPC_WARP_THEME_41 | 24 |
| NPC_WARP_THEME_53 | 24 |
| NPC_WARP_THEME_55 | 24 |
| NPC_WARP_THEME_56 | 24 |
| NPC_WARP_THEME_63 | 24 |
| NPC_WARP_THEME_67 | 24 |
| GET_PLAYER_EQUIPSEANCELEVEL | 22 |
| FACTION_ON_OFF | 18 |
| ADD_MOVESOUL_BTN | 10 |
| ADD_PARCEL_SERVICE_BTN | 10 |
| ADD_STORE_BTN | 10 |
| ADD_ENCHANT_BTN | 9 |
| ADD_PURIFICATION_BTN | 9 |
| GIVE_DONATION_BUFF | 9 |
| GIVE_DONATION_ITEM | 9 |
| NPC_WARP_SILENCE_TEMPLE1 | 9 |
| NPC_WARP_SILENCE_TEMPLE2 | 9 |
| NPC_WARP_SILENCE_TEMPLE3 | 9 |
| CHECK_GUILD_MYUSER | 8 |
| GET_SEAL_BOX_SOUL_PERSENT | 7 |
| ADD_EVENT_BTN_JEWEL | 5 |
| ADD_EX_BTN | 5 |
| ADD_NPC_WARP_INDUN | 5 |
| ADD_NPC_WARP_INDUN2 | 5 |
| GET_PLAYER_USESKILLPOINT_C | 5 |
| GIHON_MIXTURE | 5 |
| LearnSkill | 5 |
| ADD_EQUIP_REFINE_BTN | 4 |
| ADD_REPAIR_EQUIPMENT | 4 |
| FACTIONWRR_SHOW | 4 |
| GET_PLAYER_TRANSFORMER | 4 |
| NPC_SAY_MERGE | 4 |
| RARE_BOX_MIXTURE | 4 |
| RARE_BOX_OPEN | 4 |
| <UNRESOLVED_CALL> | 3 |
| ADD_DONATION_BTN | 3 |
| ADD_NPC_GUILD_CREATE | 3 |
| ADD_RETURN_WARP_BTN | 3 |
| ADD_SOULALCOHOL_CHANGE_BTN | 3 |
| ADD_UPGRADE_ITEM_BTN | 3 |
| GET_NPC_GUILD_LIST | 3 |
| NECO_HEART_RETURN | 3 |
| NECO_HEART_SHOW | 3 |
| NPC_WARP_SILENCE_TEMPLE4 | 3 |
| SET_ITEM_PERCENT | 3 |
| ADD_BEAUTYSHOP_BTN | 2 |
| ADD_BTN_WARP_61 | 2 |
| ADD_ENCHANTEACCESSORY_BTN | 2 |
| ADD_ENCHANTEQUIP_BTN | 2 |
| ADD_EQUIP_DELIVERY | 2 |
| ADD_EQUIP_DELIVERY_CURRENT | 2 |
| ADD_NPC_CARD_DIVINE | 2 |
| ADD_NPC_CARTOON | 2 |
| ADD_NPC_WARP_CHUNGYAKANG | 2 |
| ADD_NPC_WARP_WARRIOR | 2 |
| ADD_PREMIUM_BEAUTYSHOP_BTN | 2 |
| EVENT_OX_QUIZ | 2 |
| EVENT_OX_STATE | 2 |
| FACTIONWAR_IN | 2 |
| GET_PLAYER_SKILLPOINT | 2 |
| GET_PLAYER_STATEPOINT | 2 |
| GIHON_ENDOWMENT | 2 |
| GIHON_STRENGTHENING | 2 |
| NPC_ANSWER_CANCEL | 2 |
| NPC_WARP_THEME_36_1 | 2 |
| NPC_WARP_TO_DOK_PYO_GONG | 2 |
| SHOW_FACTION_LIST_1 | 2 |
| WarpTaeULMove | 2 |
| ADD_10TH_ANNIVERSARY_CAKEDECO_EVENT_GIVE | 1 |
| ADD_10TH_ANNIVERSARY_CAKEDECO_EVENT_SHOW | 1 |
| ADD_11TH_ANNIVERSARY_SOUVENIR_EVENT_GIVE | 1 |
| ADD_11TH_ANNIVERSARY_SOUVENIR_EVENT_SHOW | 1 |
| ADD_12THANIVERSARY_SOUVENIR_EVENT_GIVE | 1 |
| ADD_12THANIVERSARY_SOUVENIR_EVENT_SHOW | 1 |
| ADD_14THANIVERSARY_SOUVENIR_EVENT_GIVE | 1 |
| ADD_14THANIVERSARY_SOUVENIR_EVENT_SHOW | 1 |
| ADD_16THANIVERSARY_SOUVENIR_EVENT_GIVE | 1 |
| ADD_16THANIVERSARY_SOUVENIR_EVENT_SHOW | 1 |
| ADD_ANNIVERSARY_EVENT | 1 |
| ADD_ANNIVERSARY_EVENT_SHOW | 1 |
| ADD_AUCTION_OPEN | 1 |
| ADD_AUTO_SEARCH_NPC | 1 |
| ADD_BTN_GEMBLE | 1 |
| ADD_BTN_HELL_BACKSTREET | 1 |
| ADD_BTN_HELL_DARKROAD | 1 |
| ADD_BTN_HELL_OUTSKIRTS | 1 |
| ADD_BTN_HELL_TOWN_WAR | 1 |
| ADD_BTN_INDUN_GOD_OF_TREE | 1 |
| ADD_BTN_NEST_OF_ANCIENT_DRAGON | 1 |
| ADD_BTN_WEDDING | 1 |
| ADD_BTN_WEDDING_GETOUT | 1 |
| ADD_BTN_WEDDING_GIFT | 1 |
| ADD_BTN_WEDDING_MESSGE | 1 |
| ADD_BTN_WEDDING_MONEY | 1 |
| ADD_CHANGE_SEANCECARD_BTN | 1 |
| ADD_EVENT_BTN_4TH_ANNIVERSARY_MAKE_CAKE | 1 |
| ADD_EVENT_BTN_4TH_ANNIVERSARY_MAKE_CAKE_SHOW | 1 |
| ADD_EVENT_BTN_CHRISTMAS_TREE | 1 |
| ADD_EVENT_BTN_CHRISTMAS_TREE_SHOW | 1 |
| ADD_EVENT_BTN_D | 1 |
| ADD_EVENT_BTN_E | 1 |
| ADD_EVENT_BTN_F | 1 |
| ADD_EVENT_BTN_G | 1 |
| ADD_EVENT_BTN_H | 1 |
| ADD_EVENT_BUFF_TAEGUKi | 1 |
| ADD_EVENT_GUIDE_ITEM_NEW | 1 |
| ADD_EVENT_RICE_ROLL1 | 1 |
| ADD_EVENT_RICE_ROLL2 | 1 |
| ADD_FACTION1_EVENT | 1 |
| ADD_FACTION1_EVENT_SHOW | 1 |
| ADD_FACTION2_EVENT | 1 |
| ADD_FACTION2_EVENT_SHOW | 1 |
| ADD_GIVE_SOULBOX | 1 |
| ADD_ITEMLOCK_20130723 | 1 |
| ADD_MAGOO_DONATION_EVENT | 1 |
| ADD_MAGOO_DONATION_EVENT_SHOW | 1 |
| ADD_MINIGAME_PET_EXIT | 1 |
| ADD_NEKOMARK_SOUVENIR_EVENT_GIVE | 1 |
| ADD_NEKOMARK_SOUVENIR_EVENT_SHOW | 1 |
| ADD_NELUMBO_SOUVENIR_EVENT_GIVE | 1 |
| ADD_NELUMBO_SOUVENIR_EVENT_SHOW | 1 |
| ADD_NPC_CR_REWARD | 1 |
| ADD_NPC_TOOHO | 1 |
| ADD_NPC_WARP_A | 1 |
| ADD_NPC_WARP_B | 1 |
| ADD_NPC_WARP_HANYA | 1 |
| ADD_NPC_WARP_INDUN_GHOST | 1 |
| ADD_NPC_WARP_PVPLEAGUE_OUT | 1 |
| ADD_NPC_YUT_EVENT | 1 |
| ADD_OLDUSER_GIFT | 1 |
| ADD_PVPWINNER_EVENT | 1 |
| ADD_PVPWINNER_EVENT_SHOW | 1 |
| ADD_SHOP_BTN | 1 |
| ADD_TOMBSTONE_EVENT | 1 |
| ADD_TOMBSTONE_EVENT_SHOW | 1 |
| ADD_TOURNAMENT_BTN | 1 |
| ADD_TOURNAMENT_ENTRY_BTN | 1 |
| ADD_TOWER_ESCAPE_BTN | 1 |
| ADD_TREE_EVENT | 1 |
| ADD_TREE_EVENT_SHOW | 1 |
| ADD_USE_KEY_BTN | 1 |
| ADD_WARP_EASY_YANG_15LV | 1 |
| ADD_WARP_EASY_YANG_25LV | 1 |
| ADD_WARP_EASY_YANG_35LV | 1 |
| ADD_WARP_YANGTEMPLE | 1 |
| ALLI_ATTACK_PROPOSE | 1 |
| ALLI_CREATE | 1 |
| ALLI_DEFENSE_SIDE | 1 |
| ALLI_LISTVIEW | 1 |
| ALLI_QUEST | 1 |
| ARMY_BOX_OPEN | 1 |
| BTN_8YEAR_RETURN | 1 |
| BTN_8YEAR_SHOW | 1 |
| BTN_DONATION_FISH | 1 |
| BTN_HWANGCHUN_ENTER | 1 |
| BTN_HWANGCHUN_EXIT | 1 |
| BTN_SNOWMAN_OUT | 1 |
| CHECK_BLOOD_ROOM | 1 |
| CW_ENTER | 1 |
| CW_EXIT | 1 |
| CW_PROCLAMATION | 1 |
| CW_REQUEST | 1 |
| GIVE_REPAY | 1 |
| GOLD_DONATION | 1 |
| GOLD_DONATION_SHOW | 1 |
| HELL_ENTER | 1 |
| INDUN_NEST_OF_ANCIENT_DRAGON_RAID_RANKING | 1 |
| INFINITY_DUNGEON_1P | 1 |
| NPC_OFFER_SHOW | 1 |
| NPC_WARP_BLOOD_ROOM | 1 |
| NPC_WARP_GUARD_TO_SUNYOOGOK | 1 |
| NPC_WARP_NEKOISLAND_ENTER | 1 |
| NPC_WARP_NEKOISLAND_EXIT | 1 |
| NPC_WARP_SUNYOOGOK | 1 |
| NPC_WARP_THEME_22 | 1 |
| NPC_WARP_THEME_34 | 1 |
| NPC_WARP_THEME_37 | 1 |
| NPC_WARP_THEME_51_19 | 1 |
| NPC_WARP_THEME_52_19 | 1 |
| NPC_WARP_TO_BLOODROOM | 1 |
| NPC_WARP_TO_BLOODUPROOM | 1 |
| NPC_WARP_TO_LIFEROOM | 1 |
| NPC_WARP_TO_PAINROOM | 1 |
| NPC_WARP_TO_SADROOM | 1 |
| Warp1000suEnter | 1 |

### 未识别方法列表

| method_name | count |
|---|---:|
| QSTATE | 3986 |
| GET_PLAYER_LEVEL | 1677 |
| CHECK_INVENTORY_CNT | 404 |
| GET_PLAYER_JOB1 | 297 |
| SET_MEETNPC | 187 |
| NPC_QSAY | 119 |
| GET_PLAYER_JOB2 | 98 |
| ADD_NEW_SHOP_BTN | 87 |
| SET_INFO | 63 |
| SET_PLAYER_SEX | 62 |
| CHECK_SKILL | 60 |
| GET_PLAYER_FACTION | 51 |
| GET_PLAYER_FAME | 30 |
| SET_QUEST_COMPLETE_USEQUESTITEM | 30 |
| NPC_WARP_THEME_1 | 28 |
| NPC_WARP_THEME_10 | 28 |
| NPC_WARP_THEME_15 | 27 |
| NPC_WARP_THEME_16 | 27 |
| NPC_WARP_THEME_42 | 27 |
| NPC_WARP_THEME_12 | 26 |
| NPC_WARP_THEME_20 | 26 |
| NPC_WARP_THEME_25 | 26 |
| NPC_WARP_THEME_26 | 26 |
| NPC_WARP_THEME_27 | 26 |
| NPC_WARP_THEME_39 | 26 |
| NPC_WARP_THEME_46 | 26 |
| NPC_WARP_TO_CHUNGUM_MARKET_PLACE | 26 |
| NPC_WARP_THEME_50 | 25 |
| ADD_NPC_WARP_INDUN_EXIT | 24 |
| NPC_WARP_THEME_18 | 24 |
| NPC_WARP_THEME_34_6 | 24 |
| NPC_WARP_THEME_41 | 24 |
| NPC_WARP_THEME_53 | 24 |
| NPC_WARP_THEME_55 | 24 |
| NPC_WARP_THEME_56 | 24 |
| NPC_WARP_THEME_63 | 24 |
| NPC_WARP_THEME_67 | 24 |
| GET_PLAYER_EQUIPSEANCELEVEL | 22 |
| FACTION_ON_OFF | 18 |
| ADD_MOVESOUL_BTN | 10 |
| ADD_PARCEL_SERVICE_BTN | 10 |
| ADD_STORE_BTN | 10 |
| ADD_ENCHANT_BTN | 9 |
| ADD_PURIFICATION_BTN | 9 |
| GIVE_DONATION_BUFF | 9 |
| GIVE_DONATION_ITEM | 9 |
| NPC_WARP_SILENCE_TEMPLE1 | 9 |
| NPC_WARP_SILENCE_TEMPLE2 | 9 |
| NPC_WARP_SILENCE_TEMPLE3 | 9 |
| CHECK_GUILD_MYUSER | 8 |
| GET_SEAL_BOX_SOUL_PERSENT | 7 |
| ADD_EVENT_BTN_JEWEL | 5 |
| ADD_EX_BTN | 5 |
| ADD_NPC_WARP_INDUN | 5 |
| ADD_NPC_WARP_INDUN2 | 5 |
| GET_PLAYER_USESKILLPOINT_C | 5 |
| GIHON_MIXTURE | 5 |
| LearnSkill | 5 |
| ADD_EQUIP_REFINE_BTN | 4 |
| ADD_REPAIR_EQUIPMENT | 4 |
| FACTIONWRR_SHOW | 4 |
| GET_PLAYER_TRANSFORMER | 4 |
| RARE_BOX_MIXTURE | 4 |
| RARE_BOX_OPEN | 4 |
| ADD_DONATION_BTN | 3 |
| ADD_NPC_GUILD_CREATE | 3 |
| ADD_RETURN_WARP_BTN | 3 |
| ADD_SOULALCOHOL_CHANGE_BTN | 3 |
| ADD_UPGRADE_ITEM_BTN | 3 |
| GET_NPC_GUILD_LIST | 3 |
| NECO_HEART_RETURN | 3 |
| NECO_HEART_SHOW | 3 |
| NPC_WARP_SILENCE_TEMPLE4 | 3 |
| SET_ITEM_PERCENT | 3 |
| ADD_BEAUTYSHOP_BTN | 2 |
| ADD_BTN_WARP_61 | 2 |
| ADD_ENCHANTEACCESSORY_BTN | 2 |
| ADD_ENCHANTEQUIP_BTN | 2 |
| ADD_EQUIP_DELIVERY | 2 |
| ADD_EQUIP_DELIVERY_CURRENT | 2 |
| ADD_NPC_CARD_DIVINE | 2 |
| ADD_NPC_CARTOON | 2 |
| ADD_NPC_WARP_CHUNGYAKANG | 2 |
| ADD_NPC_WARP_WARRIOR | 2 |
| ADD_PREMIUM_BEAUTYSHOP_BTN | 2 |
| EVENT_OX_QUIZ | 2 |
| EVENT_OX_STATE | 2 |
| FACTIONWAR_IN | 2 |
| GET_PLAYER_SKILLPOINT | 2 |
| GET_PLAYER_STATEPOINT | 2 |
| GIHON_ENDOWMENT | 2 |
| GIHON_STRENGTHENING | 2 |
| NPC_ANSWER_CANCEL | 2 |
| NPC_WARP_THEME_36_1 | 2 |
| NPC_WARP_TO_DOK_PYO_GONG | 2 |
| SHOW_FACTION_LIST_1 | 2 |
| WarpTaeULMove | 2 |
| ADD_10TH_ANNIVERSARY_CAKEDECO_EVENT_GIVE | 1 |
| ADD_10TH_ANNIVERSARY_CAKEDECO_EVENT_SHOW | 1 |
| ADD_11TH_ANNIVERSARY_SOUVENIR_EVENT_GIVE | 1 |
| ADD_11TH_ANNIVERSARY_SOUVENIR_EVENT_SHOW | 1 |
| ADD_12THANIVERSARY_SOUVENIR_EVENT_GIVE | 1 |
| ADD_12THANIVERSARY_SOUVENIR_EVENT_SHOW | 1 |
| ADD_14THANIVERSARY_SOUVENIR_EVENT_GIVE | 1 |
| ADD_14THANIVERSARY_SOUVENIR_EVENT_SHOW | 1 |
| ADD_16THANIVERSARY_SOUVENIR_EVENT_GIVE | 1 |
| ADD_16THANIVERSARY_SOUVENIR_EVENT_SHOW | 1 |
| ADD_ANNIVERSARY_EVENT | 1 |
| ADD_ANNIVERSARY_EVENT_SHOW | 1 |
| ADD_AUCTION_OPEN | 1 |
| ADD_AUTO_SEARCH_NPC | 1 |
| ADD_BTN_GEMBLE | 1 |
| ADD_BTN_HELL_BACKSTREET | 1 |
| ADD_BTN_HELL_DARKROAD | 1 |
| ADD_BTN_HELL_OUTSKIRTS | 1 |
| ADD_BTN_HELL_TOWN_WAR | 1 |
| ADD_BTN_INDUN_GOD_OF_TREE | 1 |
| ADD_BTN_NEST_OF_ANCIENT_DRAGON | 1 |
| ADD_BTN_WEDDING | 1 |
| ADD_BTN_WEDDING_GETOUT | 1 |
| ADD_BTN_WEDDING_GIFT | 1 |
| ADD_BTN_WEDDING_MESSGE | 1 |
| ADD_BTN_WEDDING_MONEY | 1 |
| ADD_CHANGE_SEANCECARD_BTN | 1 |
| ADD_EVENT_BTN_4TH_ANNIVERSARY_MAKE_CAKE | 1 |
| ADD_EVENT_BTN_4TH_ANNIVERSARY_MAKE_CAKE_SHOW | 1 |
| ADD_EVENT_BTN_CHRISTMAS_TREE | 1 |
| ADD_EVENT_BTN_CHRISTMAS_TREE_SHOW | 1 |
| ADD_EVENT_BTN_D | 1 |
| ADD_EVENT_BTN_E | 1 |
| ADD_EVENT_BTN_F | 1 |
| ADD_EVENT_BTN_G | 1 |
| ADD_EVENT_BTN_H | 1 |
| ADD_EVENT_BUFF_TAEGUKi | 1 |
| ADD_EVENT_GUIDE_ITEM_NEW | 1 |
| ADD_EVENT_RICE_ROLL1 | 1 |
| ADD_EVENT_RICE_ROLL2 | 1 |
| ADD_FACTION1_EVENT | 1 |
| ADD_FACTION1_EVENT_SHOW | 1 |
| ADD_FACTION2_EVENT | 1 |
| ADD_FACTION2_EVENT_SHOW | 1 |
| ADD_GIVE_SOULBOX | 1 |
| ADD_ITEMLOCK_20130723 | 1 |
| ADD_MAGOO_DONATION_EVENT | 1 |
| ADD_MAGOO_DONATION_EVENT_SHOW | 1 |
| ADD_MINIGAME_PET_EXIT | 1 |
| ADD_NEKOMARK_SOUVENIR_EVENT_GIVE | 1 |
| ADD_NEKOMARK_SOUVENIR_EVENT_SHOW | 1 |
| ADD_NELUMBO_SOUVENIR_EVENT_GIVE | 1 |
| ADD_NELUMBO_SOUVENIR_EVENT_SHOW | 1 |
| ADD_NPC_CR_REWARD | 1 |
| ADD_NPC_TOOHO | 1 |
| ADD_NPC_WARP_A | 1 |
| ADD_NPC_WARP_B | 1 |
| ADD_NPC_WARP_HANYA | 1 |
| ADD_NPC_WARP_INDUN_GHOST | 1 |
| ADD_NPC_WARP_PVPLEAGUE_OUT | 1 |
| ADD_NPC_YUT_EVENT | 1 |
| ADD_OLDUSER_GIFT | 1 |
| ADD_PVPWINNER_EVENT | 1 |
| ADD_PVPWINNER_EVENT_SHOW | 1 |
| ADD_SHOP_BTN | 1 |
| ADD_TOMBSTONE_EVENT | 1 |
| ADD_TOMBSTONE_EVENT_SHOW | 1 |
| ADD_TOURNAMENT_BTN | 1 |
| ADD_TOURNAMENT_ENTRY_BTN | 1 |
| ADD_TOWER_ESCAPE_BTN | 1 |
| ADD_TREE_EVENT | 1 |
| ADD_TREE_EVENT_SHOW | 1 |
| ADD_USE_KEY_BTN | 1 |
| ADD_WARP_EASY_YANG_15LV | 1 |
| ADD_WARP_EASY_YANG_25LV | 1 |
| ADD_WARP_EASY_YANG_35LV | 1 |
| ADD_WARP_YANGTEMPLE | 1 |
| ALLI_ATTACK_PROPOSE | 1 |
| ALLI_CREATE | 1 |
| ALLI_DEFENSE_SIDE | 1 |
| ALLI_LISTVIEW | 1 |
| ALLI_QUEST | 1 |
| ARMY_BOX_OPEN | 1 |
| BTN_8YEAR_RETURN | 1 |
| BTN_8YEAR_SHOW | 1 |
| BTN_DONATION_FISH | 1 |
| BTN_HWANGCHUN_ENTER | 1 |
| BTN_HWANGCHUN_EXIT | 1 |
| BTN_SNOWMAN_OUT | 1 |
| CHECK_BLOOD_ROOM | 1 |
| CW_ENTER | 1 |
| CW_EXIT | 1 |
| CW_PROCLAMATION | 1 |
| CW_REQUEST | 1 |
| GIVE_REPAY | 1 |
| GOLD_DONATION | 1 |
| GOLD_DONATION_SHOW | 1 |
| HELL_ENTER | 1 |
| INDUN_NEST_OF_ANCIENT_DRAGON_RAID_RANKING | 1 |
| INFINITY_DUNGEON_1P | 1 |
| NPC_OFFER_SHOW | 1 |
| NPC_WARP_BLOOD_ROOM | 1 |
| NPC_WARP_GUARD_TO_SUNYOOGOK | 1 |
| NPC_WARP_NEKOISLAND_ENTER | 1 |
| NPC_WARP_NEKOISLAND_EXIT | 1 |
| NPC_WARP_SUNYOOGOK | 1 |
| NPC_WARP_THEME_22 | 1 |
| NPC_WARP_THEME_34 | 1 |
| NPC_WARP_THEME_37 | 1 |
| NPC_WARP_THEME_51_19 | 1 |
| NPC_WARP_THEME_52_19 | 1 |
| NPC_WARP_TO_BLOODROOM | 1 |
| NPC_WARP_TO_BLOODUPROOM | 1 |
| NPC_WARP_TO_LIFEROOM | 1 |
| NPC_WARP_TO_PAINROOM | 1 |
| NPC_WARP_TO_SADROOM | 1 |
| Warp1000suEnter | 1 |

## 第三部分：字段标准化

### Quest 字段大小写归一

- 无大小写冲突字段

### Goal 字段大小写归一

| normalized_key | variants | suggested_standard |
|---|---|---|
| getitem | getItem, getitem | getItem |
| meetnpc | meetNpc, meetNPC | meetNpc |

### Reward 字段大小写归一

| normalized_key | variants | suggested_standard |
|---|---|---|
| getitem | getItem, getitem | getItem |

### NPC 方法命名归一

- 无大小写冲突字段

## 第四部分：字段覆盖率报告

```json
{
  "QuestFields": [{"name":"answer","count":90962,"layer":"Quest","example":"[???? ??? ????., ?? ?? ??????.]","exampleQuestId":2},{"name":"contents","count":90962,"layer":"Quest","example":"[?? ??? ????? ??? ?? ??? ????. ???? ???? ??? ?? ???? ?????., ??? ??? ?? ??? ??????. ??? {0xFFFFFF00}[?????]? 3?{END}? ??? ??? ??? ??????. ]","exampleQuestId":2},{"name":"id","count":90962,"layer":"Quest","example":"2","exampleQuestId":2},{"name":"name","count":90962,"layer":"Quest","example":"\"[ ????? ?? ]\"","exampleQuestId":2},{"name":"bQLoop","count":89642,"layer":"Quest","example":"0","exampleQuestId":2},{"name":"info","count":89642,"layer":"Quest","example":"[???? {0xFFFFFF00}[?????] 3?{END}? ????. ????? ??.]","exampleQuestId":2},{"name":"needLevel","count":89636,"layer":"Quest","example":"2","exampleQuestId":2},{"name":"npcsay","count":89578,"layer":"Quest","example":"[]","exampleQuestId":2},{"name":"reward","count":78150,"layer":"Quest","example":"{money=200}","exampleQuestId":2},{"name":"goal","count":74194,"layer":"Quest","example":"{getItem=[{id=8910031, count=3}]}","exampleQuestId":2},{"name":"requstItem","count":20766,"layer":"Quest","example":"[{meetcnt=0, itemid=8990002, itemcnt=1}]","exampleQuestId":3},{"name":"deleteItem","count":3120,"layer":"Quest","example":"[{meetcnt=1, itemid=8990004, itemcnt=1}]","exampleQuestId":13},{"name":"needQuest","count":150,"layer":"Quest","example":"3","exampleQuestId":4},{"name":"needItem","count":30,"layer":"Quest","example":"11572","exampleQuestId":13}],
  "GoalFields": [{"name":"count","count":65278,"layer":"Goal","example":"3","exampleQuestId":2},{"name":"id","count":65278,"layer":"Goal","example":"8910031","exampleQuestId":2},{"name":"getItem","count":45810,"layer":"Goal","example":"[{id=8910031, count=3}]","exampleQuestId":2},{"name":"killMonster","count":30418,"layer":"Goal","example":"[{id=1001201, count=1}]","exampleQuestId":8},{"name":"meetNpc","count":7350,"layer":"Goal","example":"[4214004]","exampleQuestId":13},{"name":"fame","count":420,"layer":"Goal","example":"99","exampleQuestId":169},{"name":"timeOut","count":150,"layer":"Goal","example":"1800","exampleQuestId":436},{"name":"getitem","count":60,"layer":"Goal","example":"[{id=8980007, count=1}]","exampleQuestId":2005},{"name":"exp","count":30,"layer":"Goal","example":"10000","exampleQuestId":1418},{"name":"meetNPC","count":30,"layer":"Goal","example":"[300012]","exampleQuestId":700}],
  "RewardFields": [{"name":"exp","count":45360,"layer":"Reward","example":"30","exampleQuestId":3},{"name":"getItem","count":32940,"layer":"Reward","example":"[{id=8810011, count=99}, {id=8820011, count=99}]","exampleQuestId":7},{"name":"count","count":32340,"layer":"Reward","example":"99","exampleQuestId":7},{"name":"id","count":32340,"layer":"Reward","example":"8810011","exampleQuestId":7},{"name":"money","count":14220,"layer":"Reward","example":"200","exampleQuestId":2},{"name":"fame","count":14040,"layer":"Reward","example":"1","exampleQuestId":3},{"name":"getSkill","count":8190,"layer":"Reward","example":"[10101]","exampleQuestId":22},{"name":"pvppoint","count":570,"layer":"Reward","example":"3","exampleQuestId":802},{"name":"mileage","count":120,"layer":"Reward","example":"20","exampleQuestId":1804},{"name":"getitem","count":60,"layer":"Reward","example":"[{id=8890212, count=1}]","exampleQuestId":2005}],
  "NpcFields": [{"name":"QSTATE","count":3986,"recognized":false},{"name":"NPC_SAY","count":3549,"recognized":true},{"name":"GET_PLAYER_LEVEL","count":1677,"recognized":false},{"name":"CHECK_ITEM_CNT","count":1583,"recognized":true},{"name":"SET_QUEST_STATE","count":1516,"recognized":true},{"name":"ADD_QUEST_BTN","count":1382,"recognized":true},{"name":"CHECK_INVENTORY_CNT","count":404,"recognized":false},{"name":"GET_PLAYER_JOB1","count":297,"recognized":false},{"name":"SET_MEETNPC","count":187,"recognized":false},{"name":"NPC_QSAY","count":119,"recognized":false},{"name":"GET_PLAYER_JOB2","count":98,"recognized":false},{"name":"ADD_NEW_SHOP_BTN","count":87,"recognized":false},{"name":"SET_INFO","count":63,"recognized":false},{"name":"SET_PLAYER_SEX","count":62,"recognized":false},{"name":"CHECK_SKILL","count":60,"recognized":false},{"name":"GET_PLAYER_FACTION","count":51,"recognized":false},{"name":"GET_PLAYER_FAME","count":30,"recognized":false},{"name":"SET_QUEST_COMPLETE_USEQUESTITEM","count":30,"recognized":false},{"name":"NPC_WARP_THEME_1","count":28,"recognized":false},{"name":"NPC_WARP_THEME_10","count":28,"recognized":false},{"name":"NPC_WARP_THEME_15","count":27,"recognized":false},{"name":"NPC_WARP_THEME_16","count":27,"recognized":false},{"name":"NPC_WARP_THEME_42","count":27,"recognized":false},{"name":"NPC_WARP_THEME_12","count":26,"recognized":false},{"name":"NPC_WARP_THEME_20","count":26,"recognized":false},{"name":"NPC_WARP_THEME_25","count":26,"recognized":false},{"name":"NPC_WARP_THEME_26","count":26,"recognized":false},{"name":"NPC_WARP_THEME_27","count":26,"recognized":false},{"name":"NPC_WARP_THEME_39","count":26,"recognized":false},{"name":"NPC_WARP_THEME_46","count":26,"recognized":false},{"name":"NPC_WARP_TO_CHUNGUM_MARKET_PLACE","count":26,"recognized":false},{"name":"NPC_WARP_THEME_50","count":25,"recognized":false},{"name":"ADD_NPC_WARP_INDUN_EXIT","count":24,"recognized":false},{"name":"NPC_WARP_THEME_18","count":24,"recognized":false},{"name":"NPC_WARP_THEME_34_6","count":24,"recognized":false},{"name":"NPC_WARP_THEME_41","count":24,"recognized":false},{"name":"NPC_WARP_THEME_53","count":24,"recognized":false},{"name":"NPC_WARP_THEME_55","count":24,"recognized":false},{"name":"NPC_WARP_THEME_56","count":24,"recognized":false},{"name":"NPC_WARP_THEME_63","count":24,"recognized":false},{"name":"NPC_WARP_THEME_67","count":24,"recognized":false},{"name":"GET_PLAYER_EQUIPSEANCELEVEL","count":22,"recognized":false},{"name":"FACTION_ON_OFF","count":18,"recognized":false},{"name":"ADD_MOVESOUL_BTN","count":10,"recognized":false},{"name":"ADD_PARCEL_SERVICE_BTN","count":10,"recognized":false},{"name":"ADD_STORE_BTN","count":10,"recognized":false},{"name":"ADD_ENCHANT_BTN","count":9,"recognized":false},{"name":"ADD_PURIFICATION_BTN","count":9,"recognized":false},{"name":"GIVE_DONATION_BUFF","count":9,"recognized":false},{"name":"GIVE_DONATION_ITEM","count":9,"recognized":false},{"name":"NPC_WARP_SILENCE_TEMPLE1","count":9,"recognized":false},{"name":"NPC_WARP_SILENCE_TEMPLE2","count":9,"recognized":false},{"name":"NPC_WARP_SILENCE_TEMPLE3","count":9,"recognized":false},{"name":"CHECK_GUILD_MYUSER","count":8,"recognized":false},{"name":"GET_SEAL_BOX_SOUL_PERSENT","count":7,"recognized":false},{"name":"ADD_EVENT_BTN_JEWEL","count":5,"recognized":false},{"name":"ADD_EX_BTN","count":5,"recognized":false},{"name":"ADD_NPC_WARP_INDUN","count":5,"recognized":false},{"name":"ADD_NPC_WARP_INDUN2","count":5,"recognized":false},{"name":"GET_PLAYER_USESKILLPOINT_C","count":5,"recognized":false},{"name":"GIHON_MIXTURE","count":5,"recognized":false},{"name":"LearnSkill","count":5,"recognized":false},{"name":"ADD_EQUIP_REFINE_BTN","count":4,"recognized":false},{"name":"ADD_REPAIR_EQUIPMENT","count":4,"recognized":false},{"name":"FACTIONWRR_SHOW","count":4,"recognized":false},{"name":"GET_PLAYER_TRANSFORMER","count":4,"recognized":false},{"name":"NPC_SAY_MERGE","count":4,"recognized":true},{"name":"RARE_BOX_MIXTURE","count":4,"recognized":false},{"name":"RARE_BOX_OPEN","count":4,"recognized":false},{"name":"<UNRESOLVED_CALL>","count":3,"recognized":false},{"name":"ADD_DONATION_BTN","count":3,"recognized":false},{"name":"ADD_NPC_GUILD_CREATE","count":3,"recognized":false},{"name":"ADD_RETURN_WARP_BTN","count":3,"recognized":false},{"name":"ADD_SOULALCOHOL_CHANGE_BTN","count":3,"recognized":false},{"name":"ADD_UPGRADE_ITEM_BTN","count":3,"recognized":false},{"name":"GET_NPC_GUILD_LIST","count":3,"recognized":false},{"name":"NECO_HEART_RETURN","count":3,"recognized":false},{"name":"NECO_HEART_SHOW","count":3,"recognized":false},{"name":"NPC_WARP_SILENCE_TEMPLE4","count":3,"recognized":false},{"name":"SET_ITEM_PERCENT","count":3,"recognized":false},{"name":"ADD_BEAUTYSHOP_BTN","count":2,"recognized":false},{"name":"ADD_BTN_WARP_61","count":2,"recognized":false},{"name":"ADD_ENCHANTEACCESSORY_BTN","count":2,"recognized":false},{"name":"ADD_ENCHANTEQUIP_BTN","count":2,"recognized":false},{"name":"ADD_EQUIP_DELIVERY","count":2,"recognized":false},{"name":"ADD_EQUIP_DELIVERY_CURRENT","count":2,"recognized":false},{"name":"ADD_NPC_CARD_DIVINE","count":2,"recognized":false},{"name":"ADD_NPC_CARTOON","count":2,"recognized":false},{"name":"ADD_NPC_WARP_CHUNGYAKANG","count":2,"recognized":false},{"name":"ADD_NPC_WARP_WARRIOR","count":2,"recognized":false},{"name":"ADD_PREMIUM_BEAUTYSHOP_BTN","count":2,"recognized":false},{"name":"EVENT_OX_QUIZ","count":2,"recognized":false},{"name":"EVENT_OX_STATE","count":2,"recognized":false},{"name":"FACTIONWAR_IN","count":2,"recognized":false},{"name":"GET_PLAYER_SKILLPOINT","count":2,"recognized":false},{"name":"GET_PLAYER_STATEPOINT","count":2,"recognized":false},{"name":"GIHON_ENDOWMENT","count":2,"recognized":false},{"name":"GIHON_STRENGTHENING","count":2,"recognized":false},{"name":"NPC_ANSWER_CANCEL","count":2,"recognized":false},{"name":"NPC_WARP_THEME_36_1","count":2,"recognized":false},{"name":"NPC_WARP_TO_DOK_PYO_GONG","count":2,"recognized":false},{"name":"SHOW_FACTION_LIST_1","count":2,"recognized":false},{"name":"WarpTaeULMove","count":2,"recognized":false},{"name":"ADD_10TH_ANNIVERSARY_CAKEDECO_EVENT_GIVE","count":1,"recognized":false},{"name":"ADD_10TH_ANNIVERSARY_CAKEDECO_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_11TH_ANNIVERSARY_SOUVENIR_EVENT_GIVE","count":1,"recognized":false},{"name":"ADD_11TH_ANNIVERSARY_SOUVENIR_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_12THANIVERSARY_SOUVENIR_EVENT_GIVE","count":1,"recognized":false},{"name":"ADD_12THANIVERSARY_SOUVENIR_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_14THANIVERSARY_SOUVENIR_EVENT_GIVE","count":1,"recognized":false},{"name":"ADD_14THANIVERSARY_SOUVENIR_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_16THANIVERSARY_SOUVENIR_EVENT_GIVE","count":1,"recognized":false},{"name":"ADD_16THANIVERSARY_SOUVENIR_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_ANNIVERSARY_EVENT","count":1,"recognized":false},{"name":"ADD_ANNIVERSARY_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_AUCTION_OPEN","count":1,"recognized":false},{"name":"ADD_AUTO_SEARCH_NPC","count":1,"recognized":false},{"name":"ADD_BTN_GEMBLE","count":1,"recognized":false},{"name":"ADD_BTN_HELL_BACKSTREET","count":1,"recognized":false},{"name":"ADD_BTN_HELL_DARKROAD","count":1,"recognized":false},{"name":"ADD_BTN_HELL_OUTSKIRTS","count":1,"recognized":false},{"name":"ADD_BTN_HELL_TOWN_WAR","count":1,"recognized":false},{"name":"ADD_BTN_INDUN_GOD_OF_TREE","count":1,"recognized":false},{"name":"ADD_BTN_NEST_OF_ANCIENT_DRAGON","count":1,"recognized":false},{"name":"ADD_BTN_WEDDING","count":1,"recognized":false},{"name":"ADD_BTN_WEDDING_GETOUT","count":1,"recognized":false},{"name":"ADD_BTN_WEDDING_GIFT","count":1,"recognized":false},{"name":"ADD_BTN_WEDDING_MESSGE","count":1,"recognized":false},{"name":"ADD_BTN_WEDDING_MONEY","count":1,"recognized":false},{"name":"ADD_CHANGE_SEANCECARD_BTN","count":1,"recognized":false},{"name":"ADD_EVENT_BTN_4TH_ANNIVERSARY_MAKE_CAKE","count":1,"recognized":false},{"name":"ADD_EVENT_BTN_4TH_ANNIVERSARY_MAKE_CAKE_SHOW","count":1,"recognized":false},{"name":"ADD_EVENT_BTN_CHRISTMAS_TREE","count":1,"recognized":false},{"name":"ADD_EVENT_BTN_CHRISTMAS_TREE_SHOW","count":1,"recognized":false},{"name":"ADD_EVENT_BTN_D","count":1,"recognized":false},{"name":"ADD_EVENT_BTN_E","count":1,"recognized":false},{"name":"ADD_EVENT_BTN_F","count":1,"recognized":false},{"name":"ADD_EVENT_BTN_G","count":1,"recognized":false},{"name":"ADD_EVENT_BTN_H","count":1,"recognized":false},{"name":"ADD_EVENT_BUFF_TAEGUKi","count":1,"recognized":false},{"name":"ADD_EVENT_GUIDE_ITEM_NEW","count":1,"recognized":false},{"name":"ADD_EVENT_RICE_ROLL1","count":1,"recognized":false},{"name":"ADD_EVENT_RICE_ROLL2","count":1,"recognized":false},{"name":"ADD_FACTION1_EVENT","count":1,"recognized":false},{"name":"ADD_FACTION1_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_FACTION2_EVENT","count":1,"recognized":false},{"name":"ADD_FACTION2_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_GIVE_SOULBOX","count":1,"recognized":false},{"name":"ADD_ITEMLOCK_20130723","count":1,"recognized":false},{"name":"ADD_MAGOO_DONATION_EVENT","count":1,"recognized":false},{"name":"ADD_MAGOO_DONATION_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_MINIGAME_PET_EXIT","count":1,"recognized":false},{"name":"ADD_NEKOMARK_SOUVENIR_EVENT_GIVE","count":1,"recognized":false},{"name":"ADD_NEKOMARK_SOUVENIR_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_NELUMBO_SOUVENIR_EVENT_GIVE","count":1,"recognized":false},{"name":"ADD_NELUMBO_SOUVENIR_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_NPC_CR_REWARD","count":1,"recognized":false},{"name":"ADD_NPC_TOOHO","count":1,"recognized":false},{"name":"ADD_NPC_WARP_A","count":1,"recognized":false},{"name":"ADD_NPC_WARP_B","count":1,"recognized":false},{"name":"ADD_NPC_WARP_HANYA","count":1,"recognized":false},{"name":"ADD_NPC_WARP_INDUN_GHOST","count":1,"recognized":false},{"name":"ADD_NPC_WARP_PVPLEAGUE_OUT","count":1,"recognized":false},{"name":"ADD_NPC_YUT_EVENT","count":1,"recognized":false},{"name":"ADD_OLDUSER_GIFT","count":1,"recognized":false},{"name":"ADD_PVPWINNER_EVENT","count":1,"recognized":false},{"name":"ADD_PVPWINNER_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_SHOP_BTN","count":1,"recognized":false},{"name":"ADD_TOMBSTONE_EVENT","count":1,"recognized":false},{"name":"ADD_TOMBSTONE_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_TOURNAMENT_BTN","count":1,"recognized":false},{"name":"ADD_TOURNAMENT_ENTRY_BTN","count":1,"recognized":false},{"name":"ADD_TOWER_ESCAPE_BTN","count":1,"recognized":false},{"name":"ADD_TREE_EVENT","count":1,"recognized":false},{"name":"ADD_TREE_EVENT_SHOW","count":1,"recognized":false},{"name":"ADD_USE_KEY_BTN","count":1,"recognized":false},{"name":"ADD_WARP_EASY_YANG_15LV","count":1,"recognized":false},{"name":"ADD_WARP_EASY_YANG_25LV","count":1,"recognized":false},{"name":"ADD_WARP_EASY_YANG_35LV","count":1,"recognized":false},{"name":"ADD_WARP_YANGTEMPLE","count":1,"recognized":false},{"name":"ALLI_ATTACK_PROPOSE","count":1,"recognized":false},{"name":"ALLI_CREATE","count":1,"recognized":false},{"name":"ALLI_DEFENSE_SIDE","count":1,"recognized":false},{"name":"ALLI_LISTVIEW","count":1,"recognized":false},{"name":"ALLI_QUEST","count":1,"recognized":false},{"name":"ARMY_BOX_OPEN","count":1,"recognized":false},{"name":"BTN_8YEAR_RETURN","count":1,"recognized":false},{"name":"BTN_8YEAR_SHOW","count":1,"recognized":false},{"name":"BTN_DONATION_FISH","count":1,"recognized":false},{"name":"BTN_HWANGCHUN_ENTER","count":1,"recognized":false},{"name":"BTN_HWANGCHUN_EXIT","count":1,"recognized":false},{"name":"BTN_SNOWMAN_OUT","count":1,"recognized":false},{"name":"CHECK_BLOOD_ROOM","count":1,"recognized":false},{"name":"CW_ENTER","count":1,"recognized":false},{"name":"CW_EXIT","count":1,"recognized":false},{"name":"CW_PROCLAMATION","count":1,"recognized":false},{"name":"CW_REQUEST","count":1,"recognized":false},{"name":"GIVE_REPAY","count":1,"recognized":false},{"name":"GOLD_DONATION","count":1,"recognized":false},{"name":"GOLD_DONATION_SHOW","count":1,"recognized":false},{"name":"HELL_ENTER","count":1,"recognized":false},{"name":"INDUN_NEST_OF_ANCIENT_DRAGON_RAID_RANKING","count":1,"recognized":false},{"name":"INFINITY_DUNGEON_1P","count":1,"recognized":false},{"name":"NPC_OFFER_SHOW","count":1,"recognized":false},{"name":"NPC_WARP_BLOOD_ROOM","count":1,"recognized":false},{"name":"NPC_WARP_GUARD_TO_SUNYOOGOK","count":1,"recognized":false},{"name":"NPC_WARP_NEKOISLAND_ENTER","count":1,"recognized":false},{"name":"NPC_WARP_NEKOISLAND_EXIT","count":1,"recognized":false},{"name":"NPC_WARP_SUNYOOGOK","count":1,"recognized":false},{"name":"NPC_WARP_THEME_22","count":1,"recognized":false},{"name":"NPC_WARP_THEME_34","count":1,"recognized":false},{"name":"NPC_WARP_THEME_37","count":1,"recognized":false},{"name":"NPC_WARP_THEME_51_19","count":1,"recognized":false},{"name":"NPC_WARP_THEME_52_19","count":1,"recognized":false},{"name":"NPC_WARP_TO_BLOODROOM","count":1,"recognized":false},{"name":"NPC_WARP_TO_BLOODUPROOM","count":1,"recognized":false},{"name":"NPC_WARP_TO_LIFEROOM","count":1,"recognized":false},{"name":"NPC_WARP_TO_PAINROOM","count":1,"recognized":false},{"name":"NPC_WARP_TO_SADROOM","count":1,"recognized":false},{"name":"Warp1000suEnter","count":1,"recognized":false}]
}
```

### 缺失字段建议

- Quest 缺失字段: `bQLoop`, `needItem`, `deleteItem`
- Goal 缺失字段: `meetNpc`, `fame`, `timeOut`, `meetNPC`, `exp`, `getitem`
- Reward 缺失字段: `mileage`, `getitem`
- NPC Action 缺失字段: (none)
- NPC 未识别方法（需新增语义解析）: `ADD_NEW_SHOP_BTN`, `GET_PLAYER_JOB1`, `QSTATE`, `GET_PLAYER_LEVEL`, `CHECK_INVENTORY_CNT`, `ADD_AUCTION_OPEN`, `ADD_ITEMLOCK_20130723`, `ADD_NPC_WARP_INDUN_EXIT`, `ADD_EVENT_BTN_H`, `ADD_ENCHANTEQUIP_BTN`, `ADD_ENCHANTEACCESSORY_BTN`, `NPC_QSAY`, `SET_MEETNPC`, `SET_INFO`, `CHECK_GUILD_MYUSER`, `GET_PLAYER_FACTION`, `GIVE_DONATION_BUFF`, `ADD_MOVESOUL_BTN`, `ADD_ENCHANT_BTN`, `ADD_PURIFICATION_BTN`, `ADD_STORE_BTN`, `ADD_EVENT_BTN_D`, `ADD_EVENT_BTN_JEWEL`, `ADD_GIVE_SOULBOX`, `GIVE_DONATION_ITEM`, `ADD_SOULALCOHOL_CHANGE_BTN`, `ADD_PARCEL_SERVICE_BTN`, `GIVE_REPAY`, `NPC_WARP_TO_CHUNGUM_MARKET_PLACE`, `NPC_WARP_THEME_1`, `NPC_WARP_THEME_27`, `NPC_WARP_THEME_16`, `NPC_WARP_THEME_10`, `NPC_WARP_THEME_46`, `NPC_WARP_THEME_20`, `NPC_WARP_THEME_12`, `NPC_WARP_THEME_15`, `NPC_WARP_THEME_18`, `NPC_WARP_THEME_25`, `NPC_WARP_THEME_26`, `NPC_WARP_THEME_34_6`, `NPC_WARP_THEME_39`, `NPC_WARP_THEME_41`, `NPC_WARP_THEME_50`, `NPC_WARP_THEME_53`, `NPC_WARP_THEME_55`, `NPC_WARP_THEME_56`, `NPC_WARP_THEME_63`, `NPC_WARP_THEME_67`, `GIHON_ENDOWMENT`, `GIHON_STRENGTHENING`, `GIHON_MIXTURE`, `ADD_UPGRADE_ITEM_BTN`, `ADD_EQUIP_REFINE_BTN`, `ADD_REPAIR_EQUIPMENT`, `RARE_BOX_OPEN`, `RARE_BOX_MIXTURE`, `ADD_CHANGE_SEANCECARD_BTN`, `ADD_BTN_WEDDING_GETOUT`, `ADD_BEAUTYSHOP_BTN`, `ADD_PREMIUM_BEAUTYSHOP_BTN`, `GET_PLAYER_FAME`, `Warp1000suEnter`, `ADD_SHOP_BTN`, `NPC_WARP_SUNYOOGOK`, `NPC_WARP_THEME_52_19`, `ADD_NPC_WARP_PVPLEAGUE_OUT`, `ADD_NPC_CR_REWARD`, `ARMY_BOX_OPEN`, `ADD_BTN_WARP_61`, `GET_SEAL_BOX_SOUL_PERSENT`, `SET_ITEM_PERCENT`, `GET_PLAYER_TRANSFORMER`, `NPC_OFFER_SHOW`, `NECO_HEART_RETURN`, `NECO_HEART_SHOW`, `GOLD_DONATION`, `GOLD_DONATION_SHOW`, `ADD_OLDUSER_GIFT`, `ADD_EVENT_BTN_4TH_ANNIVERSARY_MAKE_CAKE`, `ADD_EVENT_BTN_4TH_ANNIVERSARY_MAKE_CAKE_SHOW`, `ADD_EVENT_BTN_CHRISTMAS_TREE`, `ADD_EVENT_BTN_CHRISTMAS_TREE_SHOW`, `SET_QUEST_COMPLETE_USEQUESTITEM`, `ADD_TREE_EVENT`, `ADD_TREE_EVENT_SHOW`, `ADD_TOMBSTONE_EVENT`, `ADD_TOMBSTONE_EVENT_SHOW`, `ADD_PVPWINNER_EVENT`, `ADD_PVPWINNER_EVENT_SHOW`, `ADD_EVENT_BUFF_TAEGUKi`, `ADD_FACTION1_EVENT`, `ADD_FACTION1_EVENT_SHOW`, `ADD_FACTION2_EVENT`, `ADD_FACTION2_EVENT_SHOW`, `ADD_NPC_YUT_EVENT`, `ADD_ANNIVERSARY_EVENT`, `ADD_ANNIVERSARY_EVENT_SHOW`, `ADD_MAGOO_DONATION_EVENT`, `ADD_MAGOO_DONATION_EVENT_SHOW`, `BTN_8YEAR_RETURN`, `BTN_8YEAR_SHOW`, `BTN_SNOWMAN_OUT`, `NPC_WARP_NEKOISLAND_EXIT`, `NPC_WARP_NEKOISLAND_ENTER`, `ADD_10TH_ANNIVERSARY_CAKEDECO_EVENT_GIVE`, `ADD_10TH_ANNIVERSARY_CAKEDECO_EVENT_SHOW`, `ADD_11TH_ANNIVERSARY_SOUVENIR_EVENT_GIVE`, `ADD_11TH_ANNIVERSARY_SOUVENIR_EVENT_SHOW`, `ADD_NELUMBO_SOUVENIR_EVENT_GIVE`, `ADD_NELUMBO_SOUVENIR_EVENT_SHOW`, `ADD_12THANIVERSARY_SOUVENIR_EVENT_GIVE`, `ADD_12THANIVERSARY_SOUVENIR_EVENT_SHOW`, `ADD_14THANIVERSARY_SOUVENIR_EVENT_GIVE`, `ADD_14THANIVERSARY_SOUVENIR_EVENT_SHOW`, `ADD_NEKOMARK_SOUVENIR_EVENT_GIVE`, `ADD_NEKOMARK_SOUVENIR_EVENT_SHOW`, `ADD_16THANIVERSARY_SOUVENIR_EVENT_GIVE`, `ADD_16THANIVERSARY_SOUVENIR_EVENT_SHOW`, `ADD_DONATION_BTN`, `ADD_EVENT_BTN_E`, `ADD_EVENT_BTN_F`, `ADD_EVENT_BTN_G`, `ADD_NPC_CARD_DIVINE`, `CW_PROCLAMATION`, `CW_REQUEST`, `CW_ENTER`, `ALLI_CREATE`, `ALLI_QUEST`, `ALLI_LISTVIEW`, `ALLI_DEFENSE_SIDE`, `ALLI_ATTACK_PROPOSE`, `CW_EXIT`, `BTN_DONATION_FISH`, `ADD_EX_BTN`, `CHECK_SKILL`, `GET_PLAYER_USESKILLPOINT_C`, `NPC_WARP_THEME_42`, `GET_PLAYER_JOB2`, `ADD_NPC_GUILD_CREATE`, `GET_NPC_GUILD_LIST`, `ADD_EVENT_RICE_ROLL2`, `ADD_EVENT_RICE_ROLL1`, `NPC_WARP_TO_DOK_PYO_GONG`, `ADD_NPC_CARTOON`, `ADD_NPC_WARP_WARRIOR`, `ADD_NPC_TOOHO`, `EVENT_OX_STATE`, `EVENT_OX_QUIZ`, `ADD_MINIGAME_PET_EXIT`, `FACTION_ON_OFF`, `SHOW_FACTION_LIST_1`, `FACTIONWAR_IN`, `FACTIONWRR_SHOW`, `LearnSkill`, `ADD_BTN_WEDDING`, `ADD_BTN_WEDDING_GIFT`, `ADD_BTN_WEDDING_MESSGE`, `ADD_BTN_WEDDING_MONEY`, `ADD_TOURNAMENT_BTN`, `ADD_RETURN_WARP_BTN`, `GET_PLAYER_STATEPOINT`, `GET_PLAYER_SKILLPOINT`, `ADD_AUTO_SEARCH_NPC`, `ADD_EVENT_GUIDE_ITEM_NEW`, `ADD_NPC_WARP_HANYA`, `ADD_NPC_WARP_B`, `ADD_NPC_WARP_A`, `ADD_USE_KEY_BTN`, `CHECK_BLOOD_ROOM`, `NPC_WARP_BLOOD_ROOM`, `NPC_ANSWER_CANCEL`, `NPC_WARP_THEME_22`, `ADD_TOWER_ESCAPE_BTN`, `NPC_WARP_TO_PAINROOM`, `NPC_WARP_TO_SADROOM`, `NPC_WARP_TO_LIFEROOM`, `NPC_WARP_TO_BLOODROOM`, `NPC_WARP_TO_BLOODUPROOM`, `NPC_WARP_THEME_36_1`, `WarpTaeULMove`, `NPC_WARP_THEME_37`, `ADD_NPC_WARP_CHUNGYAKANG`, `ADD_BTN_GEMBLE`, `ADD_EQUIP_DELIVERY`, `ADD_EQUIP_DELIVERY_CURRENT`, `ADD_WARP_EASY_YANG_15LV`, `ADD_WARP_EASY_YANG_35LV`, `ADD_WARP_EASY_YANG_25LV`, `ADD_WARP_YANGTEMPLE`, `NPC_WARP_THEME_34`, `NPC_WARP_GUARD_TO_SUNYOOGOK`, `NPC_WARP_THEME_51_19`, `ADD_BTN_HELL_BACKSTREET`, `ADD_BTN_HELL_OUTSKIRTS`, `ADD_BTN_HELL_DARKROAD`, `ADD_BTN_HELL_TOWN_WAR`, `NPC_WARP_SILENCE_TEMPLE1`, `NPC_WARP_SILENCE_TEMPLE2`, `NPC_WARP_SILENCE_TEMPLE3`, `SET_PLAYER_SEX`, `NPC_WARP_SILENCE_TEMPLE4`, `HELL_ENTER`, `INFINITY_DUNGEON_1P`, `BTN_HWANGCHUN_EXIT`, `BTN_HWANGCHUN_ENTER`, `ADD_NPC_WARP_INDUN`, `ADD_NPC_WARP_INDUN2`, `ADD_BTN_INDUN_GOD_OF_TREE`, `ADD_BTN_NEST_OF_ANCIENT_DRAGON`, `INDUN_NEST_OF_ANCIENT_DRAGON_RAID_RANKING`, `ADD_NPC_WARP_INDUN_GHOST`, `ADD_TOURNAMENT_ENTRY_BTN`, `GET_PLAYER_EQUIPSEANCELEVEL`

### 字段分类建议

#### Quest 分类

- Identity: `bQLoop`, `id`, `name`
- Dialog: `answer`, `contents`, `info`, `npcsay`
- Condition: `deleteItem`, `needItem`, `needLevel`, `needQuest`, `requstItem`
- Goal/Reward Link: `goal`, `reward`
- Other: (none)

#### Goal 分类

- Identity: (none)
- Dialog: `meetNpc`, `meetNPC`
- Condition: `count`, `getItem`, `getitem`, `id`
- Goal/Reward Link: `killMonster`
- Other: `exp`, `fame`, `timeOut`

#### Reward 分类

- Identity: `exp`, `fame`, `mileage`, `money`, `pvppoint`
- Dialog: (none)
- Condition: `getSkill`
- Goal/Reward Link: `count`, `getItem`, `getitem`, `id`
- Other: (none)

#### NPC 分类

- Dialog: `NPC_SAY`, `NPC_SAY_MERGE`
- Quest State: `ADD_QUEST_BTN`, `SET_QUEST_STATE`
- Item Check: `CHECK_ITEM_CNT`
- Other: `<UNRESOLVED_CALL>`, `ADD_10TH_ANNIVERSARY_CAKEDECO_EVENT_GIVE`, `ADD_10TH_ANNIVERSARY_CAKEDECO_EVENT_SHOW`, `ADD_11TH_ANNIVERSARY_SOUVENIR_EVENT_GIVE`, `ADD_11TH_ANNIVERSARY_SOUVENIR_EVENT_SHOW`, `ADD_12THANIVERSARY_SOUVENIR_EVENT_GIVE`, `ADD_12THANIVERSARY_SOUVENIR_EVENT_SHOW`, `ADD_14THANIVERSARY_SOUVENIR_EVENT_GIVE`, `ADD_14THANIVERSARY_SOUVENIR_EVENT_SHOW`, `ADD_16THANIVERSARY_SOUVENIR_EVENT_GIVE`, `ADD_16THANIVERSARY_SOUVENIR_EVENT_SHOW`, `ADD_ANNIVERSARY_EVENT`, `ADD_ANNIVERSARY_EVENT_SHOW`, `ADD_AUCTION_OPEN`, `ADD_AUTO_SEARCH_NPC`, `ADD_BEAUTYSHOP_BTN`, `ADD_BTN_GEMBLE`, `ADD_BTN_HELL_BACKSTREET`, `ADD_BTN_HELL_DARKROAD`, `ADD_BTN_HELL_OUTSKIRTS`, `ADD_BTN_HELL_TOWN_WAR`, `ADD_BTN_INDUN_GOD_OF_TREE`, `ADD_BTN_NEST_OF_ANCIENT_DRAGON`, `ADD_BTN_WARP_61`, `ADD_BTN_WEDDING`, `ADD_BTN_WEDDING_GETOUT`, `ADD_BTN_WEDDING_GIFT`, `ADD_BTN_WEDDING_MESSGE`, `ADD_BTN_WEDDING_MONEY`, `ADD_CHANGE_SEANCECARD_BTN`, `ADD_DONATION_BTN`, `ADD_ENCHANT_BTN`, `ADD_ENCHANTEACCESSORY_BTN`, `ADD_ENCHANTEQUIP_BTN`, `ADD_EQUIP_DELIVERY`, `ADD_EQUIP_DELIVERY_CURRENT`, `ADD_EQUIP_REFINE_BTN`, `ADD_EVENT_BTN_4TH_ANNIVERSARY_MAKE_CAKE`, `ADD_EVENT_BTN_4TH_ANNIVERSARY_MAKE_CAKE_SHOW`, `ADD_EVENT_BTN_CHRISTMAS_TREE`, `ADD_EVENT_BTN_CHRISTMAS_TREE_SHOW`, `ADD_EVENT_BTN_D`, `ADD_EVENT_BTN_E`, `ADD_EVENT_BTN_F`, `ADD_EVENT_BTN_G`, `ADD_EVENT_BTN_H`, `ADD_EVENT_BTN_JEWEL`, `ADD_EVENT_BUFF_TAEGUKi`, `ADD_EVENT_GUIDE_ITEM_NEW`, `ADD_EVENT_RICE_ROLL1`, `ADD_EVENT_RICE_ROLL2`, `ADD_EX_BTN`, `ADD_FACTION1_EVENT`, `ADD_FACTION1_EVENT_SHOW`, `ADD_FACTION2_EVENT`, `ADD_FACTION2_EVENT_SHOW`, `ADD_GIVE_SOULBOX`, `ADD_ITEMLOCK_20130723`, `ADD_MAGOO_DONATION_EVENT`, `ADD_MAGOO_DONATION_EVENT_SHOW`, `ADD_MINIGAME_PET_EXIT`, `ADD_MOVESOUL_BTN`, `ADD_NEKOMARK_SOUVENIR_EVENT_GIVE`, `ADD_NEKOMARK_SOUVENIR_EVENT_SHOW`, `ADD_NELUMBO_SOUVENIR_EVENT_GIVE`, `ADD_NELUMBO_SOUVENIR_EVENT_SHOW`, `ADD_NEW_SHOP_BTN`, `ADD_NPC_CARD_DIVINE`, `ADD_NPC_CARTOON`, `ADD_NPC_CR_REWARD`, `ADD_NPC_GUILD_CREATE`, `ADD_NPC_TOOHO`, `ADD_NPC_WARP_A`, `ADD_NPC_WARP_B`, `ADD_NPC_WARP_CHUNGYAKANG`, `ADD_NPC_WARP_HANYA`, `ADD_NPC_WARP_INDUN`, `ADD_NPC_WARP_INDUN2`, `ADD_NPC_WARP_INDUN_EXIT`, `ADD_NPC_WARP_INDUN_GHOST`, `ADD_NPC_WARP_PVPLEAGUE_OUT`, `ADD_NPC_WARP_WARRIOR`, `ADD_NPC_YUT_EVENT`, `ADD_OLDUSER_GIFT`, `ADD_PARCEL_SERVICE_BTN`, `ADD_PREMIUM_BEAUTYSHOP_BTN`, `ADD_PURIFICATION_BTN`, `ADD_PVPWINNER_EVENT`, `ADD_PVPWINNER_EVENT_SHOW`, `ADD_REPAIR_EQUIPMENT`, `ADD_RETURN_WARP_BTN`, `ADD_SHOP_BTN`, `ADD_SOULALCOHOL_CHANGE_BTN`, `ADD_STORE_BTN`, `ADD_TOMBSTONE_EVENT`, `ADD_TOMBSTONE_EVENT_SHOW`, `ADD_TOURNAMENT_BTN`, `ADD_TOURNAMENT_ENTRY_BTN`, `ADD_TOWER_ESCAPE_BTN`, `ADD_TREE_EVENT`, `ADD_TREE_EVENT_SHOW`, `ADD_UPGRADE_ITEM_BTN`, `ADD_USE_KEY_BTN`, `ADD_WARP_EASY_YANG_15LV`, `ADD_WARP_EASY_YANG_25LV`, `ADD_WARP_EASY_YANG_35LV`, `ADD_WARP_YANGTEMPLE`, `ALLI_ATTACK_PROPOSE`, `ALLI_CREATE`, `ALLI_DEFENSE_SIDE`, `ALLI_LISTVIEW`, `ALLI_QUEST`, `ARMY_BOX_OPEN`, `BTN_8YEAR_RETURN`, `BTN_8YEAR_SHOW`, `BTN_DONATION_FISH`, `BTN_HWANGCHUN_ENTER`, `BTN_HWANGCHUN_EXIT`, `BTN_SNOWMAN_OUT`, `CHECK_BLOOD_ROOM`, `CHECK_GUILD_MYUSER`, `CHECK_INVENTORY_CNT`, `CHECK_SKILL`, `CW_ENTER`, `CW_EXIT`, `CW_PROCLAMATION`, `CW_REQUEST`, `EVENT_OX_QUIZ`, `EVENT_OX_STATE`, `FACTION_ON_OFF`, `FACTIONWAR_IN`, `FACTIONWRR_SHOW`, `GET_NPC_GUILD_LIST`, `GET_PLAYER_EQUIPSEANCELEVEL`, `GET_PLAYER_FACTION`, `GET_PLAYER_FAME`, `GET_PLAYER_JOB1`, `GET_PLAYER_JOB2`, `GET_PLAYER_LEVEL`, `GET_PLAYER_SKILLPOINT`, `GET_PLAYER_STATEPOINT`, `GET_PLAYER_TRANSFORMER`, `GET_PLAYER_USESKILLPOINT_C`, `GET_SEAL_BOX_SOUL_PERSENT`, `GIHON_ENDOWMENT`, `GIHON_MIXTURE`, `GIHON_STRENGTHENING`, `GIVE_DONATION_BUFF`, `GIVE_DONATION_ITEM`, `GIVE_REPAY`, `GOLD_DONATION`, `GOLD_DONATION_SHOW`, `HELL_ENTER`, `INDUN_NEST_OF_ANCIENT_DRAGON_RAID_RANKING`, `INFINITY_DUNGEON_1P`, `LearnSkill`, `NECO_HEART_RETURN`, `NECO_HEART_SHOW`, `NPC_ANSWER_CANCEL`, `NPC_OFFER_SHOW`, `NPC_QSAY`, `NPC_WARP_BLOOD_ROOM`, `NPC_WARP_GUARD_TO_SUNYOOGOK`, `NPC_WARP_NEKOISLAND_ENTER`, `NPC_WARP_NEKOISLAND_EXIT`, `NPC_WARP_SILENCE_TEMPLE1`, `NPC_WARP_SILENCE_TEMPLE2`, `NPC_WARP_SILENCE_TEMPLE3`, `NPC_WARP_SILENCE_TEMPLE4`, `NPC_WARP_SUNYOOGOK`, `NPC_WARP_THEME_1`, `NPC_WARP_THEME_10`, `NPC_WARP_THEME_12`, `NPC_WARP_THEME_15`, `NPC_WARP_THEME_16`, `NPC_WARP_THEME_18`, `NPC_WARP_THEME_20`, `NPC_WARP_THEME_22`, `NPC_WARP_THEME_25`, `NPC_WARP_THEME_26`, `NPC_WARP_THEME_27`, `NPC_WARP_THEME_34`, `NPC_WARP_THEME_34_6`, `NPC_WARP_THEME_36_1`, `NPC_WARP_THEME_37`, `NPC_WARP_THEME_39`, `NPC_WARP_THEME_41`, `NPC_WARP_THEME_42`, `NPC_WARP_THEME_46`, `NPC_WARP_THEME_50`, `NPC_WARP_THEME_51_19`, `NPC_WARP_THEME_52_19`, `NPC_WARP_THEME_53`, `NPC_WARP_THEME_55`, `NPC_WARP_THEME_56`, `NPC_WARP_THEME_63`, `NPC_WARP_THEME_67`, `NPC_WARP_TO_BLOODROOM`, `NPC_WARP_TO_BLOODUPROOM`, `NPC_WARP_TO_CHUNGUM_MARKET_PLACE`, `NPC_WARP_TO_DOK_PYO_GONG`, `NPC_WARP_TO_LIFEROOM`, `NPC_WARP_TO_PAINROOM`, `NPC_WARP_TO_SADROOM`, `QSTATE`, `RARE_BOX_MIXTURE`, `RARE_BOX_OPEN`, `SET_INFO`, `SET_ITEM_PERCENT`, `SET_MEETNPC`, `SET_PLAYER_SEX`, `SET_QUEST_COMPLETE_USEQUESTITEM`, `SHOW_FACTION_LIST_1`, `Warp1000suEnter`, `WarpTaeULMove`

