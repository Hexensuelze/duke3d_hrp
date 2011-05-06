         ==================================================================
         |            DUKE NUKEM 3D HIGH RESOLUTION PACK (HRP)            |
         |                                                                |
         |                   A Duke3D Community project                   |
         |                                                                |                      
         |                compiled by Parkar & NightFright                |
         ==================================================================
         |                 SVN build #321 (Mar 23, 2009)                  |
         ==================================================================



=======================
CONTENTS OF THIS README
=======================

1) About
2) Installation
3) Notes
   3.1) WIP release
   3.2) Known issues
   3.3) Title screen art
   3.4) EDuke32 port
4) License
   4.1) HRP
   4.2) Others
5) Contact/Links
6) Credits
7) Changelog




========
1) ABOUT
========

Remember "Duke Nukem 3D", the great first-person shooter 3D Realms released back in 
1996? Its cool protagonist, ingame atmosphere, original weaponry and many other 
features make it worth playing even today.

For all Duke fans who want to play the game again in a modern Windows environment 
with 3D accelerated graphics, the Duke3D community has created the High Resolution 
Pack (HRP). Utilizing the amazing skills of various texturing and modelling artists, 
the project´s goal is to replace all textures and sprites with high-res versions, 
optimizing it for latest OpenGL ports.

All you need is the "duke3d.grp" file from your original Duke3D v1.3d or 
Atomic (v1.5) CD-ROM. You can also play with the shareware version available 
over at http://www.3drealms.com/downloads.html . 

Here's what the Duke3D HRP has to offer: 
   - EDuke32 port for Duke Nukem 3D (by TerminX and Plagman, based on JFDuke3D by 
     Jonathon "JonoF" Fowler). Which one is included depends on how well they support 
     the current HRP version. 
     For more info about these ports, check out JonoF's JFDuke3D and the EDuke32 site. 
   - 32-bit high resolution textures with 4-8 times the detail of the original textures. 
   - Models instead of the old sprites. 

While the HRP is still "work in progress" and missing quite a few textures and 
models, you can check the Duke Nukem 3D source code forums for additional content 
or even better contributing something of your own.

The community's goal is to issue a new HRP version once in 1-2 year(s) or anytime 
JonoF comes up with a new milestone of the JFDuke3D port. For the impatient ones, 
NightFright is offering an update pack every one or two months, integrating latest 
forum contributions and fixes into the HRP. You can find these updates over at
http://hrpupdate.duke4.net .



===============
2) INSTALLATION
===============

Installing is easy:

First make sure you have your Duke3D CD in your CD/DVD drive or an existing 
installation of the game. You can also just have the "duke3d.grp" file somewere 
on your system.

Then run the installer (the file you downloaded/got from a friend or whatever) 
by double-clicking it. Then just follow the onscreen instructions.

After installation, you start the game using the shortcut in the Duke3D folder, 
desktop or start menu called "Duke3D High Resolution Pack". Starting the game 
directly will start JFDuke3D (or EDuke32) without textures and models.

IMPORTANT: To see the high resolution textures and models you have to change the 
           render mode to 32-bit Polymost in the "Video Settings" under "Options" 
           in the game menu. Otherwise, HRP content will not work!

It is recommended to run the setup utility in order to set up your video, audio 
and controls for optimum quality and gameplay experience. However, most of the 
settings can be changed with EDuke32 ingame menu as well.



========
3) NOTES
========


----------------
3.1) WIP release
---------------- 
Since this is a work in progress version of the pack which has not been tested 
extensively, there are probably some issues that need fixing. Please let us 
know of any problems with it so they can be sorted out in future versions. Also 
notify us if we are missing any art that’s been released prior to the packs 
release date, even though we have skipped some stuff since we simply did not like 
it, there is maybe some stuff that has been missed to include.

Please also be aware of the fact that we are still missing models and textures
because these have not been remade yet by the community. They will probably
be featured in upcoming releases of the HRP (or updates).

