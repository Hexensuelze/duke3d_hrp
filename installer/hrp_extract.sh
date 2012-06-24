#!/bin/sh

# Duke Nukem 3D High Resolution Pack Extractor  v0.3  2012-03-24
#
# Author: LeoD
# License: ISC license : http://opensource.org/licenses/isc-license.txt
#
# This script extracts a PolyMER or PolyMOST only HRP from your working copy
# of the Duke Nukem 3D High Resolution Pack's Subversion repository.
# On Windows you might want MSYS' zip to create package files.
# ("mingw-get install msys-zip")
# MinGW/MSYS performance is horrible, better go Linux. Even my virtual Debian
# machine accessing the Windows drive is 5 to 10 times faster.
# But it still sucks. This needs to become a Perl script one day.
# Or maybe MSYS' bash gets finally updated to 4.* and I'll use its regex engine.

DEF_TOP=UNDEFINED
SET_VERSION=YES            # [YES|NO]
EXTRACT_COMMENTED_FILES=NO # [YES|NO]
DUKEPLUS_POLYMOST_COMPATIBILTY_APPROACH=none # [none|polymost|polymer|mixed]

ask()
{
  echo -n "$@" '[y/N] ' ; read ans
  case "$ans" in
    y*|Y*) return 0 ;;
    *)     return 1 ;;
  esac
} # ask


copy_folders()
{
  mkdir ${EXTRACTDIR}
  for HRPDIR in . ; do
    if [ -d "${HRPDIR}" ] ; then
      DIRLIST=./HRP_DIRECTORIES.lst
      find "${HRPDIR}" -type d > ${DIRLIST}
      cat ${DIRLIST} | while read DIR; do
        if [ ! -d "${EXTRACTDIR}/${DIR}" ] ; then
          mkdir "${EXTRACTDIR}/${DIR}"
        fi
      done
      rm     ${DIRLIST}
    else
      echo "${HRPDIR} : no HRP."
    fi
  done
} # copy_folders()


copy_set_version()
{
  VER_FILE="$1"
  TARGET_FILE="$2"
  V_DATE=`date +%F`
  if [ "${VERSION}" = "" ] ; then
    if [ -f VERSION ] ; then
      VERSION=`grep -owE "[0-9\\.]*" VERSION`
    fi
  fi

  echo "copy_set_version ${VER_FILE} -> ${TARGET_FILE}"

  case "${VER_FILE}" in
    hrp_readme.txt)
      cat "${VER_FILE}" | sed -r --posix \
        s/\(Version\ *\)\([0-9\.]*\)\(.*\)\(\\\)\)\(.*\)/\\1${VERSION}\ \(${V_DATE}\)\ \ \\5/ \
        >> "${TARGET_FILE}"
      ;;
    duke3d_hrp.def)
      if [ "${HRPTYPE}" = "polymer" ] ; then
        cat "${VER_FILE}" | sed -r --posix \
          s/\(Version\ *\)\([0-9\.]*\)\(.*\)/\\1${VERSION}\ Polymer\\3/ \
          >> "${TARGET_FILE}"
      else
        cat "${VER_FILE}" | sed -r --posix \
          s/\(Version\ *\)\([0-9\.]*\)\(.*\)/\\1${VERSION}\\3/ \
          >> "${TARGET_FILE}"
      fi
      ;;
    duke3d_hrp_polymost.def)
      if [ "${HRPTYPE}" = "polymost_override" ] ; then
        cat "${VER_FILE}" | sed -r --posix \
          s/\(Version\ *\)\([0-9\.]*\)\(\ Polymost\)/\\1${VERSION}\ Polymost\ Override/ \
          >> "${TARGET_FILE}"
      else
        cat "${VER_FILE}" | sed -r --posix \
          s/\(Version\ *\)\([0-9\.]*\)\(.*\)/\\1${VERSION}\\3/ \
          >> "${TARGET_FILE}"
      fi
      ;;
    *)
      echo "###ERROR: copy_set_version() - BAD FILE: ${VER_FILE}"
      exit 1
      ;;
  esac
}

