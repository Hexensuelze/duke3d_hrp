; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Duke Nukem 3D HRP"
!define PRODUCT_VERSION "V 4.0 (321)"
!define PRODUCT_WEB_SITE "http://hrp.duke4.net"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\eduke32.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_STARTMENU_REGVAL "NSIS:StartMenuDir"

SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"
!include "Sections.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "icon.ico"
!define MUI_UNICON "uninst.ico"

!define MUI_HEADERIMAGE
!define MUI_WELCOMEFINISHPAGE_BITMAP "page.bmp"
!insertmacro MUI_DEFAULT MUI_HEADERIMAGE_BITMAP "banner.bmp"

; Welcome page
!define MUI_WELCOMEPAGE_TITLE_3LINES
!insertmacro MUI_PAGE_WELCOME

; License page (Build license)
!define MUI_PAGE_HEADER_TEXT "Build Source Code License Agreement (Build engine)"
!define MUI_PAGE_HEADER_SUBTEXT "Please review the license terms of the build source code before installing."
!insertmacro MUI_PAGE_LICENSE "BUILDLIC.TXT"

; License page (GNU public license)
!define MUI_PAGE_HEADER_TEXT "GNU Public License Agreement (EDuke32)"
!define MUI_PAGE_HEADER_SUBTEXT "Please review the license terms of the EDuke32 port before installing."
!insertmacro MUI_PAGE_LICENSE "GNU.TXT"

; License page (HRP art license)
!define MUI_PAGE_HEADER_TEXT "HRP Art License Agreement (High Resolution Content)"
!define MUI_PAGE_HEADER_SUBTEXT "Please review the license terms of the high resolution content port before installing."
!insertmacro MUI_PAGE_LICENSE "hrp_art_license.txt"

; Components page
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Start menu page
var ICONS_GROUP
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "Duke Nukem 3D"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${PRODUCT_STARTMENU_REGVAL}"
!insertmacro MUI_PAGE_STARTMENU Application $ICONS_GROUP
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\eduke32.exe"
!define MUI_FINISHPAGE_RUN_PARAMETERS ""
!define MUI_FINISHPAGE_LINK "Visit the HRP website."
!define MUI_FINISHPAGE_LINK_LOCATION "http://hrp.duke4.net"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\hrp_readme.txt"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "dn3d_hrp-4.0(321).exe"
InstallDir "c:\duke3d"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "EDuke32" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "eduke32\eduke32.exe"
  File "eduke32\mapster32.exe"
  File "eduke32\m32help.hlp"
  File "eduke32\NAMES.H"
  File "eduke32\tiles.cfg"

; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  CreateDirectory "$SMPROGRAMS\$ICONS_GROUP"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Duke Nukem 3D (EDuke32).lnk" "$INSTDIR\eduke32.exe"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Mapster32.lnk" "$INSTDIR\eduke32.exe"
  !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

Section "High resolution content" SEC02
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer

  File "hrp_content\hrp_readme.txt"
  File "hrp_content\hrp_art_license.txt"
  SetOutPath "$INSTDIR\autoload\duke3d.grp"
  File "hrp_content\duke3d_hrp.zip"
SectionEnd

Section "Atomic map hacks" SEC03
  SetOutPath "$INSTDIR\autoload\duke3d.grp"
  SetOverwrite ifnewer

  File "maphacks_atomic\maphacks.zip"
SectionEnd

Section /o "1.3d map hacks" SEC04
  SetOutPath "$INSTDIR\autoload\duke3d.grp"
  SetOverwrite ifnewer

  File "maphacks_13d\maphacks.zip"
SectionEnd

Section "High Quality Muisc" SEC05
  SetOutPath "$instdir\autoload\duke3d.grp"
  SetOverwrite ifnewer

  File "music\eduke32_mus.zip"
SectionEnd

