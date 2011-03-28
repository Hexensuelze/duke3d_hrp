         ==================================================================
         |            DUKE NUKEM 3D HIGH RESOLUTION PACK (HRP)            |
         |                                                                |
         |                   A Duke3D Community Project                   |
         |                                                                |                      
         |                Compiled by Parkar & NightFright                |
         ==================================================================
         |                 Version 4.2.235 (Mar 28, 2011)                 |
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
     Jonathon "JonoF" Fowler). Supports older Polymost renderer as well as the more
     advanced Polymer renderer (with advanced effects like normal/specular mapping,
     per-pixel dynamic lighting, real-time shadows etc). 
     For more info about these ports, check out JonoF's JFDuke3D and the EDuke32 site. 
   - 32-bit high resolution textures with 4-8 times the detail of the original textures. 
   - Models instead of the old sprites. 

While the HRP is still "work in progress" and missing quite a few textures and 
models, you can check the Duke Nukem 3D source code forums for additional content 
or even better contributing something of your own.

The community's goal is to issue a new HRP version once in 1-2 year(s).



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
  Maphacks can fix these glitches, so don't hesitate to report anything you 
  consider worthy of correcting.

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
(HRP co-author) .................................... hrp_update [at] fastmail.fm


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
JFDuke3D Port
-------------
JonoF
Ken Silverman


------------
EDuke32 Port
------------
Plagman
TerminX


----------------
Highres Textures
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
Cage
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
Flacken.WS
Gambini
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
Marked
Megadeus
motionblur
NightFright
Night Hacker 
nyne
ooppee
ozz
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
3D Models and Skins
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
empyrock
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
Millenia
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
Spiker
Swiss Cheeseman/SwissCM
Tea Monster
vakooja
Vasilinka
YicklePigeon
zilppuri


--------
Maphacks
--------

> Initial Release
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

> "Reloaded" Release
Hunter_rus
NightFright

> Polymer Lighting
Devastator
Micky C
Roma Loom


------------
HRP Assembly
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