tar_copy_dir()
{
  (cd ${1}; tar cf - . ) | (cd ${2}; tar xf -)
}

copy_known_files()
{
  if [ "${SET_VERSION}" = "YES" ] ; then
    copy_set_version hrp_readme.txt "${EXTRACTDIR}/hrp_readme.txt"
  else
    cp -pv hrp_readme.txt           "${EXTRACTDIR}"
  fi
  cp -pv hrp_art_license.txt        "${EXTRACTDIR}"

  if [ "${HRPTYPE}" = "polymost" ] || [ "${HRPTYPE}" = "polymost_override" ] ; then
    if [ "${SET_VERSION}" = "YES" ] ; then
      copy_set_version duke3d_hrp_polymost.def "${EXTRACTDIR}/duke3d_hrp.def"
    else
      cp -pv           duke3d_hrp_polymost.def "${EXTRACTDIR}/duke3d_hrp.def"
    fi
  fi

  if [ "${HRPTYPE}" = "polymost" ] ; then
    cp -pv duke3d.def "${EXTRACTDIR}"
    #cp -pv duke3d_hrp_polymost.def               "${EXTRACTDIR}"
    #cp -pv highres/screen/menu/2492_polymost.png "${EXTRACTDIR}/highres/screen/menu"
  fi

  if [ "${HRPTYPE}" = "full" ] ; then
    if [ "${SET_VERSION}" = "YES" ] ; then
      copy_set_version duke3d_hrp_polymost.def "${EXTRACTDIR}/duke3d_hrp_polymost.def"
    else
      cp -pv           duke3d_hrp_polymost.def "${EXTRACTDIR}"
    fi
  fi

  if [ "${HRPTYPE}" = "polymost_override" ] || [ "${HRPTYPE}" = "full" ] ; then
    cp -pv highres/screen/menu/2492_ver_polymost.png "${EXTRACTDIR}/highres/screen/menu"
  fi

  if [ "${HRPTYPE}" = "polymer" ] || [ "${HRPTYPE}" = "full" ] ; then
    cp -pv duke3d.def                   "${EXTRACTDIR}"
    if [ "${SET_VERSION}" = "YES" ] ; then
      copy_set_version duke3d_hrp.def "${EXTRACTDIR}/duke3d_hrp.def"
    else
      cp -pv           duke3d_hrp.def "${EXTRACTDIR}"
    fi
    echo                  "\`*.mhk' -> \`${EXTRACTDIR}/*.mhk'"
    cp -p  *.mhk                        "${EXTRACTDIR}"
    #cp -pv highres/screen/menu/2492.png "${EXTRACTDIR}/highres/screen/menu"

    #cp -pv highres/common/black.png                          "${EXTRACTDIR}/highres/common"
    #cp -pv highres/screen/fonts/digital/digital_minus.png    "${EXTRACTDIR}/highres/screen/fonts/digital"
    #cp -pv highres/screen/menu/2493_old.png                  "${EXTRACTDIR}/highres/screen/menu"
    #cp -pv highres/screen/menu/widescreen/*_wide.png         "${EXTRACTDIR}/highres/screen/menu"
    #cp -pv highres/sprites/characters/1357_terminarm.md3     "${EXTRACTDIR}/highres/sprites/characters"
    #cp -pv highres/sprites/firstperson/2510_devastator_n.png "${EXTRACTDIR}/highres/sprites/firstperson"
    #cp -pv highres/sprites/monsters/1960_reconcar_s.png      "${EXTRACTDIR}/highres/sprites/monsters"
    #cp -pv highres/sprites/props/4387.png                    "${EXTRACTDIR}/highres/sprites/props"
    #cp -pv highres/sprites/signs/4378.png                    "${EXTRACTDIR}/highres/sprites/signs"
    #cp -pv highres/sprites/signs/4379.png                    "${EXTRACTDIR}/highres/sprites/signs"
    #cp -pv highres/sprites/signs/4381-85.png                 "${EXTRACTDIR}/highres/sprites/signs"
  fi

  if [ "${HRPTYPE}" = "voxel" ] ; then
    cp -pv readme.txt             "${EXTRACTDIR}"
    cp -pv voxelp_art_license.txt "${EXTRACTDIR}"
    cp -pv duke3d.def             "${EXTRACTDIR}"
    cp -pv duke3d_voxel.def       "${EXTRACTDIR}"
    echo            "\`*.mhk' -> \`${EXTRACTDIR}/*.mhk'"
    cp -p  *.mhk                  "${EXTRACTDIR}"
  fi

  if [ "${HRPTYPE}" = "sw_highres" ] ; then
    cp -pv sw.def                   "${EXTRACTDIR}"
    cp -pv highres/sw_hrp.def       "${EXTRACTDIR}/highres"
    cp -pv HRP.bat                  "${EXTRACTDIR}"
    cp -pv HRP_Readme.txt           "${EXTRACTDIR}"
    cp -pv HRP_Changes.txt          "${EXTRACTDIR}"
    echo "Copying skyboxes ..."
    tar_copy_dir "highres/skyboxes" "${EXTRACTDIR}/highres/skyboxes"
    cd "${WORKDIR}"
  fi

  if [ "${HRPTYPE}" = "sw_lowres" ] ; then
    cp -pv lowres/sw_lrp.def        "${EXTRACTDIR}/lowres"
    cp -pv LRP.bat                  "${EXTRACTDIR}"
    cp -pv LRP_Readme.txt           "${EXTRACTDIR}"
    cp -pv LRP_Changes.txt          "${EXTRACTDIR}"
    echo "Copying skyboxes ..."
    tar_copy_dir "highres/skyboxes" "${EXTRACTDIR}/highres/skyboxes"
    cd "${WORKDIR}"
  fi

  if [ "${HRPTYPE}" = "default" ] ; then
    cp -pv  "${DEF_TOP}"          "${EXTRACTDIR}/${DEF_TOP}"
    echo            "\`*.txt' -> \`${EXTRACTDIR}/*.txt'"
    cp -p  *.txt                  "${EXTRACTDIR}"
  fi

} # copy_known_files()


