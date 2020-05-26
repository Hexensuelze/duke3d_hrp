       ==================================================================
       |                                                                |
       |            DUKE NUKEM 3D HIGH RESOLUTION PACK (HRP)            |
       |                                                                |
       |                   A Duke3D Community Project                   |
       |                                                                |
       ==================================================================
       |           Repository Snapshot >= 5.4.675 (2015-06-22)          |
       ==================================================================


=======================
CONTENTS OF THIS README
=======================

1) About
2) Installation
3) Notes
   3.1) WIP Release
   3.2) Highlights of this Release
   3.3) Known Issues
   3.4) Title Screen Art
   3.5) EDuke32 Port
4) License
   4.1) HRP
   4.2) Others
5) Contact/Links
6) Credits



========
1) ABOUT
========

Remember "Duke Nukem 3D", the great first-person shooter 3D Realms released 
back in 1996? Its cool protagonist, ingame atmosphere, original weaponry and 
many other features make it worth playing even today.

For all Duke fans who want to play the game again in a modern Windows / Linux 
environment with 3D accelerated graphics, the Duke3D community has created the 
High Resolution Pack (HRP). Utilizing the amazing skills of various texturing 
and modelling artists, the project's goal is to replace all textures and 
sprites with high-res versions, optimizing it for latest OpenGL ports.

All you need is the "duke3d.grp" file from your original Duke3D v1.3d or 
Atomic (v1.5) CD-ROM. You can also play with the shareware version available 
over at http://www.3drealms.com/downloads.html . 

What the Duke Nukem 3D HRP has to offer: 
   - EDuke32 port for Duke Nukem 3D (by TerminX and Plagman, based on JFDuke3D
     by Jonathon "JonoF" Fowler). Supports older Polymost renderer as well as
     the more advanced Polymer renderer (with advanced effects like
     normal/specular mapping, per-pixel dynamic lighting, real-time shadows,etc)
     For more info about these ports, check out JonoF's JFDuke3D and the
     EDuke32 site. 
   - 32-bit high resolution textures with 4-8 times the detail of the original
     textures. 
   - Models instead of the old sprites. 

While the HRP is still "work in progress" and missing quite a few textures and 
models, you can check the Duke4.net forums at http://forums.duke4.net for 
additional content or even better contributing something of your own.

The community's goal is to issue a new HRP version once in 1-2 year(s).



===============
2) INSTALLATION
===============

Installing is easy:

First make sure you have your Duke3D CD in your CD/DVD drive or an existing 
installation of the game. You can also just have the "duke3d.grp" file 
somewhere on your system.

Then run the self-extracting archive (the file you downloaded/got from a friend 
or whatever) by double-clicking it. Then just choose any hard drive/subdir of 
your personal preference.

After the extraction process is complete, you may copy over any existing 
"duke3d.grp" file you already have (either directly from the installation disc 
or from the folder which contains your digital copy). Be sure to overwrite the 
existing "duke3d.grp" since this one only contains the shareware episode.
After you are done, start the game by clicking "eduke32.exe" in the Duke3D
folder. 
You can also create a shortcut by right-clicking the file and choose 
"Send to" --> "Desktop (Create shortcut)".

IMPORTANT: 
In order to see the high resolution textures and models, you have to change the 
render mode to 32-bit Polymer in the "Video Settings" under "Options" in the 
game menu. 
Otherwise, HRP content will not work (properly)!

POLYMOST COMPATIBILITY OPTION:
For players who are unable to use the advanced Polymer renderer (e.g. because 
they experience graphics issues or their graphics card simply can't handle it), 
please do the following:

   Step 1A (preferred method):
   Get the Polymost HRP Override Pack by LeoD and place it into the same 
   directory as the HRP zipfile (usually \autoload within your EDuke32 folder).
   LeoD's Polymost HRP thread: http://forums.duke4.net/index.php?showtopic=3513

   Step 1B (alternate method):
   Create a shortcut to eduke32.exe (if you have not done so already). 
   To do it, right-click on eduke32.exe in your Duke3D directory, choose 
   "Send to" and "Desktop (Create shortcut)".
   Edit the shortcut by right-clicking it on the desktop; choose "Properties". 
   The "Shortcut" tab will be opened directly.
   Add the parameter -hduke3d_hrp_polymost.def to the "Target" command line. 
   Click "Apply" to confirm your changes.

   Step 2:
   When launching EDuke32 via the shortcut, a launcher will pop up. There, be 
   sure to deactivate (i.e. untick) the Polymer renderer option. You should now 
   be ready to enjoy the HRP with Polymost!

If you want to see some screenshots illustrating this procedure, check out the
FAQ section of the HRP website: http://hrp.duke4.net/faq.php



========
3) NOTES
========

----------------
3.1) WIP Release
---------------- 
Since this is a work in progress version of the pack which has not been tested 
extensively, there are probably some issues that need fixing. Please let us 
know of any problems with it so they can be sorted out in future versions. Also 
notify us if we are missing any art that's been released prior to the pack's 
release date, even though we have skipped some stuff since we simply did not 
like it, there is maybe some stuff that has been missed to include.

Please also be aware of the fact that we are still missing models and textures 
because these have not been remade yet by the community. They will probably 
be featured in upcoming releases of the HRP (or updates).

For a full summary of what's left to do, you may have a look at the 
hrp_todo.txt file.


-------------------------------
3.2) Highlights of this Release
-------------------------------
Compared to its previous release, HRP v5.4 features changes as follows:

