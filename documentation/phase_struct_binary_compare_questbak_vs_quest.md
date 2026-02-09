# Phase 3.x - Structural Binary Diff (questbak.luc vs quest.luc)

## Input files
- Original: `D:\\TitanGames\\GhostOnline\\zChina\\Script\\questbak.luc`
- Generated: `D:\\TitanGames\\GhostOnline\\zChina\\Script\\quest.luc`
- Original size: `2231503` bytes
- Generated size: `3687577` bytes
- Size delta: `1456074` bytes

## Parse integrity self-check
- Original parsed bytes: `2231503` / `2231503`, trailing=`0`
- Generated parsed bytes: `3687577` / `3687577`, trailing=`0`
- Function nodes: original=`34`, generated=`34`
- Max depth: original=`1`, generated=`1`
- Comparable nodes: `34`, missing nodes: `0`

## Header compare table
| Field | questbak.luc | quest.luc | Status |
| --- | --- | --- | --- |
| signature | 1B | 1B | SAME |
| encoded | True | True | SAME |
| version | 80 | 80 | SAME |
| endian_flag | 1 | 1 | SAME |
| int_size | 4 | 4 | SAME |
| size_t_size | 4 | 4 | SAME |
| instruction_size | 4 | 4 | SAME |
| op_size | 6 | 6 | SAME |
| a_size | 8 | 8 | SAME |
| b_size | 9 | 9 | SAME |
| c_size | 9 | 9 | SAME |
| number_size | 8 | 8 | SAME |
| test_number_raw_hex | B6099368E7F57D41 | B6099368E7F57D41 | SAME |
| number_integral | False | False | SAME |
| header_size_bytes | 19 | 19 | SAME |

## Full function AST compare table
Covered fields per function: `source`, `lineDefined`, `lastLineDefined`, `nupvalues`, `numparams`, `is_vararg`, `maxstacksize`, `code[]`, `constants[]`, `prototypes[]`, `lineinfo[]`, `localvars[]`, `upvalue names[]`.