polymost_mhk_patch()
{
  MHKFILE="$1"
  MHK_LINE="$2"

  case "${MHKFILE}" in
    "E3L1.mhk")
      echo "${MHK_LINE}" >> "${EXTRACTDIR}/${MHKFILE}"
      MHK_INSERT=`echo "${MHK_LINE}" | grep -oE "sprite\ 575\ pitch\ 1"`
      if [ ! "${MHK_INSERT}" = "" ] ; then
        echo "sprite 591 mdxoff 425000 // underwater slimebabe (Polymost HRP)\r" \
             >> "${EXTRACTDIR}/${MHKFILE}"
        echo "sprite 591 pitch 1\r" >> "${EXTRACTDIR}/${MHKFILE}"
        echo "sprite 592 mdxoff 425000 // underwater slimebabe (Polymost HRP)\r" \
             >> "${EXTRACTDIR}/${MHKFILE}"
        echo "sprite 592 pitch 1\r" >> "${EXTRACTDIR}/${MHKFILE}"
        echo "sprite 593 mdxoff 425000 // underwater slimebabe (Polymost HRP)\r" \
             >> "${EXTRACTDIR}/${MHKFILE}"
        echo "sprite 593 pitch 1\r" >> "${EXTRACTDIR}/${MHKFILE}"
      fi
      ;;
    "E3L3.mhk")
      MHK_REPLACE=`echo "${MHK_LINE}" | grep -oE "sprite\ 105\ angoff -128"`
      if [ ! "${MHK_REPLACE}" = "" ] ; then
        echo "sprite 105 angoff 768 // (Polymost HRP)\r" >> "${EXTRACTDIR}/${MHKFILE}"
      else
        echo "${MHK_LINE}" >> "${EXTRACTDIR}/${MHKFILE}"
        MHK_INSERT=`echo "${MHK_LINE}" | grep -oE "sprite\ 96\ pitch\ 1"`
        if [ ! "${MHK_INSERT}" = "" ] ; then
          echo "sprite 105 mdxoff 450000 // underwater slime babe (Polymost HRP)\r" \
                                      >> "${EXTRACTDIR}/${MHKFILE}"
          echo "sprite 105 pitch 1\r" >> "${EXTRACTDIR}/${MHKFILE}"
          echo "sprite 447 mdxoff 462000 // underwater slime babe (Polymost HRP)\r" \
                                      >> "${EXTRACTDIR}/${MHKFILE}"
          echo "sprite 447 pitch 1\r" >> "${EXTRACTDIR}/${MHKFILE}"
        fi
      fi
      ;;
    "E3L6.mhk")
      MHK_REPLACE1=`echo "${MHK_LINE}" | grep -oE "sprite\ 307\ angoff -210"`
      MHK_REPLACE2=`echo "${MHK_LINE}" | grep -oE "sprite\ 307\ mdxoff -125000 \\/\\/\ flipped hanging babe"`
      MHK_REPLACE3=`echo "${MHK_LINE}" | grep -oE "sprite\ 307\ mdzoff -11000"`
      if   [ ! "${MHK_REPLACE1}" = "" ] ; then
        echo "sprite 307 angoff 200 // (Polymost HRP)\r" >> "${EXTRACTDIR}/${MHKFILE}"
      elif [ ! "${MHK_REPLACE2}" = "" ] ; then
        echo "sprite 307 mdxoff 750000 // flipped hanging babe (Polymost HRP)\r" \
             >> "${EXTRACTDIR}/${MHKFILE}"
      elif [ ! "${MHK_REPLACE3}" = "" ] ; then
        echo "sprite 307 mdzoff 625000 // flipped hanging babe (Polymost HRP)\r" \
             >> "${EXTRACTDIR}/${MHKFILE}"
      else
        echo "${MHK_LINE}" >> "${EXTRACTDIR}/${MHKFILE}"
      fi
      ;;
    *)
      echo "${MHK_LINE}" >> "${EXTRACTDIR}/${MHKFILE}"
      ;;
  esac
} # polymost_mhk_patch()