For a full summary of what's left to do, you may have a look at the HRP Wiki
todo-list: http://hrp.duke4.net/wiki/doku.php?id=other:next_hrp_release


-----------------
3.2) Known issues
----------------- 
Although we tried hard to eliminate or avoid any glitches, unfortunately 
some of them could not be removed in this release. Here are those we know of:

- Rarely you will still find props, pickup weapons or the like that are
  clipping into walls, often preventing you from seeing them completely. 
  Maphacks since January 2008 can fix these glitches, so don't hesitate to
  report anything you consider worthy of correcting.

- Slime babe #1323 has a transparency/clipping bug with her hair. Updating
  the model should solve that problem.

- If you use OpenGL texture compression/disk caching in EDuke32, the skyboxes 
  will lose detail, i.e. look more pixellated than intended. This can be 
  especially noticed with L.A. Night skybox (as seen in E1L1) when looking at
  the clouds. Right now, your only choice to fix this is to deactivate texture 
  compression in the menu. Note that this will also deactivate disk caching, so 
  you will have to deal with increased level loading times and possibly jerky 
  framerates in some situations.


---------------------
3.3) Title screen art
---------------------
The front screen is a slightly modified and enhanced version of 3DRealms original
art work used with permission.


-----------------
3.4) EDuke32 port
-----------------
The EDuke32 port is an enhanced version of JonoF's initial JFDuke3D port and
features enhanced mod support together with tons of newly-added code. It is 
released and maintained by TerminX.
For the time being, we recommend using EDuke32 for running HRP because the port 
gets updated much more often and HRP content has been optimized for it.



===========
4) LICENSES
===========


--------
4.1) HRP 
--------

The contents of the High Resolution Pack are licensed under these three licenses:

- The build engine is licensed under Ken Silverman's Build License which can be 
  found in "BUILDLIC.TXT".
- The EDuke32 port is licensed under the GNU Public license which can be found 
  in "GNU.TXT".
- The art content is licensed under the High Resolution Pack Art License which can 
  be found in "hrp_art_license.txt".


-----------
4.2) Others
-----------

Some textures in this pack are based on source textures copyrighted by 
CGTextures.com. Permission to use and distribute these specific textures has 
been granted to the author(s) of this texture pack. Textures downloaded from 
CGTextures.com are copyrighted and may NOT be redistributed or sold. For 
more information and the full license, please visit http://www.cgtextures.com.

This disclaimer applies to the following textures:
- highres\sprites\props: 585
- highres\sprites\signs: 4420, 4949, 4955
- highres\textures: 1120



================
5) CONTACT/LINKS
================


Pär "Parkar" Karlsson 
(HRP author) ....................................... parkar82 [at] gmail.com


Robin "NightFright" Reisinger
(HRP co-author, HRP Update Pack author) ............ hrp_update [at] fastmail.fm


Richard "TerminX" Gobeille
(EDuke32 port author) .............................. terminx [at] gmail.com


-----------------------
3DRealms message boards
-----------------------
http://www.3drealms.com/forums.html

The texture and model projects can be found in the Duke Nukem 3D source board:
http://forums.3drealms.com/vb/forumdisplay.php?f=17


------------
IRC channels
------------
- 3D Realms IRC Fan Channel ..... #3dr@irc.quakenet.org
- JFDuke3D @ IRC ................ #jfduke@irc.freenode.net


----------------
Visit us online!
----------------
- Duke3D High Resolution Pack ... http://hrp.duke4.net
- Duke3D HRP Update Pack Site ... http://hrpupdate.duke4.net
- EDuke32 port (by TerminX) ..... http://eduke32.com
- Duke4.net ..................... http://www.duke4.net



==========
6) CREDITS
==========

All the following people are involved in this release. They all have our gratitude,
for nothing of the great artwork (or pretty much anything else) would have been 
possible to include without their support and effort.  
Please notify us if you did contribute to this project without being listed here!


-------------
JFDuke3D port
-------------
JonoF
Ken Silverman


------------
EDuke32 port
------------
Plagman
TerminX


----------------
Highres textures
----------------
0815Jack
ADM
Alexander Filippov
AlgorithMan
Conrad Coldwood 
Another Duke Fan
Armando
Audiocraz
BlitZ
cage
chicken
Daedolon
Devastator
Ding Bat
DLT
dood!
Dreams
DukeAtomic
Ecmaster76
endmilled
Fearpi
Gman
gt1750
Hendricks266
Impact
JaJo
Jblade
jimbob
Kef Nukem
Kev_Hectic
Kevin9er
Killd a ton
L2theKING
Lemming
marked
motionblur
NightFright
Night Hacker 
nyne
ooppee
Parkar
Piccolo
Piterplus
princetonEO
Rellik66
Roger
Quakis
Semicharm
Sky Fox
Swiss Cheeseman/SwissCM
Tesserex
theRobot
toadie2k
Tip
Vasilinka
Viciarg
WarHammer
White Alven
yossa


-------------------
3D models and skins
-------------------
alandog
AlgorithMan
Besli
Blunty 
Cipher
Conrad Coldwood
dood!
Dr. Kill
DukeAtomic
drvarek 
Ecmaster76
efikkan
Eric R
escapist
Esslan
FlackenWS
Forder
General Failure
GodBlitZor
gt1750
Hellbound
ilovefoxes
Jokke_r
Killd a ton
Kralex
L2theKING
Madaut
MagNet
Mean Person
motionblur
Mr.Fibbles
Parkar
Piterplus
Plagman
Radar1013
Renegado 
Roma Loom
Sky Fox
Soul Collector
Swiss Cheeseman/SwissCM
Tea Monster
Vasilinka
YicklePigeon
zilppuri


--------
Maphacks
--------
Dave-ros
DSotM
Ecmaster76
endmilled
ikkejw
Killd a ton
Night Hacker
noctrun
Okira
Piterplus
Renegado
Zebius


-----------------
Maphacks Reloaded
-----------------
Hunter_rus
NightFright


------------
HRP assembly
------------
NightFright
Parkar


-----------------
Special thanks to
-----------------
- 3D Realms, for making this great game in the first place!
- The guys at Duke4.net for hosting and help building the HRP website.
- All of you who support and contribute to the project.
- All the mirrors and seeders.



============
7) CHANGELOG
============