Section "Duke Plus mod" SEC06

   SetOutPath "$INSTDIR"
   SetOverwrite ifnewer

   File "duke_plus\DPEFFECTS.html"
   File "duke_plus\dukeplus.bat"
   File "duke_plus\DukePlus_Manual.html"
   File "duke_plus\mapster.bat"

   SetOutPath "$INSTDIR\DukePlus"

   File "duke_plus\DukePlus\dpmaps.zip"
   File "duke_plus\DukePlus\dukeplus.def"
   File "duke_plus\DukePlus\DUKEPLUS_RESOURCES.zip"
   File "duke_plus\DukePlus\EDUKE.CON"
   File "duke_plus\DukePlus\tiles005.art"
   File "duke_plus\DukePlus\tiles024.art"

   SetOutPath "$INSTDIR\DukePlus\dpcons"

   File "duke_plus\DukePlus\dpcons\DEFSPLUS.CON"
   File "duke_plus\DukePlus\dpcons\DUKEPLUS.CON"
   File "duke_plus\DukePlus\dpcons\HUDPLUS.CON"
   File "duke_plus\DukePlus\dpcons\LIGHTS.CON"
   File "duke_plus\DukePlus\dpcons\PLAYERPLUS.CON"
   File "duke_plus\DukePlus\dpcons\USERPLUS.CON"

; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  CreateDirectory "$SMPROGRAMS\$ICONS_GROUP"
  SetOutPath "$INSTDIR"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Duke Plus.lnk" "$INSTDIR\dukeplus.bat"
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section "-grpinstaller"
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer

  File "datainst.exe"

  IfFileExists "$INSTDIR\duke3d.grp" SkipGrpIn
     MessageBox MB_YESNO "Do you want to run the GRP installer to find your duke3d.grp file and copy it to your HRP folder?" IDNO SkipGrpIn
     DetailPrint "Running grp installer..."
     exec "$INSTDIR\datainst.exe"
  SkipGrpIn:

SectionEnd


Function .onSelChange
  !insertmacro StartRadioButtons $1
    !insertmacro RadioButton ${SEC03}
    !insertmacro RadioButton ${SEC04}
  !insertmacro EndRadioButtons
FunctionEnd

Function .onInit

  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${PRODUCT_NAME} ${PRODUCT_VERSION}") i .r1 ?e'
  Pop $R0
  StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION "The installer is already running."
    Abort

  SetOutPath $TEMP
  File /oname=spltmp.bmp "hrp_splash.bmp"
  advsplash::show 1500 600 250 -1 $TEMP\spltmp
  Pop $0
  Delete $TEMP\spltmp.bmp

  StrCpy $1 ${SEC04} ; Group 1 - Option 1 is selected by default

FunctionEnd

Section -AdditionalIcons
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\HRP Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk" "$INSTDIR\uninst.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\eduke32.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "Path" "$INSTDIR"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} "The eDuke32 port that is needed to use the high resolution content. Only uncheck this if you want to install it manualy or if you already have it installed."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} "The high resoltution textures and models."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03} "Map hacks for atomic and plutonium pack version of the game. fixes model related problems caused by original level design not being designed for 3D models."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC04} "Map hacks for 1.3d full or shareware version of the game. fixes model related problems caused by original level design not being designed for 3D models."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC05} "A pack of high quality replacements for the games music."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC06} "A game enhancement mod with bug fixes and (mostly optional) new features."
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  !insertmacro MUI_STARTMENU_GETFOLDER "Application" $ICONS_GROUP
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
;eduke32 files
  Delete "$INSTDIR\eduke32.exe"
  Delete "$INSTDIR\mapster32.exe"
  Delete "$INSTDIR\m32help.hlp"
  Delete "$INSTDIR\NAMES.H"
  Delete "$INSTDIR\tiles.cfg"

;hrp content
  Delete "$INSTDIR\hrp_readme.txt"
  Delete "$INSTDIR\hrp_art_license.txt"
  Delete "$INSTDIR\autoload\duke3d.grp\duke3d_hrp.zip"
  Delete "$INSTDIR\autoload\duke3d.grp\maphacks.zip"

;music content
  Delete "$INSTDIR\autoload\duke3d.grp\eduke32_mus.zip"