create_polymost_mhk()
{
  for MHKFILE in *.mhk ; do
    MHKSTOP="0"
    cat   ${MHKFILE} | while read MHK_LINE; do
      if [ "${MHKSTOP}" = "0" ] ; then

        if [ "${MHKFILE}" = "E3L1.mhk" ] || [ "${MHKFILE}" = "E3L3.mhk" ] || \
           [ "${MHKFILE}" = "E3L6.mhk" ] ; then
          polymost_mhk_patch ${MHKFILE} "${MHK_LINE}"
        else
          echo "${MHK_LINE}" >> "${EXTRACTDIR}/${MHKFILE}"
        fi

        MHK_TERM=`echo "${MHK_LINE}" | grep -owE "\\/\\/\\ LIGHTS"`
        if [ "${MHK_TERM}" = "// LIGHTS" ] ; then
          MHKSTOP="1"
        fi
      fi
    done
  done
  # Some people prefer unusual setups ...
  zip -rq9 ${EXTRACTDIR}/polymost_hrp_update_polymer_maphacks.zip *.mhk
} # create_polymost_mhk()


# I really don't know yet if this will become necessary, or if it doesn't make
# sense at all, but at least the files involved are listed.
dukeplus_polymost_compatibility()
{
  # dukeplus.def expects some files to be present in the HRP
  #
  # model "highres/sprites/characters/1405_duke.md3" { // all OK, no action required
  #    skin { pal 0 surface 0 file "highres/sprites/pickups/0057_jetpack.png" }
  #    skin { pal 0 surface 1 file "highres/sprites/characters/1405_duke.png" }
  #    skin { pal 10 surface 1 file "highres/sprites/characters/1405_duke_10.png" }
  #    skin { pal 11 surface 1 file "highres/sprites/characters/1405_duke_11.png" }
  #    skin { pal 12 surface 1 file "highres/sprites/characters/1405_duke_12.png" }
  #    skin { pal 13 surface 1 file "highres/sprites/characters/1405_duke_13.png" }
  #    skin { pal 14 surface 1 file "highres/sprites/characters/1405_duke_14.png" }
  #    skin { pal 15 surface 1 file "highres/sprites/characters/1405_duke_15.png" }
  #    skin { pal 16 surface 1 file "highres/sprites/characters/1405_duke_16.png" }
  #    skin { pal 21 surface 1 file "highres/sprites/characters/1405_duke_21.png" }
  #    skin { pal 23 surface 1 file "highres/sprites/characters/1405_duke_23.png" }
  #    skin { pal 0 surface 2 file "highres/sprites/pickups/0023_rpg.png" }
  #
  # model "highres/sprites/firstperson/2510_devastator.md3" { // since Imperium, not Eternity
  #    skin { pal 0 file "highres/sprites/firstperson/2510_devastator.png" specfactor 0.5 specpower 35 }
  #    specular { file "highres/sprites/firstperson/2510_devastator_s.png" }
  #    glow { file "highres/sprites/firstperson/2510_devastator_g.png" }
  #
  # model "highres/sprites/firstperson/2524_pistol.md3" {    // most/mer : same MD3 + same skin til r295     
  #    skin { pal 0 file "highres/sprites/firstperson/2524_pistol.png" } // up to DP2.30 DNE/IMP only
  #    glow { file "highres/sprites/firstperson/2524_pistol_g.png" }     // up to DP2.30 DNE/IMP only
  # model "highres/sprites/firstperson/2530_clip.md3" {                  // most/mer : diff MD3, same skin
  #    skin { pal 0 file "highres/sprites/pickups/0040_pistolammo.jpg" }
  # model "highres/sprites/firstperson/2532_cliphand.md3" {  // most/mer : same MD3 + same skin til r295
  #    skin { pal 0 file "highres/sprites/firstperson/2532_cliphand.png" } // til r295, then duke_hand_*
  #

  SPR="highres/sprites"
  SPRE="${EXTRACTDIR}/highres/sprites"
  PATCHTYPE=$1

  case "$PATCHTYPE" in
    polymer)
      echo "  # Using \"Polymer approach\")"
      cp -pi $SPR/firstperson/2510_devastator.md3            "$SPRE/firstperson"
      cp -pi $SPR/firstperson/2510_devastator.png            "$SPRE/firstperson"
      cp -pi $SPR/firstperson/2510_devastator_s.png          "$SPRE/firstperson"
      cp -pi $SPR/firstperson/2510_devastator_g.png          "$SPRE/firstperson"
      cp -pi $SPR/firstperson/2524_pistol.md3                "$SPRE/firstperson"
      cp -pi $SPR/firstperson_polymost/2524_pistol.png       "$SPRE/firstperson"
      cp -pi $SPR/firstperson_polymost/2524_pistol_g.png     "$SPRE/firstperson"
      cp -pi $SPR/firstperson/2530_clip.md3                  "$SPRE/firstperson"
      cp -pi $SPR/pickups/0040_pistolammo.jpg                "$SPRE/pickups"
      cp -pi $SPR/firstperson/2532_cliphand.md3              "$SPRE/firstperson"
      cp -pi $SPR/firstperson/2532_cliphand.png              "$SPRE/firstperson"
      cp -pi $SPR/firstperson/duke_hand_d.png                "$SPRE/firstperson"
      cp -pi $SPR/firstperson/duke_hand_n.png                "$SPRE/firstperson"
      cp -pi $SPR/firstperson/duke_hand_s.png                "$SPRE/firstperson"
      ;;
    polymost)
      echo "  # Using (\"Polymost approach\")"
      cp -pi $SPR/firstperson_polymost/2510_devastator.md3   "$SPRE/firstperson"
      cp -pi $SPR/firstperson_polymost/2510_devastator.png   "$SPRE/firstperson"
      #cp -pi $SPR/firstperson/2510_devastator_s.png          "$SPRE/firstperson"
      cp -pi $SPR/firstperson_polymost/2510_devastator_g.png "$SPRE/firstperson"
      cp -pi $SPR/firstperson_polymost/2524_pistol.md3       "$SPRE/firstperson"
      cp -pi $SPR/firstperson_polymost/2524_pistol.png       "$SPRE/firstperson"
      cp -pi $SPR/firstperson_polymost/2524_pistol_g.png     "$SPRE/firstperson"
      cp -pi $SPR/firstperson_polymost/2530_clip.md3         "$SPRE/firstperson"
      cp -pi $SPR/pickups/0040_pistolammo.jpg                "$SPRE/pickups"
      cp -pi $SPR/firstperson_polymost/2532_cliphand.md3     "$SPRE/firstperson"
      cp -pi $SPR/firstperson/2532_cliphand.png              "$SPRE/firstperson"
      cp -pi $SPR/firstperson/duke_hand_d.png                "$SPRE/firstperson"
      cp -pi $SPR/firstperson/duke_hand_n.png                "$SPRE/firstperson"
      cp -pi $SPR/firstperson/duke_hand_s.png                "$SPRE/firstperson"
      ;;
    mixed)
      echo "  # Using (\"Mixed approach\")"
      echo "    # Not applied / Not yet implemented"
      ;;
    none)
      #echo "  Not applied"
      echo "  # Not yet implemented"
      ;;
    *)
      echo "  # Bad parameter"
      ;;
  esac

} # dukeplus_polymost_compatibility()


parse_defs()
{
  echo "$1"
  BLOCK_COMMENT="OFF"
  cat $1 | while read DEF_LINE; do

    #DOS only: DEF_FILE=`echo "${DEF_LINE}" | grep -wE "^include" | sed s/include\ //`
    DEF_FILE=`echo "${DEF_LINE}" | grep -wE "^include" | sed s/include\ // | sed s/\\\r//`
    if [ "${DEF_FILE}" != "" ] ; then
      cp -p      "${DEF_FILE}" "${EXTRACTDIR}/${DEF_FILE}"
      parse_defs "${DEF_FILE}"
    fi

    #HRP_TERM=`echo "${DEF_LINE}" | grep -owE "file|model|voxel|front|right|back|left|top|bottom|down"`
    ## Old style added (except "defineskybox"):
    HRP_TERM=`echo "${DEF_LINE}" | grep -owE "definetexture|definemodel|definemodelskin|file|model|voxel|front|right|back|left|top|bottom|down"`
    #More skybox tokens: tile, pal, ft|rt|bk|lf|up|dn|forward|lt|ceiling|floor|ceil

    if [ ! "$EXTRACT_COMMENTED_FILES" = "YES" ] ; then

      COMMENT_TERM=`echo "${DEF_LINE}" | grep -oE "\\/\\*|\\*\\/"`
      if [ "$COMMENT_TERM"  = "/*" ] ; then BLOCK_COMMENT="ON" ; fi

      if [ "$BLOCK_COMMENT" = "ON" ] ; then HRP_TERM="" ; fi

      if [ "$COMMENT_TERM"  = "*/" ] ; then BLOCK_COMMENT="OFF" ; fi

      if [ ! "$HRP_TERM" = "" ] ; then
        HRP_COMMENT=`echo "${DEF_LINE}" | grep -E "//.*$HRP_TERM"`
        if [ ! "$HRP_COMMENT" = "" ] ; then
          HRP_TERM=""
        fi
      fi

    fi

    case "$HRP_TERM" in
      file)
        #HRP_FILE=`echo "${DEF_LINE}" | sed -r s/^.*file\ *\"//g | sed s/\".*//`
        # Mastering the backslash :-) ... hm, no big performance gain ... :
        HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*file\\ *\"\\)\\([^\"]*\\)\\(.*\\)/\\\2/`
        # Ignore comments WIP:
        #HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*file\\ *\\)\\(\\"\\(.*\\)\\"\\)\\(.*\\)/\\\3/`
        ;;
      model|voxel)
        HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*${HRP_TERM}\\ *\"\\)\\([^\"]*\\)\\(.*\\)/\\\2/`
        ;;
      front|right|back|left|top|bottom|down)
        #HRP_FILE=`echo "${DEF_LINE}" | sed -r s/^.*${HRP_TERM}\ *\"//g | sed s/\".*//`
        HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*${HRP_TERM}\\ *\"\\)\\([^\"]*\\)\\(.*\\)/\\\2/`
        ;;
      ## Old Style
      definemodel)
        HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*${HRP_TERM}\\ *\"\\)\\([^\"]*\\)\\(.*\\)/\\\2/`
        ;;
      definemodelskin)
        HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*${HRP_TERM}\\ 0\\ \"\\)\\([^\"]*\\)\\(.*\\)/\\\2/`
        ;;
      definetexture)
        # Won't work atm if filename in quotes (too lazy)
        #HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(\\.*\\)\\(\\ \\)\\(.*\\)\\($\\)/\\\3/`
        HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(\\.*\\)\\(\\ \\)\\([0-9a-zA-Z\\_\\/\\.]*\\)\\(.*\\)/\\\3/`
        #echo "DEF_LINE : ${DEF_LINE}"
        #echo "HRP_FILE : ${HRP_FILE}"
        ;;
      *)
        HRP_FILE=""
        ;;
    esac

    if [  !   "${HRP_FILE}" = "" ] ; then
      if [ -f "${HRP_FILE}" ] ; then
        cp -p "${HRP_FILE}" "${EXTRACTDIR}/${HRP_FILE}"
      else
        echo  "WARNING : ${HRP_FILE} is missing!"
      fi
    fi

  done
} # parse_defs()


delete_empty_folders()
{
    if [ -d "${EXTRACTDIR}" ] ; then
      rm -rf ${EXTRACTDIR}/.svn
      rm -rf ${EXTRACTDIR}/installer
      DIRLIST=./EXTRACT_DIRECTORIES.lst
      du "${EXTRACTDIR}" > ${DIRLIST}
      cat ${DIRLIST} | while read DIR ; do
        if [ "0" = "`echo \"${DIR}\" | grep -owE \"0\"`" ] ; then
          EMPTYDIR="`echo \"${DIR}\" | sed -r --posix s/0//`"
          if [ -d ${EMPTYDIR} ] ; then
            rmdir ${EMPTYDIR}
          fi
        fi
      done
      rm ${DIRLIST}
    else
      echo "No ${EXTRACTDIR}."
    fi
} # delete_empty_folders()


main()
{
  EXTRACTDIR=../hrp_${HRPTYPE}_extract
  echo  "EXTRACT :" ${HRPROOT}/${EXTRACTDIR}

  if [ $FORCE = 0 ] ; then
    if ask "Proceed?"
      then echo "Extracting ${HRPTYPE} from \"${HRPROOT}\" "
      else exit 0
    fi
  fi

  date +%F" "%H:%M:%S

  echo "### Deleting ${EXTRACTDIR} ... ###"
  rm -rf ${EXTRACTDIR}

  echo "### Copying directory tree ... ###"
  copy_folders

  echo "### Copying 'known' files ... ###"
  copy_known_files

  if [ "${HRPTYPE}" = "polymost" ] || [ "${HRPTYPE}" = "polymost_override" ] ; then
    echo "### Creating Polymost maphacks ... ###"
    create_polymost_mhk

    #echo "### DukePlus<>Polymost HRP compatibility patch ... ###"
    #dukeplus_polymost_compatibility $DUKEPLUS_POLYMOST_COMPATIBILTY_APPROACH
  fi

  echo "### Parsing DEF file hierarchy ... ###"
  if [ "$EXTRACT_COMMENTED_FILES" = "YES" ] ; then
    echo "  # Extract commented textures and models: $EXTRACT_COMMENTED_FILES"
  else
    echo "  # Extract commented textures and models: NO"
  fi
  if [ "${HRPTYPE}" = "polymost" ] || [ "${HRPTYPE}" = "full" ] ; then
    parse_defs duke3d_hrp_polymost.def
  fi
  if [ "${HRPTYPE}" = "polymer" ] || [ "${HRPTYPE}" = "full" ] ; then
    parse_defs duke3d_hrp.def
  fi
  if [ "${HRPTYPE}" = "voxel" ] ; then
    parse_defs duke3d_voxel.def
  fi
  if [ "${HRPTYPE}" = "sw_highres" ] ; then
    parse_defs highres/sw_hrp.def
  fi
  if [ "${HRPTYPE}" = "sw_lowres" ] ; then
    parse_defs lowres/sw_lrp.def
  fi
  if [ "${HRPTYPE}" = "default" ] ; then
    parse_defs "${DEF_TOP}"
  fi

  echo "### Deleting empty directories in ${EXTRACTDIR} ... ###"
  delete_empty_folders

  date +%F" "%H:%M:%S

  echo "Command line example for creating a ZIP package:"
  echo "sh -c \"cd ${EXTRACTDIR} ; zip -rqn .zip:.jpg:.png ${EXTRACTDIR}.zip *\""
} # main()



PRGPATH=$0
HRPTYPE=$1
if [ "$2" = "y" ] ; then FORCE=1 ; else FORCE=0 ; fi
if [ "$2" = "v" ] && [ ! "$3" = "" ] ; then
  VERSION="$3"
  echo "${VERSION}" > VERSION
fi
HRPROOT=.
WORKDIR=`pwd`

cd               "${HRPROOT}"
echo  "PWD     :  ${WORKDIR}"
echo  "HRPROOT :  ${HRPROOT}"

#if [ ! -f "./duke3d.def" ] && [ ! "${HRPTYPE}" = "default" ] ; then
#  echo "ERROR : ./duke3d.def not found. This is no HRP root directory. Exit."
#  exit 1
#fi

case "$HRPTYPE" in
  polymer|polymost_override|polymost)
    main $HRPTYPE
    ;;
  full)
    if [ $FORCE = 0 ] ; then if ask "Extract full HRP (+ Override Pack)?"
      then echo "Extracting ${HRPTYPE} from \"${HRPROOT}\" "
      else exit 0
    fi ; fi
    ${PRGPATH} polymost_override y
    main $HRPTYPE
    ;;
  both)
    if [ $FORCE = 0 ] ; then if ask "Extract both pure HRP?"
      then echo "Extracting ${HRPTYPE} from \"${HRPROOT}\" "
      else exit 0
    fi ; fi
    ${PRGPATH} polymer  y
    ${PRGPATH} polymost y
    ;;
  all)
    if [ $FORCE = 0 ] ; then if ask "Extract all packs from the repository?"
      then echo "Extracting ${HRPTYPE} from \"${HRPROOT}\" "
      else exit 0
    fi ; fi
    ${PRGPATH} both y
    ${PRGPATH} full y
    ;;
  voxel)
    SET_VERSION=NO
    main $HRPTYPE
    ;;
  sw_highres|sw_lowres)
    SET_VERSION=NO
    main $HRPTYPE
    ;;
  sw_both)
    if [ $FORCE = 0 ] ; then if ask "Extract both Shadow Warrior HRP/LRP?"
      then echo "Extracting ${HRPTYPE} from \"${HRPROOT}\" "
      else exit 0
    fi ; fi
    ${PRGPATH} sw_lowres  y
    ${PRGPATH} sw_highres y
    ;;
  unused)
    echo "Option \"$1\" not yet implemented."
    ;;
  debug)
    echo "Nothing to debug."
    ;;
  *)
    #if [ ! -f "./${HRPTYPE}.def" ] ; then
    #  echo "ERROR : ./${HRPTYPE}.def not found. This is no HRP root directory. Exit."
    #  exit 1
    #fi
    if [ -f "${HRPTYPE}.def" ] ; then
      DEF_TOP="${HRPTYPE}.def"
      HRPTYPE=default
      SET_VERSION=NO
      EXTRACT_COMMENTED_FILES=NO
      main $HRPTYPE
    else
      echo "Usage: ${0} {HRPTYPE|TOP_DEF} [v VERSION]"
      echo "HRPTYPEs: {full|polymer|polymost_override|polymost|both|all}"
      echo "HRPTYPEs: {sw_highres|sw_lowres|sw_both}"
      echo "TOP_DEF:  {Filename without extension}"
      exit 1
    fi
    ;;
esac

exit 0