Here is a list of all changes that have been included in this release since last
HRP v3.0 (SVN #136, 2007-04-27). This includes any previous Update Packs compiled 
by NightFright.


HRP v4.0 / SVN #321 (2009-03-23)
--------------------------------
> Added:
     - From SD_Duke:
          + Ice/frozen textures for most of the monsters, Duke and babes 
            (in new subdir highres\sprites\ice)
          + highres\sprites\effects: 1031 (GLASSPIECES), 1380-1384 (watersplash),
                                     2390-2418 (scrap1-6), 2595 (SHOTSPARK1)
     - Detail textures for 
          + not yet remade tiles: 4154, 4155
          + remade tiles: 1132, 1134, 1135
          + (many) characters, effects, monsters, pickups, props, signs, switches
     - Glowmaps for
          + highres\sprites\props: 543
          + highres\textures: 294-296, 309, 451, 1215
     - highres\detail: marble (for 3384-3387)
     - highres\screen\fonts\smallfont: 3072-3135, 3162-3165 (pal6/7)
     - highres\screen\hud: 27, 38, 40-42, 44-47, 49, 51, 54 (HUD icons), 61, 
                           2458, 2466, 2527
     - highres\screen\menu: 2494-2496, 3250
     - highres\sprites\characters: 753 (geisha), 1317 (pal0/10-16/21/23), 
                                   1325 (cavedancer), 1356/1357 (Terminator), 
                                   1395 (FEM7, pal0/10-16/21/23), 3450 (FEM9),
                                   4510 (PIRATE1A/4A pal0/10), 4516 (PIRATEHALF), 
                                   4864 (FEM10), 4866 (TOUGHGAL)
     - highres\sprites\decals: 1154, 4445, 4535
     - highres\sprites\effects: 580-583 (REACTOR2SPARK, pal0/21), 
                                634-637 (BOLT1, pal0/2/10), 
                                663 (W_FORCEFIELD, pal 2/7/8/10),
                                1092 (REACTORSPARK), 1250-1259 ([CEILING]STEAM), 
                                1671-1679 (FORCERIPPLE), 2066-2079 (fire #1),
                                2270-2283 (BURNING/FIRE), 2310-2323 (fire #2)
                                4525-4528 (SIDEBOLT1, pal0/10)
     - highres\sprites\firstperson: 2521/2522 (pal10-16/21/23), 2576 (tiphand), 
                                    2581 (scuba)
     - highres\sprites\ice: 1318 (1317 frozen), 1326 (1325 frozen), 1396 (1395 frozen), 
                            3450 (frozen), 4864 (frozen), 4866 (frozen)
     - highres\sprites\jibs: 2260 (JIBS4), 2264, 2300 (OOZ), 2309 (OOZ2)
     - highres\sprites\monsters: 2000 (skins for pal1/2/5/7/8-25)
     - highres\sprites\pickups: 32 (Expander)
     - highres\sprites\projectiles: 1646-1649 (shrinkray), 1656-1659 (shr.blast),
                                    2448-2451 (expander blast)
     - highres\sprites\props: 487 (model), 517, 555, 572, 584, 585, 610, 616, 
                              617, 619, 633, 665, 954, 958, 1012, 1013, 1034, 
                              1038, 1078, 1113/1114, 1157, 1221, 1225, 1275, 
                              1390, 3418, 3429, 4397/4398, 4415-4417, 4430-4432, 
                              4446, 4480-4482 (pal0/10/13/14), 4530, 4533, 4549, 
                              4570, 4583, 4585-4587
     - highres\sprites\signs: 586 (pal21-23), 987, 1000, 1001, 3272, 3330-3340, 
                              3373/3374, 3421-3423, 4270 (pal0/8/15), 4378, 
                              4381-4385 (added, but commented out), 4420, 4447, 
                              4470, 4487, 4488, 4492 (pal0/15), 4883, 4887, 4893, 
                              4921-4923, 4936, 4940, 4947, 4949, 4955, 4957
     - highres\sprites\switches: 142 (pal13), 4483
     - highres\textures: 90, 193, 194, 199, 224, 278, 304, 348, 401-403, 405, 
                         406, 411, 442 (pal8), 444, 472, 477, 501, 533-535, 630, 
                         638, 707/708 (pal7/8), 726, 740, 850, 878, 1068, 1099, 
                         1105-1107, 1108 (pal8), 1120, 1127, 1129, 1132 (pal8), 
                         1136, 1138, 1144 (pal0/13/14), 1151, 1152 (pal0/14/15), 
                         1194-1196, 1199, 1298-1305 (FEMPIC3), 2920, 2921, 
                         3407 (pal13/24), 4100, 4125, 4126, 4138, 4139, 4142, 
                         4143, 4176, 4275, 4290-4293, 4296, 4437, 4500, 4501, 
                         5064, 5094, 5105, 5110-5116, 5117

> Fixes:
     - duke3d_hrp.def: pal8 tint improved 
     - highres\skyboxes.def: OpenGL texture compression deactivated for all 
                             skyboxes ("nocompress") for better quality
     - highres\sprites\characters.def: 603 (flipped) in Ep.3 corrected;
                                       1321/1325/1334 scale increased;
                                       1405 scale decreased/model disappearing
                                       when swimming near floor fixed
     - highres\sprites\effects.def: 1890-1910 (explosion2) restored;
                                    all "dummytilerange" commands removed
     - highres\sprites\jibs.def: 1520/1528/1536 scales increased 
     - highres\sprites\monsters.def: dead bodies animated during pause fixed; 
                                     1880/1975 scale increased;
                                     1960/2000/2710 scale decreased
     - highres\sprites\pickups.def: 29 (zadd value changed to -8)
     - highres\sprites\props.def: wrong skin def for #1026, 1060 (md3 update),
                                  1088/1096 (md3/skin update)
     - highres\sprites\jibs: 1520/1528
     - highres\sprites\switches: 136/137 (texture version)
     - highres\textures: 89 (removed, was identical with 98)

> Revisions:
     - highres\screen\fonts\bluefont: 2822-2915 (pal0/2/7/8/10-23)
     - highres\screen\fonts\digital: 2472-2481
     - highres\screen\fonts\smallfont: 3072-3135, 3162-3165 (pal0/2/8/10-16/21/23)
     - highres\screen\hud: 20, 30, 31, 33, 2462 (statusbar)
     - highres\screen\menu: 2456, 2492 (now with HRP version info), 3281
     - highres\skyboxes: 89 (LA)
     - highres\sprites\characters: 1267 (skin), 1312 (pal0/10-16/21/23, skin),
                                   4874 pal0/12 (WOMAN)
     - highres\sprites\decals: 1155, 1226 (pal2), 1620-1623, 2286-2299, 2301-2305,
                               2307, 2308
     - highres\sprites\effects: 661-663 (pal0)
     - highres\sprites\firstperson: 2375 (skin), 2521 (skin), 2530 (md3), 2573 (md3), 
                                    2554/2556 (Shrinker/Expander), 2613 (skin)
     - highres\sprites\ice: 1313 (skin)
     - highres\sprites\jibs: 2245 (skin), 2250 (skin)
     - highres\sprites\monsters: 675 (skin), 1550 (skin), 1960 (recon car), 
                                 2370 (skin), 4740 (skin)
     - highres\sprites\pickups: 22 (skin), 24 (skin), 25 (Shrinker), 28 (skin), 
                                37 (Freezer ammo), 40 (pistol ammo), 
                                45/46 (Expander/Shrinker ammo), 49 (skin), 
                                53, 54 (skin)
     - highres\sprites\projectiles: 1641-1643, 1650 (new model + glowmap)
     - highres\sprites\props: 489, 563-567, 569 (skin), 658/659, 670, 680 (skin), 
                              688, 694 (skin), 697 (skin), 698, 768 (skin), 
                              779 (skin), 908-910, 927 (skin), 1025 (skin), 
                              1045 (skin), 1062, 1069, 1079, 1232, 1233 (skin), 
                              1240 (skin), 1810, 4396
     - highres\sprites\signs: 518-526, 577 (md3), 586, 593, 597, 598, 613, 614, 
                              639, 668, 777/778, 826, 831, 928, 979 (md3/skin), 
                              986, 1008, 1018, 1046, 1054, 1244, 1246, 2487, 
                              3399, 4329, 4352, 4362, 4395, 4475-4478, 4485, 
                              4486, 4494, 4498, 4894, 4896-4899, 4958
     - highres\sprites\switches: 140/141 (Frankenstine switch), 146 (skin), 
                                 860/861 (skin)
     - highres\textures: 70, 128, 200-202, 216, 221, 264, 312-315, 336-338 (pal0/2/21), 
                         341-343, 350, 357, 365, 366, 371, 373, 379-381, 384, 385, 
                         390 (pal0/15), 395, 396, 407-410, 454, 455, 457, 458, 459, 
                         488, 499, 502, 527-529, 626-629, 717-719, 723-725, 735, 743, 
                         744, 757, 787, 796, 858, 871, 872, 884, 887, 889-892 (pal2/8), 
                         913, 966, 1024, 1082-1087, 1108 (pal0), 1137, 1169, 1185, 
                         1203, 1212-1217, 1280-1288, 3381, 3387, 3405, 4098, 4105, 
                         4112, 4120-4122, 4152, 4170, 4180, 4182-4189, 4191, 4224-4227, 
                         4240-4245, 4250-4253, 4268, 4303, 4310, 4330, 4390-4394 