| Path | Node | source | lineDefined | lastLineDefined | nupvalues | numparams | is_vararg | maxstacksize | code[] | constants[] | prototypes[] | lineinfo[] | localvars[] | upvalue names[] |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| root | orig=Y,new=Y | DIFF (orig len=11,sha1=e114b090a0b0202b0bc05bd6eb99ff2d562676d0,preview='@quest.lua'; new len=52,sha1=76473c12345d8785add84f11b52391d35df94787,preview='@D:\\TitanGames\\GhostOnline\\zChina\\Script\\quest2.') | SAME (0) | SAME (0) | SAME (0) | SAME (0) | SAME (0) | DIFF (36 -> 37) | DIFF (count 127406/309406, sha1 09bd530f9cef/c024d2ecb3d8) | DIFF (count 24419/24419, sha1 6225a62b146d/f8f310d7e3be, types {'nil': 0, 'boolean': 0, 'number': 5444, 'string': 18975, 'other': 0}/{'nil': 0, 'boolean': 0, 'number': 5444, 'string': 18975, 'other': 0}) | SAME (count 33/33) | DIFF (count 127406/309406, sha1 f2e174b43253/648d13745ff2) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/0 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106404 -> 200148) | SAME (0) | SAME (0) | SAME (0) | SAME (0) | SAME (2) | SAME (count 3/3, sha1 1ff86affe871/1ff86affe871) | SAME (count 1/1, sha1 3f571fb95e08/3f571fb95e08, types {'nil': 0, 'boolean': 0, 'number': 0, 'string': 1, 'other': 0}/{'nil': 0, 'boolean': 0, 'number': 0, 'string': 1, 'other': 0}) | SAME (count 0/0) | DIFF (count 3/3, sha1 68007d8f3471/c01f256c8585) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/1 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106408 -> 200151) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 13/13, sha1 0d7f9e229be5/0d7f9e229be5) | SAME (count 4/4, sha1 fcb64af46343/fcb64af46343, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 2, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 2, 'other': 0}) | SAME (count 0/0) | DIFF (count 13/13, sha1 e5f463dffc92/ef7b7358376f) | SAME (count 1/1, sha1 f21e75204413/f21e75204413) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/10 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106471 -> 200214) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 19/19, sha1 b7a4a82ec89e/b7a4a82ec89e) | SAME (count 7/7, sha1 fd23876d234d/fd23876d234d, types {'nil': 1, 'boolean': 0, 'number': 2, 'string': 4, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 2, 'string': 4, 'other': 0}) | SAME (count 0/0) | DIFF (count 19/19, sha1 c2dfb0529da5/a272e3ae6976) | SAME (count 1/1, sha1 5a83806a39ec/5a83806a39ec) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/11 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106478 -> 200221) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 13/13, sha1 d75c3793497d/d75c3793497d) | SAME (count 3/3, sha1 1f1104bef7d1/1f1104bef7d1, types {'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}) | SAME (count 0/0) | DIFF (count 13/13, sha1 703fa3bedc2d/3e7ce52fc9f1) | SAME (count 1/1, sha1 f21e75204413/f21e75204413) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/12 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106485 -> 200228) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 19/19, sha1 b7a4a82ec89e/b7a4a82ec89e) | SAME (count 7/7, sha1 71bc6fa911dc/71bc6fa911dc, types {'nil': 1, 'boolean': 0, 'number': 2, 'string': 4, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 2, 'string': 4, 'other': 0}) | SAME (count 0/0) | DIFF (count 19/19, sha1 4e922467356d/b4ca8126134b) | SAME (count 1/1, sha1 5a83806a39ec/5a83806a39ec) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/13 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106492 -> 200235) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 19/19, sha1 b7a4a82ec89e/b7a4a82ec89e) | SAME (count 7/7, sha1 3e9320124c9e/3e9320124c9e, types {'nil': 1, 'boolean': 0, 'number': 2, 'string': 4, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 2, 'string': 4, 'other': 0}) | SAME (count 0/0) | DIFF (count 19/19, sha1 eab5ee1e2dd8/8676d04137e1) | SAME (count 1/1, sha1 5a83806a39ec/5a83806a39ec) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/14 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106499 -> 200242) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 13/13, sha1 d75c3793497d/d75c3793497d) | SAME (count 3/3, sha1 d873ee3ac7db/d873ee3ac7db, types {'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}) | SAME (count 0/0) | DIFF (count 13/13, sha1 ff030b0bfd15/ab41ecfd5638) | SAME (count 1/1, sha1 f21e75204413/f21e75204413) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/15 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106506 -> 200249) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 13/13, sha1 d75c3793497d/d75c3793497d) | SAME (count 3/3, sha1 b3f7240f4f8c/b3f7240f4f8c, types {'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}) | SAME (count 0/0) | DIFF (count 13/13, sha1 02f7403a098f/021a21716317) | SAME (count 1/1, sha1 f21e75204413/f21e75204413) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/16 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106513 -> 200256) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 15/15, sha1 5cdb3c31775f/5cdb3c31775f) | SAME (count 5/5, sha1 c2e19e5c5a25/c2e19e5c5a25, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}) | SAME (count 0/0) | DIFF (count 15/15, sha1 4261fe075b0e/42e34589c25a) | SAME (count 1/1, sha1 d125d2971e81/d125d2971e81) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/17 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106520 -> 200263) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 13/13, sha1 d75c3793497d/d75c3793497d) | SAME (count 3/3, sha1 24ab9d6862c9/24ab9d6862c9, types {'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}) | SAME (count 0/0) | DIFF (count 13/13, sha1 a22687fc35eb/02788ec8a90d) | SAME (count 1/1, sha1 f21e75204413/f21e75204413) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/18 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106527 -> 200270) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 13/13, sha1 5842481e325e/5842481e325e) | SAME (count 2/2, sha1 a2942487083c/a2942487083c, types {'nil': 0, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}/{'nil': 0, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}) | SAME (count 0/0) | DIFF (count 13/13, sha1 f63f96e00b20/50106617d2e6) | SAME (count 1/1, sha1 f21e75204413/f21e75204413) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/19 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106534 -> 200277) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 13/13, sha1 5842481e325e/5842481e325e) | SAME (count 2/2, sha1 2c202713e2c5/2c202713e2c5, types {'nil': 0, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}/{'nil': 0, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}) | SAME (count 0/0) | DIFF (count 13/13, sha1 1882219f3e85/6101074e21bd) | SAME (count 1/1, sha1 f21e75204413/f21e75204413) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/2 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106415 -> 200158) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 13/13, sha1 d75c3793497d/d75c3793497d) | SAME (count 3/3, sha1 2b8e764c6d64/2b8e764c6d64, types {'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}) | SAME (count 0/0) | DIFF (count 13/13, sha1 984e0c4b2826/c2716d817627) | SAME (count 1/1, sha1 f21e75204413/f21e75204413) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/20 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106541 -> 200284) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 13/13, sha1 d75c3793497d/d75c3793497d) | SAME (count 3/3, sha1 4fbbaf312644/4fbbaf312644, types {'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}) | SAME (count 0/0) | DIFF (count 13/13, sha1 85f945abb887/cdada9567722) | SAME (count 1/1, sha1 f21e75204413/f21e75204413) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/21 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106548 -> 200291) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 15/15, sha1 5cdb3c31775f/5cdb3c31775f) | SAME (count 5/5, sha1 7a188378eaae/7a188378eaae, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}) | SAME (count 0/0) | DIFF (count 15/15, sha1 65726f2d7e08/a092a991576a) | SAME (count 1/1, sha1 d125d2971e81/d125d2971e81) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/22 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106555 -> 200298) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 15/15, sha1 5cdb3c31775f/5cdb3c31775f) | SAME (count 5/5, sha1 f9370728e4f8/f9370728e4f8, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}) | SAME (count 0/0) | DIFF (count 15/15, sha1 a99b11097c28/304989e7fbe8) | SAME (count 1/1, sha1 d125d2971e81/d125d2971e81) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/23 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106562 -> 200305) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 15/15, sha1 5cdb3c31775f/5cdb3c31775f) | SAME (count 5/5, sha1 4ac319ad4f18/4ac319ad4f18, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}) | SAME (count 0/0) | DIFF (count 15/15, sha1 d78caff59729/c7f5a397487c) | SAME (count 1/1, sha1 d125d2971e81/d125d2971e81) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/24 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106569 -> 200312) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 15/15, sha1 5cdb3c31775f/5cdb3c31775f) | SAME (count 5/5, sha1 2a0632db3098/2a0632db3098, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}) | SAME (count 0/0) | DIFF (count 15/15, sha1 79175e2547d5/77b6ca12e2b5) | SAME (count 1/1, sha1 d125d2971e81/d125d2971e81) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/25 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106576 -> 200319) | SAME (0) | SAME (0) | SAME (2) | SAME (0) | SAME (3) | SAME (count 17/17, sha1 51a40bd6a9ca/51a40bd6a9ca) | SAME (count 6/6, sha1 5a20a2c23f5b/5a20a2c23f5b, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 4, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 4, 'other': 0}) | SAME (count 0/0) | DIFF (count 17/17, sha1 e9ab70fa74f5/8259b6fecab0) | SAME (count 2/2, sha1 04623680ca69/04623680ca69) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/26 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106583 -> 200326) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 16/16, sha1 61d68fc06ef4/61d68fc06ef4) | SAME (count 6/6, sha1 cbadd0cd2d63/cbadd0cd2d63, types {'nil': 1, 'boolean': 0, 'number': 2, 'string': 3, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 2, 'string': 3, 'other': 0}) | SAME (count 0/0) | DIFF (count 16/16, sha1 26d8252e945d/8b2a2b811205) | SAME (count 1/1, sha1 72747fef42b8/72747fef42b8) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/27 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106590 -> 200333) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (3) | SAME (count 18/18, sha1 cc06f423a698/cc06f423a698) | SAME (count 7/7, sha1 dd85df4138c2/dd85df4138c2, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 5, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 5, 'other': 0}) | SAME (count 0/0) | DIFF (count 18/18, sha1 837229ebd993/4404165cb6d0) | SAME (count 1/1, sha1 2a17f8194555/2a17f8194555) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/28 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106597 -> 200340) | SAME (0) | SAME (0) | SAME (2) | SAME (0) | SAME (3) | SAME (count 17/17, sha1 51a40bd6a9ca/51a40bd6a9ca) | SAME (count 6/6, sha1 ccdb1a29e1d9/ccdb1a29e1d9, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 4, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 4, 'other': 0}) | SAME (count 0/0) | DIFF (count 17/17, sha1 6b0f8a63d19e/c4962f305480) | SAME (count 2/2, sha1 04623680ca69/04623680ca69) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/29 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106604 -> 200347) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 15/15, sha1 5cdb3c31775f/5cdb3c31775f) | SAME (count 5/5, sha1 9e0a4a5a873c/9e0a4a5a873c, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}) | SAME (count 0/0) | DIFF (count 15/15, sha1 c8b10ed571ab/c18afa3fb6d4) | SAME (count 1/1, sha1 d125d2971e81/d125d2971e81) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/3 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106422 -> 200165) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 13/13, sha1 d75c3793497d/d75c3793497d) | SAME (count 3/3, sha1 33e494b4323d/33e494b4323d, types {'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 0, 'string': 2, 'other': 0}) | SAME (count 0/0) | DIFF (count 13/13, sha1 483ed7343d57/6acbc9a55545) | SAME (count 1/1, sha1 f21e75204413/f21e75204413) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/30 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106611 -> 200354) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (3) | SAME (count 18/18, sha1 cc06f423a698/cc06f423a698) | SAME (count 7/7, sha1 08968c7e9508/08968c7e9508, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 5, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 5, 'other': 0}) | SAME (count 0/0) | DIFF (count 18/18, sha1 f419e3eabff4/ab81430edc60) | SAME (count 1/1, sha1 2a17f8194555/2a17f8194555) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/31 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106618 -> 200361) | SAME (0) | SAME (0) | SAME (2) | SAME (0) | SAME (3) | SAME (count 17/17, sha1 51a40bd6a9ca/51a40bd6a9ca) | SAME (count 6/6, sha1 44daa35b54b4/44daa35b54b4, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 4, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 4, 'other': 0}) | SAME (count 0/0) | DIFF (count 17/17, sha1 1b7ba446182b/5456db85a163) | SAME (count 2/2, sha1 04623680ca69/04623680ca69) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/32 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106625 -> 200368) | SAME (0) | SAME (0) | SAME (2) | SAME (0) | SAME (3) | SAME (count 17/17, sha1 51a40bd6a9ca/51a40bd6a9ca) | SAME (count 6/6, sha1 a2a2cc95463b/a2a2cc95463b, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 4, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 4, 'other': 0}) | SAME (count 0/0) | DIFF (count 17/17, sha1 79b56c4e56c1/960241c7225c) | SAME (count 2/2, sha1 04623680ca69/04623680ca69) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/4 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106429 -> 200172) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 15/15, sha1 da8778b7d3e2/da8778b7d3e2) | SAME (count 4/4, sha1 a0f0c8b97d87/a0f0c8b97d87, types {'nil': 1, 'boolean': 0, 'number': 0, 'string': 3, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 0, 'string': 3, 'other': 0}) | SAME (count 0/0) | DIFF (count 15/15, sha1 13b2fdf3f395/d3f8647fef07) | SAME (count 1/1, sha1 d125d2971e81/d125d2971e81) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/5 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106436 -> 200179) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 19/19, sha1 b7a4a82ec89e/b7a4a82ec89e) | SAME (count 7/7, sha1 7617a01b1323/7617a01b1323, types {'nil': 1, 'boolean': 0, 'number': 2, 'string': 4, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 2, 'string': 4, 'other': 0}) | SAME (count 0/0) | DIFF (count 19/19, sha1 aaf4e6b71669/b09e16daf063) | SAME (count 1/1, sha1 5a83806a39ec/5a83806a39ec) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/6 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106443 -> 200186) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 19/19, sha1 b7a4a82ec89e/b7a4a82ec89e) | SAME (count 7/7, sha1 d27c4fc4ed6e/d27c4fc4ed6e, types {'nil': 1, 'boolean': 0, 'number': 2, 'string': 4, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 2, 'string': 4, 'other': 0}) | SAME (count 0/0) | DIFF (count 19/19, sha1 5802d6fc8b1e/2175f28aca09) | SAME (count 1/1, sha1 5a83806a39ec/5a83806a39ec) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/7 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106450 -> 200193) | SAME (0) | SAME (0) | SAME (2) | SAME (0) | SAME (3) | SAME (count 17/17, sha1 d339d39f5cec/d339d39f5cec) | SAME (count 5/5, sha1 aa891301280c/aa891301280c, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}) | SAME (count 0/0) | DIFF (count 17/17, sha1 cfd4f485f9c2/a6ac57620819) | SAME (count 2/2, sha1 5491860dd1d7/5491860dd1d7) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/8 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106457 -> 200200) | SAME (0) | SAME (0) | SAME (2) | SAME (0) | SAME (3) | SAME (count 17/17, sha1 d339d39f5cec/d339d39f5cec) | SAME (count 5/5, sha1 aa891301280c/aa891301280c, types {'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 1, 'string': 3, 'other': 0}) | SAME (count 0/0) | DIFF (count 17/17, sha1 e7555dcace48/6c884073bcd4) | SAME (count 2/2, sha1 5491860dd1d7/5491860dd1d7) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |
| root/9 | orig=Y,new=Y | DIFF (orig len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview=''; new len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') | DIFF (106464 -> 200207) | SAME (0) | SAME (0) | SAME (1) | SAME (0) | SAME (2) | SAME (count 15/15, sha1 da8778b7d3e2/da8778b7d3e2) | SAME (count 4/4, sha1 085837065da0/085837065da0, types {'nil': 1, 'boolean': 0, 'number': 0, 'string': 3, 'other': 0}/{'nil': 1, 'boolean': 0, 'number': 0, 'string': 3, 'other': 0}) | SAME (count 0/0) | DIFF (count 15/15, sha1 b625fedae5e1/4e1535b62c33) | SAME (count 1/1, sha1 d125d2971e81/d125d2971e81) | SAME (count 0/0, sha1 da39a3ee5e6b/da39a3ee5e6b) |

## Difference details (first-diff locator)
- root.source: orig(len=11,sha1=e114b090a0b0202b0bc05bd6eb99ff2d562676d0,preview='@quest.lua') vs new(len=52,sha1=76473c12345d8785add84f11b52391d35df94787,preview='@D:\\TitanGames\\GhostOnline\\zChina\\Script\\quest2.')
- root.maxstacksize: 36 -> 37
- root.code[]: first diff idx=4, 5 -> 266, count 127406/309406
- root.constants[]: first diff idx=3, numraw:0000000000000040 -> str:len=3:sha1=87ea5dfc8b8e384d848979496e706390b497e547, count 24419/24419
- root.lineinfo[]: first diff idx=0, 17 -> 1
- root/0.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/0.lineDefined: 106404 -> 200148
- root/0.lineinfo[]: first diff idx=0, 106405 -> 200149
- root/1.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/1.lineDefined: 106408 -> 200151
- root/1.lineinfo[]: first diff idx=0, 106409 -> 200152
- root/10.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/10.lineDefined: 106471 -> 200214
- root/10.lineinfo[]: first diff idx=0, 106472 -> 200215
- root/11.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/11.lineDefined: 106478 -> 200221
- root/11.lineinfo[]: first diff idx=0, 106479 -> 200222
- root/12.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/12.lineDefined: 106485 -> 200228
- root/12.lineinfo[]: first diff idx=0, 106486 -> 200229
- root/13.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/13.lineDefined: 106492 -> 200235
- root/13.lineinfo[]: first diff idx=0, 106493 -> 200236
- root/14.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/14.lineDefined: 106499 -> 200242
- root/14.lineinfo[]: first diff idx=0, 106500 -> 200243
- root/15.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/15.lineDefined: 106506 -> 200249
- root/15.lineinfo[]: first diff idx=0, 106507 -> 200250
- root/16.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/16.lineDefined: 106513 -> 200256
- root/16.lineinfo[]: first diff idx=0, 106514 -> 200257
- root/17.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/17.lineDefined: 106520 -> 200263
- root/17.lineinfo[]: first diff idx=0, 106521 -> 200264
- root/18.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/18.lineDefined: 106527 -> 200270
- root/18.lineinfo[]: first diff idx=0, 106528 -> 200271
- root/19.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/19.lineDefined: 106534 -> 200277
- root/19.lineinfo[]: first diff idx=0, 106535 -> 200278
- root/2.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/2.lineDefined: 106415 -> 200158
- root/2.lineinfo[]: first diff idx=0, 106416 -> 200159
- root/20.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/20.lineDefined: 106541 -> 200284
- root/20.lineinfo[]: first diff idx=0, 106542 -> 200285
- root/21.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/21.lineDefined: 106548 -> 200291
- root/21.lineinfo[]: first diff idx=0, 106549 -> 200292
- root/22.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/22.lineDefined: 106555 -> 200298
- root/22.lineinfo[]: first diff idx=0, 106556 -> 200299
- root/23.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/23.lineDefined: 106562 -> 200305
- root/23.lineinfo[]: first diff idx=0, 106563 -> 200306
- root/24.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/24.lineDefined: 106569 -> 200312
- root/24.lineinfo[]: first diff idx=0, 106570 -> 200313
- root/25.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/25.lineDefined: 106576 -> 200319
- root/25.lineinfo[]: first diff idx=0, 106577 -> 200320
- root/26.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/26.lineDefined: 106583 -> 200326
- root/26.lineinfo[]: first diff idx=0, 106584 -> 200327
- root/27.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/27.lineDefined: 106590 -> 200333
- root/27.lineinfo[]: first diff idx=0, 106591 -> 200334
- root/28.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/28.lineDefined: 106597 -> 200340
- root/28.lineinfo[]: first diff idx=0, 106598 -> 200341
- root/29.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/29.lineDefined: 106604 -> 200347
- root/29.lineinfo[]: first diff idx=0, 106605 -> 200348
- root/3.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/3.lineDefined: 106422 -> 200165
- root/3.lineinfo[]: first diff idx=0, 106423 -> 200166
- root/30.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/30.lineDefined: 106611 -> 200354
- root/30.lineinfo[]: first diff idx=0, 106612 -> 200355
- root/31.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/31.lineDefined: 106618 -> 200361
- root/31.lineinfo[]: first diff idx=0, 106619 -> 200362
- root/32.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/32.lineDefined: 106625 -> 200368
- root/32.lineinfo[]: first diff idx=0, 106626 -> 200369
- root/4.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/4.lineDefined: 106429 -> 200172
- root/4.lineinfo[]: first diff idx=0, 106430 -> 200173
- root/5.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/5.lineDefined: 106436 -> 200179
- root/5.lineinfo[]: first diff idx=0, 106437 -> 200180
- root/6.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/6.lineDefined: 106443 -> 200186
- root/6.lineinfo[]: first diff idx=0, 106444 -> 200187
- root/7.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/7.lineDefined: 106450 -> 200193
- root/7.lineinfo[]: first diff idx=0, 106451 -> 200194
- root/8.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/8.lineDefined: 106457 -> 200200
- root/8.lineinfo[]: first diff idx=0, 106458 -> 200201
- root/9.source: orig(len=0,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='') vs new(len=1,sha1=da39a3ee5e6b4b0d3255bfef95601890afd80709,preview='')
- root/9.lineDefined: 106464 -> 200207
- root/9.lineinfo[]: first diff idx=0, 106465 -> 200208

## File size delta by AST field category
| Field category | questbak.luc bytes | quest.luc bytes | delta(new-orig) |
| --- | --- | --- | --- |
| lineinfo | 511768 | 1239768 | 728000 |
| code | 511768 | 1239768 | 728000 |
| source | 147 | 221 | 74 |
| func_scalar | 272 | 272 | 0 |
| localvars | 756 | 756 | 0 |
| upvalue_names | 136 | 136 | 0 |
| constants | 1206501 | 1206501 | 0 |
| prototypes_count | 136 | 136 | 0 |

## Which fields cause file size delta
- Non-zero delta categories: `lineinfo (+728000), code (+728000), source (+74)`

## Fields used by game.exe in verified parse chain
- Parse chain: `sub_9DB000 -> sub_9DAD80 -> sub_9CEDB0 -> sub_9D1BD0 -> sub_9D8770 -> sub_9D8750 -> sub_9D8610 -> sub_9D84D0`.
- Strongly checked / branch-relevant: header magic, version, sizeof(int), sizeof(size_t), instruction size, OP/A/B/C bit widths, number size, test number, string length fields, constant type tags, upvalue-name count consistency, code validity path (`sub_9D0B20`).
- Parsed but not branch-driving in verified chain: source text, `lineDefined`, `lastLineDefined`, `lineinfo[]`, `localvars[]`, upvalue-name text payload (count consistency still required).

## Minimum required field checklist
### Must match original questbak.luc (for semantic-equivalent script + parser pass)
- Header strong-check bytes and test number.
- Function signature fields: `nupvalues`, `numparams`, `is_vararg`, `maxstacksize`.
- `code[]` values and count.
- `constants[]` type/order/value bytes.
- `prototypes[]` hierarchy/count/content.
- All string length fields must match actual payload layout.

### Can be regenerated freely (does not block parser path)
- `source` text payload.
- `lineDefined`, `lastLineDefined`.
- `lineinfo[]` content.
- `localvars[]` content.
- Upvalue-name text payload (while keeping count consistent with `nupvalues`).

## Self-check
- [x] Parsed both files into full Lua 5.0 chunk trees (header + function/debug subtrees).
- [x] Produced per-field compare table for all function nodes.
- [x] Marked count equality and value/hash equality per array field.
- [x] Identified AST categories driving size delta.
- [x] Classified parser-critical vs non-branch-driving fields for game.exe chain.