[FEATURE] Luke Skywalker model (1354) and 3 new highres textures(280, 323, 2452)
[FEATURE] DEF files for basic Megaton Edition "support"
[UPDATE]  Maphacks for 800+ custom maps (1700 map files recognized by checksum)
[UPDATE]  Tweak for some textures: 395, 966, 5099-5104
[UPDATE]  Polymer versions of 44 existing textures/sprites/models added
          or revised:                         134, 150, 196, 197, 242, 294-296, 
          310, 348, 389, 441, 446, 451-453, 584, 609, 660, 705, 706, 718, 791, 
          795, 802, 876, 915, 976, 1174, 1175, 1186, 1191, 3386, 3394-3396, 
          4201, 4202, 4282, 4283, 4285-4287, 4308
[UPDATE]  12 models updated: 
          Shotgun pickup (28), Camera (621), hydrant (950/981), switch (1155), 
          pole (1221), crane (1222), nuke barrel (1227), newspaper (1275), 
          cable (4386), robotdog2 (4560), pipe (4583)
[UPDATE]  Mighty Boot model improved
[UPDATE]  Polymost optimizations for some textures and models
[FIX]     Minor adjustments for glowmaps and texture/model scales


IMPORTANT!
----------
Please note that all HRP v5.x contents have been optimized for usage with the 
Polymer renderer. This means that if you use the older Polymost renderer, 
you WILL encounter problems (HUD weapons rendered incorrectly, or other display 
glitches). Polymer requirements offer advanced graphics effects but demand much 
better hardware.
If you are forced to use Polymost due to having a weaker machine, be sure to
launch the HRP in Polymost mode (see "Installation" section for more info)! 



-----------------
3.3) Known issues
----------------- 
Although we've tried hard to eliminate or avoid any glitches, unfortunately 
some of them could not be removed in this release. Here are those we know of:

- Current EDuke32 problems (might get fixed in future versions):
     > The startup screens are not optimized for widescreen resolutions and
       might show black stripes on both sides and possibly some distortions,
       depending on your display.

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
3.4) Title Screen Art
---------------------
The front screen is a slightly modified and enhanced version of 3D Realms'
original art work used with permission.


-----------------
3.5) EDuke32 Port
-----------------
The EDuke32 port is an enhanced version of JonoF's initial JFDuke3D port and
features enhanced mod support together with tons of newly-added code. It is 
released and maintained by TerminX.

We are using EDuke32 for running the HRP due to frequent updates of this port.
It also offers advanced features for which HRP content has been optimized.

Two releases are provided with the full SFX release:
   > eduke32_win32_<version>.zip - 32-bit version (32-bit, default)
   > eduke32_win64_<version>.zip - 64-bit version (64-bit)

If you are working with a 64-bit system, it is recommended that you extract
eduke32.exe from the win64 archive and overwrite the default executable.

You will also find the latest release of the (optional) Mapster32 editor 
in those zipfiles, also available as 32-bit and 64-bit versions.



===========
4) LICENSES
===========

--------
4.1) HRP 
--------

The contents of the High Resolution Pack are licensed under these three
licenses:

- The build engine is licensed under Ken Silverman's Build License which can be
  found in "BUILDLIC.TXT".
- The EDuke32 port is licensed under the GNU Public license which can be found
  in "GNU.TXT".
- The art content is licensed under the High Resolution Pack Art License which
  can be found in "hrp_art_license.txt".


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
- highres\textures:      1120



================
5) CONTACT/LINKS
================

Robin "NightFright" Reisinger
(HRP author) .................................... nightfright2k7 [at] gmail.com

Richard "TerminX" Gobeille
(EDuke32 port author) ........................... terminx [at] gmail.com


--------------
Message Boards
--------------
http://forums.duke4.net

The texture and model projects can be found in the Duke Nukem 3D source board:
http://forums.duke4.net/index.php?showtopic=779


------------
IRC Channels
------------
- 3D Realms IRC Fan Channel ..... #3dr@irc.quakenet.org
- JFDuke3D @ IRC ................ #jfduke@irc.freenode.net


----------------
Visit Us Online!
----------------
- Duke3D High Resolution Pack ... http://hrp.duke4.net
- EDuke32 port (by TerminX) ..... http://eduke32.com
- Duke4.net ..................... http://www.duke4.net



==========
6) CREDITS
==========

All the following people are involved in this release. They all have our 
gratitude, for nothing of the great artwork (or pretty much anything else) 
would have been possible to include without their support and effort. 
Please notify us if you did contribute to this project without being listed 
here!

-------------
JFDuke3D Port
-------------
JonoF
Ken Silverman


------------
EDuke32 Port
------------
Helixhorned
Hendricks266
Plagman
TerminX


----------------
Highres Textures
----------------
0815Jack
ADM
Alexander Filippov
AlgorithMan
Besli
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
L.D. Simone
L2theKING
Lemming
Lightsource
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
Roma Loom
Quakis
Semicharm
Sky Fox
Steveeeie
SwissCM
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
Jean Gorospe
Jokke_r
Killd a ton
Kralex
L2theKING
Madaut
MagNet
Mark Skelton
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
Steveeeie
Supertanker
SwissCM
Tea Monster
vakooja
Vasilinka
YicklePigeon
zilppuri


--------
Highpals
--------
Lezing/CraigFatman


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

> User Map Maphacks
LeoD

> Polymer Lighting
Devastator
Micky C
Roma Loom


---------------
SVN Maintenance
---------------
Devastator
Hendricks266
LeoD
NightFright
Roma Loom
Spiker


------------
HRP Assembly
------------
NightFright



-----------------
Special Thanks to
-----------------
- 3D Realms, for making this great game in the first place!
- The guys at Duke4.net for hosting and help building the HRP website!
- All of you who support and contribute to the project!
- All the mirrors and seeders!