;duke plus
   Delete "$INSTDIR\DPEFFECTS.html"
   Delete "$INSTDIR\dukeplus.bat"
   Delete "$INSTDIR\DukePlus_Manual.html"
   Delete "$INSTDIR\mapster.bat"

   Delete "$INSTDIR\DukePlus\dpmaps.zip"
   Delete "$INSTDIR\DukePlus\dukeplus.def"
   Delete "$INSTDIR\DukePlus\DUKEPLUS_RESOURCES.zip"
   Delete "$INSTDIR\DukePlus\EDUKE.CON"
   Delete "$INSTDIR\DukePlus\tiles005.art"
   Delete "$INSTDIR\DukePlus\tiles024.art"

   Delete "$INSTDIR\DukePlus\dpcons\DEFSPLUS.CON"
   Delete "$INSTDIR\DukePlus\dpcons\DUKEPLUS.CON"
   Delete "$INSTDIR\DukePlus\dpcons\HUDPLUS.CON"
   Delete "$INSTDIR\DukePlus\dpcons\LIGHTS.CON"
   Delete "$INSTDIR\DukePlus\dpcons\PLAYERPLUS.CON"
   Delete "$INSTDIR\DukePlus\dpcons\USERPLUS.CON"

   Delete "$INSTDIR\DukePlus\*.log"

   IfFileExists "$INSTDIR\DukePlus\*.cfg" 0 SkipDnPlusCfg
   MessageBox MB_YESNO "Do you want to remove Duke Plus configuration files? These files contain the configuration of the Duke Plus mod." IDNO SkipDnPlusCfg
     Delete "$INSTDIR\DukePlus\*.cfg"
   SkipDnPlusCfg:

   IfFileExists "$INSTDIR\DukePlus\*.sav" 0 SkipDnPlusSav
   MessageBox MB_YESNO "Do you want to remove your saved Duke Plus games?" IDNO SkipDnPlusSav
     Delete "$INSTDIR\DukePlus\*.sav"
   SkipDnPlusSav:

   IfFileExists "$INSTDIR\DukePlus\*.dmo" 0 SkipDnPlusDmo
   MessageBox MB_YESNO "Do you want to remove your Duke Plus demo recordings?" IDNO SkipDnPlusDmo
     Delete "$INSTDIR\DukePlus\*.dmo"
   SkipDnPlusDmo:


;datainst
  Delete "$INSTDIR\datainst.exe"

;cahce files
  Delete "$INSTDIR\textures"
  Delete "$INSTDIR\*.cache"
  Delete "$INSTDIR\DukePlus\textures"
  Delete "$INSTDIR\DukePlus\*.cache"

; shortcuts
  Delete "$SMPROGRAMS\$ICONS_GROUP\Uninstall"
  Delete "$SMPROGRAMS\$ICONS_GROUP\HRP Website"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Duke Nukem 3D (EDuke32)"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Mapster32"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Duke Plus"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Setup video audio and controls"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\HRP Website.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Duke Nuke.lnkm 3D (EDuke32).lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Mapster32"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Duke Plus.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Setup video audio and controls.lnk"

;logfiles
  Delete "$INSTDIR\*.log"

;folders
  SetOutPath $TEMP
  RMDir "$SMPROGRAMS\$ICONS_GROUP"
  RMDir "$INSTDIR\autoload\duke3d.grp"
  RMDir "$INSTDIR\autoload"
  RMDir "$INSTDIR\texcache"
  RMDir "$INSTDIR\DukePlus\dpcons"
  RMDir "$INSTDIR\DukePlus"
  RMDir "$INSTDIR"

  IfFileExists "$INSTDIR\duke3d.grp" 0 SkipGrpUn
  MessageBox MB_YESNO "Do you want to remove $INSTDIR\duke3d.grp? This file contains the original Duke Nukem 3D art, maps, sounds etc." IDNO SkipGrpUn
    Delete "$INSTDIR\duke3d.grp"
  SkipGrpUn:
  
  IfFileExists "$INSTDIR\*.cfg" 0 SkipCfgUn
  MessageBox MB_YESNO "Do you want to remove eDuke32 configuration files? These files contain the configuration of eDuke32 and Mapster32." IDNO SkipCfgUn
    Delete "$INSTDIR\duke3d.cfg"
  SkipCfgUn:

  IfFileExists "$INSTDIR\*.sav" 0 SkipSavUn
  MessageBox MB_YESNO "Do you want to remove your saved games?" IDNO SkipSavUn
    Delete "$INSTDIR\*.sav"
  SkipSavUn:

  IfFileExists "$INSTDIR\*.dmo" 0 SkipDmoUn
  MessageBox MB_YESNO "Do you want to remove your demo recordings?" IDNO SkipDmoUn
    Delete "$INSTDIR\*.dmo"
  SkipDmoUn:
  
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd