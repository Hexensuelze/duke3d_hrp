         ==================================================================
         |            DUKE NUKEM 3D HIGH RESOLUTION PACK (HRP)            |
         |                                                                |
         |                   A Duke3D Community project                   |
         |                                                                |                      
         |                compiled by Parkar & NightFright                |
         ==================================================================
         |                 Version 4.2.021 (Nov 29, 2009)                 |
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


--------------
Message boards
--------------
http://forums.duke4.net

The texture and model projects can be found in the Duke Nukem 3D source board:
http://forums.duke4.net/index.php?showforum=26


------------
IRC channels
------------
- 3D Realms IRC Fan Channel ..... #3dr@irc.quakenet.org
- JFDuke3D @ IRC ................ #jfduke@irc.freenode.net


----------------
Visit us online!
----------------
- Duke3D High Resolution Pack ... http://hrp.duke4.net
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
gambini
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
ozz
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
Plagman


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
HRP v4.0 (2009-03-23). Includes any previous Update Packs compiled by NightFright.


HRP v4.2.021 (2009-11-29)
-------------------------
> General: Support for Polymer engine update added (builds 4.2.001-4.2.017)

> Added:
     - Normal maps: 609, 771/772, 1082-1087, 1101/5108, 1104/5095, 1116, 
                    1132-1135, 4240-4245, 5105, 5107, 5119
     - Palettes: 199_12, 207_14/16, 243_17, 332_24, 365/0366_7, 370_7, 387_12/18, 
                 392_17, 399_17, 428_17, 438/0439_17/19, 545_17, 757_24, 803_7, 
                 881_15, 961_14, 1054_24, 3407_7, 4123/4124_7, 4178_13, 4224_13, 
                 4260-4263_17, 4284-4287_17, 4531_23, 4953_12

> Revisions:
     - highres\sprites\firstperson: 2548 (Freezer texture/ozz)
     - highres\sprites\props: 4575
     - highres\sprites\signs: 4953
     - highres\textures: 1169

> Fixes:
    - highres\sprites\pickups: 53 (missing md3)
    - highres\sprites\props.def: 768, 991 (scales corrections)
    - highres\sprites\signs.def: 961 (scales correction)
    - highres\textures.def: old version of 186 restored; entries for missing 
                            313 (d/n/s/g) and 1024 (d/s) removed; entry for 718
                            corrected


HRP v4.1.1 (2009-09-01)
-----------------------
> Added:
     - highres\textures.def: 446 (pal11/12)
     - highres\sprites\props: 920 (chain/highres sprite)

> Fixes:
     - highres\sprites\props: 913

> Revisions:
     - highres\screen\hud: 46 (shrinker crystal HUD icon), 2470 (HoloDuke icon)
     - highres\textures: 913


HRP v4.1 (2009-07-01)
---------------------
> Added:
     - highres\skyboxes: 94
     - highres\sprites\props: 4427 (pal0/14), 4431/4432 (glow),
     - highres\textures: 400, 443, 959, 3407 (pal5/14), 4177, 4202, 4207

> Fixes:
     - highres\screen\menu: 2813-2820 (icon rotation), 3190-3196 (icon texture)
     - highres\sprites\firstperson: 2524 (pistol muzzleflash)
     - highres\sprites\monsters.def: 2000 (pal 1/2/5/7-9)
     - highres\sprites\projectiles: 2448-2451 (pal0/2)

> Revisions:
     - highres\sprites\characters: 1405 (pal0/10-16/21/23, face)
     - highres\sprites\decals: 4445
     - highres\sprites\effects: 2066-2079, 2270-2283, 2310-2323
     - highres\sprites\pickups: 53 (md3)
     - highres\sprites\projectiles: 2448-2451
     - highres\sprites\props: 569, 571, 573 (md3), 595 (texture), 615 (md3), 
                              4410 (skin), 4430-4432, 4458/4459 (skin), 4496, 
                              4497 (skins), 4502/4503, 4557 (skin)
     - highres\sprites\signs: 1044
     - highres\sprites\switches: 712 (skin), 4883
     - highres\textures: 823, 3407 (pal24)