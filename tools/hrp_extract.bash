#!/bin/bash

# Duke Nukem 3D CON/DEF/HRP File Extractor  v0.9.3  2020-03-21
#
# Author:  LeoD
# License: ISC License -> https://opensource.org/licenses/isc-license.txt
#
# This script extracts a working copy of your local Duke Nukem 3D High
# Resolution Pack's Subversion repository, ready for zipping and distribution.
# This is mostly done by hierarchically parsing the *.def files.
# PolyMER or PolyMOST only versions can be chosen.
#
# On Windows you may use the Bash shell that comes with either MSYS2 or Git.
# Bash's performance of calling executables is horrible, better go Linux. Even
# my virtual Debian machine accessing the Windows drive is several times faster.
# As of v0.9.0, Bash's builtin regex engine is used for many parts, but it fails
# to use the \b word delimiter correctly on Windows ( v4.4.23, x86_64-pc-msys ).

DEF_TOP=UNDEFINED
CON_TOP=UNDEFINED
GRP_TOP=UNDEFINED
GRP=""
SET_VERSION=YES            # [YES|NO]
EXTRACT_COMMENTED_FILES=NO # [YES|NO]
DUKEPLUS_POLYMOST_COMPATIBILTY_APPROACH=polymost  #[none|polymost|polymer|mixed]
ATTRITION_POLYMOST_COMPATIBILTY_APPROACH=polymost #[none|polymost|polymer|mixed]

exit_on_error() {
  echo -e "\e[0;31mERROR   :\e[0m ${@}"
  exit 1
}

warning() {
  echo -e "\e[1;35mWARNING :\e[0m ${@}"
}

info() {
  echo -e "\e[0;32mINFO    :\e[0m ${@}"
}

ask() {
  echo -n "$@" '[y/N] ' ; read ans
  case "$ans" in
    y*|Y*) return 0 ;;
    *)     return 1 ;;
  esac
} # ask


copy_folders() {
  mkdir ${EXTRACTDIR} || exit_on_error "Could not create ${EXTRACTDIR}/"
  for SUBDIR in . ; do
    if [ -d "${SUBDIR}" ] ; then
      DIRLIST=${EXTRACTDIR}/DIRECTORIES.lst
      find  "${SUBDIR}" -type d | grep -v "\.svn" > ${DIRLIST}
      cat ${DIRLIST} | while read DIR; do
        if [ ! -d "${EXTRACTDIR}/${DIR}" ] ; then
          mkdir   "${EXTRACTDIR}/${DIR}" || exit_on_error\
            "Could not create ${EXTRACTDIR}/${DIR}/"
        fi
      done
      rm ${DIRLIST}
    else
      exit_on_error "${SUBDIR} : Oops."
    fi
  done
} # copy_folders()


copy_set_version() {
  VER_FILE="$1"
  TARGET_FILE="$2"
  if [ ! "${SET_VERSION}" = "YES" ] ; then
    cp -pv "${VER_FILE}" "${TARGET_FILE}"
  else

    V_DATE=`date +%F`
    if [ "${VERSION}" = "" ] ; then
      if [ -f VERSION ] ; then
        VERSION=`grep -owE "[0-9\\.]*" VERSION`
      fi
    fi

    echo "copy_set_version: ${VER_FILE} -> ${TARGET_FILE}"

    case "${VER_FILE}" in
      hrp_readme.txt)
        cat "${VER_FILE}" | sed -r --posix \
          s/\(Version\ *\)\([0-9\.]*\)\(.*\)\(\\\)\)\(.*\)/\\1${VERSION}\ \(${V_DATE}\)\ \ \\5/ \
          > "${TARGET_FILE}"
        ;;
      duke3d_hrp.def)
        if [ "${HRPTYPE}" = "polymer" ] ; then
          cat "${VER_FILE}" | sed -r --posix \
            s/\(Version\ *\)\([0-9\.]*\)\(.*\)/\\1${VERSION}\ Polymer\\3/ \
            > "${TARGET_FILE}"
        else
          cat "${VER_FILE}" | sed -r --posix \
            s/\(Version\ *\)\([0-9\.]*\)\(.*\)/\\1${VERSION}\\3/ \
            > "${TARGET_FILE}"
        fi
        ;;
      duke3d_hrp_polymost.def | \
      tools/polymost_override/duke3d_hrp_polymost_override.def | \
      duke3d_hrp_megaton.def | \
      tools/megaton_override/duke3d_hrp_megaton_override.def | \
      duke3d_maphacks.def )
        cat "${VER_FILE}" | sed -r --posix \
          s/\(Version\ *\)\([0-9\.]*\)\(.*\)/\\1${VERSION}\\3/ \
          > "${TARGET_FILE}"
        ;;
      *)
        exit_on_error "copy_set_version() - UNKNOWN FILE: ${VER_FILE}"
        ;;
    esac
  fi
} # copy_set_version()

tar_copy_dir() {
  (cd ${1}; tar cf - . ) | (cd ${2}; tar xf -)
}

copy_known_files() {

  if [ -f hrp_readme.txt ] ; then
    copy_set_version hrp_readme.txt "${EXTRACTDIR}/hrp_readme.txt"
  fi

  if [ "${HRPTYPE}" = "polymost" ] || [ "${HRPTYPE}" = "polymost_override" ] ||\
     [ "${HRPTYPE}" = "megaton" ]  || [ "${HRPTYPE}" = "megaton_override" ] ||\
     [ "${HRPTYPE}" = "maphacks" ] ||\
     [ "${HRPTYPE}" = "polymer"  ] || [ "${HRPTYPE}" = "full" ] ; then
    cp -pv hrp_art_license.txt      "${EXTRACTDIR}"
  fi

  if [ "${HRPTYPE}" = "polymost" ] || [ "${HRPTYPE}" = "polymer" ] ||\
     [ "${HRPTYPE}" = "maphacks" ] || [ "${HRPTYPE}" = "full" ] ||\
     [ "${HRPTYPE}" = "voxels" ] ; then
    cp -pv maphacks/MapHacks.txt    "${EXTRACTDIR}/maphacks/"
  fi

  if [ "${HRPTYPE}" = "polymost" ] ; then
    cp -pv           duke3d_hrp_polymost.def "${EXTRACTDIR}"
    copy_set_version duke3d_hrp_polymost.def "${EXTRACTDIR}/duke3d_hrp.def"
    cp -pvr tools/polymost_override/dukedc   "${EXTRACTDIR}"
  fi

  if [ "${HRPTYPE}" = "megaton" ] ; then
    cp -pv           duke3d_hrp_megaton.def "${EXTRACTDIR}"
    copy_set_version duke3d_hrp_megaton.def "${EXTRACTDIR}/duke3d_hrp.def"
    cp -pv highres/screen/menu/2492_ver_megaton.png \
      "${EXTRACTDIR}/highres/screen/menu/2492_ver_polymost.png"
    cp -pvr tools/megaton_override/dukedc* "${EXTRACTDIR}"
    cp -pvr tools/megaton_override/highres "${EXTRACTDIR}"
  fi

  if [ "${HRPTYPE}" = "polymost_override" ] ; then
    copy_set_version \
      tools/polymost_override/duke3d_hrp_polymost_override.def \
      "${EXTRACTDIR}/duke3d_hrp.def"
    copy_set_version \
      tools/polymost_override/duke3d_hrp_polymost_override.def \
      "${EXTRACTDIR}/duke3d_hrp_polymost.def"
    cp -pv tools/polymost_override/hrp_polymost_override.txt \
      "${EXTRACTDIR}"
    cp -pv tools/polymost_override/2492_ver_polymost_override.png \
      "${EXTRACTDIR}/highres/screen/menu/2492_ver_polymost.png"
    cp -pvr tools/polymost_override/dukedc "${EXTRACTDIR}"
  fi

  if [ "${HRPTYPE}" = "megaton_override" ] ; then
    copy_set_version \
      tools/megaton_override/duke3d_hrp_megaton_override.def \
      "${EXTRACTDIR}/duke3d_hrp.def"
    copy_set_version \
      tools/megaton_override/duke3d_hrp_megaton_override.def \
      "${EXTRACTDIR}/duke3d_hrp_megaton.def"
    cp -pv tools/megaton_override/hrp_megaton_override.txt \
      "${EXTRACTDIR}"
    cp -pv tools/megaton_override/2492_ver_megaton_override.png \
      "${EXTRACTDIR}/highres/screen/menu/2492_ver_megaton.png"
    cp -pv  tools/megaton_override/*.bat   "${EXTRACTDIR}"
    cp -pvr tools/megaton_override/dukedc* "${EXTRACTDIR}"
    cp -pvr tools/megaton_override/highres "${EXTRACTDIR}"
    # Let Megaton Override work on top of Polymost HRP:
    #cp -pv highres/screen_megaton.def          "${EXTRACTDIR}/highres/"
    #cp -pv highres/screen/menu_megaton.def     "${EXTRACTDIR}/highres/screen/"
    #cp -pv highres/sprites_megaton.def         "${EXTRACTDIR}/highres/"
    #cp -pv highres/sprites/effects_megaton.def "${EXTRACTDIR}/highres/sprites/"
  fi

  if [ "${HRPTYPE}" = "polymost" ] || [ "${HRPTYPE}" = "megaton" ] ; then
    cp -pv duke3d.def "${EXTRACTDIR}"
    cp -pv highres/screen/menu/2492_polymost.png \
      "${EXTRACTDIR}/highres/screen/menu/"
  fi

  if [ "${HRPTYPE}" = "full" ] ; then
    copy_set_version duke3d_hrp_polymost.def \
      "${EXTRACTDIR}/duke3d_hrp_polymost.def"
    copy_set_version duke3d_hrp_megaton.def \
      "${EXTRACTDIR}/duke3d_hrp_megaton.def"
  fi

  if [ "${HRPTYPE}" = "full" ] ; then
    cp -pv highres/screen/menu/2492_ver_polymost.png \
      "${EXTRACTDIR}/highres/screen/menu/"
  fi

  if [ "${HRPTYPE}" = "polymer" ] || [ "${HRPTYPE}" = "full" ] ; then
    cp -pv           duke3d.def     "${EXTRACTDIR}"
    copy_set_version duke3d_hrp.def "${EXTRACTDIR}/duke3d_hrp.def"
    #cp -pv highres/screen/menu/2492.png "${EXTRACTDIR}/highres/screen/menu"

    #cp -pv highres/common/black.png                          "${EXTRACTDIR}/highres/common/"
    #cp -pv highres/screen/fonts/digital/digital_minus.png    "${EXTRACTDIR}/highres/screen/fonts/digital/"
    #cp -pv highres/screen/menu/widescreen/*_wide.png         "${EXTRACTDIR}/highres/screen/menu/"
    #cp -pv highres/sprites/characters/1357_terminarm.md3     "${EXTRACTDIR}/highres/sprites/characters/"
    #cp -pv highres/sprites/firstperson/2510_devastator_n.png "${EXTRACTDIR}/highres/sprites/firstperson/"
    #cp -pv highres/sprites/monsters/1960_reconcar_s.png      "${EXTRACTDIR}/highres/sprites/monsters/"
    #cp -pv highres/sprites/props/4387.png                    "${EXTRACTDIR}/highres/sprites/props/"
    #cp -pv highres/sprites/signs/4378-79.png                 "${EXTRACTDIR}/highres/sprites/signs/"
    #cp -pv highres/sprites/signs/4381-85.png                 "${EXTRACTDIR}/highres/sprites/signs/"
  fi

  if [ "${HRPTYPE}" = "maphacks" ] ; then
    cp -pv           maphacks/MapHacks.txt          "${EXTRACTDIR}"
    cp -pv           maphacks/mhk-extract.def       "${EXTRACTDIR}/maphacks/"
    cp -pv           maphacks/maphacks_polymost.def "${EXTRACTDIR}/maphacks/"
    cp -pv           duke3d_maphacks.def            "${EXTRACTDIR}"
    copy_set_version duke3d_maphacks.def            "${EXTRACTDIR}/duke3d.def"
  fi

  if [ "${HRPTYPE}" = "voxels" ] ; then
    cp -pv voxelpack_readme.txt      "${EXTRACTDIR}"
    cp -pv voxelpack_art_license.txt "${EXTRACTDIR}"
    cp -pv duke3d.def                "${EXTRACTDIR}"
    cp -pv duke3d_voxels.def         "${EXTRACTDIR}"
    cp -pv dukegdx.def               "${EXTRACTDIR}"
    cp -pv voxels/pickups_gdx.def    "${EXTRACTDIR}/voxels/"
    #cp -pv voxels/monsters.def       "${EXTRACTDIR}/voxels/"
    #cp -pv voxels/monsters/*.kvx     "${EXTRACTDIR}/voxels/monsters/"
    cp -pv voxels/hrp_undefines.def  "${EXTRACTDIR}/voxels/"
    cp -pv eduke.con                 "${EXTRACTDIR}"
    if [ -d  scripts/ ] ; then
      cp -pv scripts/*.con           "${EXTRACTDIR}/scripts/"
    fi
    ### LeoD ###
    if [ -f  EDUKE.CON ] ; then
      cp -pv EDUKE.CON               "${EXTRACTDIR}"
    fi
    if [ -d   voxels/scripts/ ] ; then
      #cp -pv voxels/scripts/faucet2.con    "${EXTRACTDIR}/voxels/scripts/"
      #cp -pv voxels/scripts/freezeammo.con "${EXTRACTDIR}/voxels/scripts/"
      #cp -pv voxels/scripts/holoduke.con   "${EXTRACTDIR}/voxels/scripts/"
      #cp -pv voxels/scripts/pigtank.con    "${EXTRACTDIR}/voxels/scripts/"
      #cp -pv voxels/scripts/rotation.con   "${EXTRACTDIR}/voxels/scripts/"
      cp  -pv voxels/scripts/*.con          "${EXTRACTDIR}/voxels/scripts/"
    fi
  fi

  if [ "${HRPTYPE}" = "sw_highres" ] ; then
    cp -pv sw.def                   "${EXTRACTDIR}"
    cp -pv highres/sw_hrp.def       "${EXTRACTDIR}/highres/"
    cp -pv HRP.bat                  "${EXTRACTDIR}"
    cp -pv HRP_Readme.txt           "${EXTRACTDIR}"
    cp -pv HRP_Changes.txt          "${EXTRACTDIR}"
    info "Copying  skyboxes ..."
    tar_copy_dir "highres/skyboxes" "${EXTRACTDIR}/highres/skyboxes"
    cd "${WORKDIR}"
  fi

  if [ "${HRPTYPE}" = "sw_lowres" ] ; then
    info "Creating sw.def for lowres HRP ..."
    echo "include lowres/sw_lrp.def" > "${EXTRACTDIR}/sw.def"
    cp -pv lowres/sw_lrp.def           "${EXTRACTDIR}/lowres/"
    cp -pv LRP.bat                     "${EXTRACTDIR}"
    cp -pv LRP_Readme.txt              "${EXTRACTDIR}"
    cp -pv LRP_Changes.txt             "${EXTRACTDIR}"
    info "Copying  skyboxes ..."
    tar_copy_dir "highres/skyboxes"    "${EXTRACTDIR}/highres/skyboxes"
    cd "${WORKDIR}"
  fi

  if [ "${HRPTYPE}" = "auto" ] ; then
    for txtfile in *.txt; do
      cp -pv "$txtfile" "${EXTRACTDIR}"
    done
  fi

} # copy_known_files()


copy_polymost_mhk() {
  cp -p maphacks/3drealms/E?L*_polymost.mhk "${EXTRACTDIR}"
  cp -p maphacks/dukedc/DUKEDC*-megaton.mhk "${EXTRACTDIR}"
  rm -f "${EXTRACTDIR}"/*_13d_*.mhk
  rm -f "${EXTRACTDIR}"/*_worldtour_*.mhk
  # bashism:
  for i in "${EXTRACTDIR}"/*_polymost.mhk ; do mv "$i" "${i/_polymost}" ; done
  for i in "${EXTRACTDIR}"/*-megaton.mhk  ; do mv "$i" "${i/-megaton}"  ; done
} # copy_polymost_mhk()


# I really don't know yet if this will become necessary, or if it does make
# sense at all, but at least the files involved are listed.
dukeplus_polymost_hrp_compatibility()
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
      echo "          (Using \"Polymer approach\")"
      cp -pi $SPR/firstperson/2510_devastator.md3            "$SPRE/firstperson/"
      cp -pi $SPR/firstperson/2510_devastator.png            "$SPRE/firstperson/"
      cp -pi $SPR/firstperson/2510_devastator_s.png          "$SPRE/firstperson/"
      cp -pi $SPR/firstperson/2510_devastator_g.png          "$SPRE/firstperson/"
      cp -pi $SPR/firstperson/2524_pistol.md3                "$SPRE/firstperson/"
      cp -pi $SPR/firstperson_polymost/2524_pistol.png       "$SPRE/firstperson/"
      cp -pi $SPR/firstperson_polymost/2524_pistol_g.png     "$SPRE/firstperson/"
      cp -pi $SPR/firstperson/2530_clip.md3                  "$SPRE/firstperson/"
      cp -pi $SPR/pickups/0040_pistolammo.jpg                "$SPRE/pickups/"
      cp -pi $SPR/firstperson/2532_cliphand.md3              "$SPRE/firstperson/"
      cp -pi $SPR/firstperson/2532_cliphand.png              "$SPRE/firstperson/"
      cp -pi $SPR/firstperson/duke_hand_d.png                "$SPRE/firstperson/"
      cp -pi $SPR/firstperson/duke_hand_n.png                "$SPRE/firstperson/"
      cp -pi $SPR/firstperson/duke_hand_s.png                "$SPRE/firstperson/"
      ;;
    polymost)
      echo "          (Using \"Polymost approach\")"
      #cp -pi $SPR/firstperson_polymost/2510_devastator.md3   "$SPRE/firstperson/"
      #cp -pi $SPR/firstperson_polymost/2510_devastator.png   "$SPRE/firstperson/"
      ##cp -pi $SPR/firstperson/2510_devastator_s.png          "$SPRE/firstperson/"
      #cp -pi $SPR/firstperson_polymost/2510_devastator_g.png "$SPRE/firstperson/"
      cp -pi $SPR/firstperson_polymost/2524_pistol.md3       "$SPRE/firstperson/"
      #cp -pi $SPR/firstperson_polymost/2524_pistol.png       "$SPRE/firstperson/"
      #cp -pi $SPR/firstperson_polymost/2524_pistol_g.png     "$SPRE/firstperson/"
      #cp -pi $SPR/firstperson_polymost/2530_clip.md3         "$SPRE/firstperson/"
      #cp -pi $SPR/pickups/0040_pistolammo.jpg                "$SPRE/pickups/"
      #cp -pi $SPR/firstperson_polymost/2532_cliphand.md3     "$SPRE/firstperson/"
      #cp -pi $SPR/firstperson/2532_cliphand.png              "$SPRE/firstperson/"
      #cp -pi $SPR/firstperson/duke_hand_d.png                "$SPRE/firstperson/"
      #cp -pi $SPR/firstperson/duke_hand_n.png                "$SPRE/firstperson/"
      #cp -pi $SPR/firstperson/duke_hand_s.png                "$SPRE/firstperson/"
      ;;
    mixed)
      echo "          (Using \"Mixed approach\")"
      echo "          Not applied / Not yet implemented"
      ;;
    none)
      info "  Not applied"
      #echo "  # Not yet implemented"
      ;;
    *)
      warning "  Bad parameter"
      ;;
  esac

} # dukeplus_polymost_hrp_compatibility()


attrition_polymost_hrp_compatibility() {
  # attr_hrp.def expects some files to be present in the HRP
  #
  # model "highres/sprites/firstperson/2524_pistol.md3" {    // most/mer : same MD3 + same skin til r295     
  #    skin { pal 0 file "highres/sprites/firstperson/2524_pistol.png" } // up to DP2.30 DNE/IMP only
  #    glow { file "highres/sprites/firstperson/2524_pistol_g.png" }     // up to DP2.30 DNE/IMP only

  SPR="highres/sprites"
  SPRE="${EXTRACTDIR}/highres/sprites"
  PATCHTYPE=$1

  case "$PATCHTYPE" in
    polymer)
      echo "          (Using \"Polymer approach\")"
      ;;
    polymost)
      echo "          (Using \"Polymost approach\")"
      cp -piu $SPR/firstperson_polymost/2524_pistol.md3      "$SPRE/firstperson/"
      cp -pi  $SPR/firstperson_polymost/2524_pistol.png      "$SPRE/firstperson/"
      cp -pi  $SPR/firstperson_polymost/2524_pistol_g.png    "$SPRE/firstperson/"
      cp -pi  $SPR/firstperson/2530_clip.md3                 "$SPRE/firstperson/"
      #cp -pi  $SPR/firstperson/2532_cliphand.md3             "$SPRE/firstperson/"
      ##cp -pi  $SPR/firstperson/2532_cliphand.png             "$SPRE/firstperson/"
      #cp -pi  $SPR/firstperson/duke_hand_d.png               "$SPRE/firstperson/2532_cliphand.png"
      ;;
    mixed)
      echo "          (Using \"Mixed approach\")"
      cp -piu $SPR/firstperson_polymost/2524_pistol.md3       "$SPRE/firstperson/"
      cp -pi  $SPR/firstperson_polymost/2524_pistol.png       "$SPRE/firstperson/"
      cp -pi  $SPR/firstperson_polymost/2524_pistol_g.png     "$SPRE/firstperson/"
      cp -pi  $SPR/firstperson/2530_clip.md3                 "$SPRE/firstperson/"
      #cp -pi  $SPR/firstperson/2532_cliphand.md3             "$SPRE/firstperson/"
      ##cp -pi  $SPR/firstperson/2532_cliphand.png             "$SPRE/firstperson/"
      #cp -pi  $SPR/firstperson/duke_hand_d.png               "$SPRE/firstperson/2532_cliphand.png"
      cp -pi  $SPR/firstperson/2544_rpg.md3                  "$SPRE/firstperson/"
      cp -pi  $SPR/firstperson/2544_rpg_d.png                "$SPRE/firstperson/2544_rpg.png"
      cp -pi  $SPR/firstperson/2544_rpg_n.png                "$SPRE/firstperson/"
      cp -pi  $SPR/firstperson/2544_rpg_s.png                "$SPRE/firstperson/"
      cp -pi  $SPR/firstperson/duke_hand_d.png               "$SPRE/firstperson/"
      cp -pi  $SPR/firstperson/duke_hand_n.png               "$SPRE/firstperson/"
      cp -pi  $SPR/firstperson/duke_hand_s.png               "$SPRE/firstperson/"
      cp -pi  $SPR/firstperson/muzzle_flash_01.png           "$SPRE/firstperson/"
      cp -pi  highres/common/transp.png                      "${EXTRACTDIR}/highres/common"
      ;;
    none)
      info "  Not applied"
      #echo "  # Not yet implemented"
      ;;
    *)
      warning "  Bad parameter"
      ;;
  esac

} # attrition_polymost_hrp_compatibility()


extract_file() {
  local FILE="$1"
  if [ -f "${FILE}" ] ; then
    cp -p "${FILE}" "${EXTRACTDIR}/${FILE}"
  elif [ ${GRP} ] ; then
    cd "${EXTRACTDIR}/${GRP}"
      kextract "${WORKDIR}/${GRP}" "${FILE}" > /dev/null
    cd "${WORKDIR}"
    if [ ! -f "${EXTRACTDIR}/${GRP}/${FILE}" ] ; then
      warning "${FILE} is missing!"
    #else
    #  echo -e "${FILE} -> \e[0;33m${GRP}/\e[0m${FILE^^}"
    fi
  else
    warning "${FILE} is missing!"
  fi
}


parse_defs() {
  local DEF_FILE="$1"
  extract_file "${DEF_FILE}"
  if [ -f "${DEF_FILE}" ] ; then
    echo  "${DEF_FILE}"
  elif [  -f "${EXTRACTDIR}/${GRP}/${DEF_FILE}" ] ; then
    echo   -e "${DEF_FILE} -> \e[0;33m${GRP}/\e[0m${DEF_FILE^^}"
    DEF_FILE="${EXTRACTDIR}/${GRP}/${DEF_FILE^^}"
  else
    return
  fi

  BLOCK_COMMENT="OFF"

  cat "${DEF_FILE}" | while read DEF_LINE; do

    #echo "DEF_LINE1: ${DEF_LINE}"
    #DEF_TERM=`echo "${DEF_LINE}" | grep -owE "file|model|voxel|front|right|back|left|top|bottom|down"`
    ## Old style added (except "defineskybox"):
    #DEF_TERM=`echo "${DEF_LINE}" | grep -owE "include|definetexture|definemodel|definemodelskin|file|mhkfile|model|voxel|front|right|back|left|top|bottom|down|\\/\\*|\\*\\/"`
    #More skybox tokens: tile, pal, ft|rt|bk|lf|up|dn|forward|lt|ceiling|floor|ceil
    #echo "DEF_TERM1: ${DEF_TERM}"

    local TOKEN_LIST='\b(include\b'
    local TOKEN_LIST='^(include)'
    local TOKEN_LIST='(^include|file|^definetexture|^definemodel|^definemodelskin|^mhkfile|^model|^voxel|^front|^right|^back|^left|^top|^bottom|^down|\/\*|\*\/)'

    if [[ ${DEF_LINE} =~ ${TOKEN_LIST} ]] ; then
      DEF_TERM="${BASH_REMATCH}"
    else
      DEF_TERM=""
    fi

    if [ "${DEF_TERM}" ] && [ "$EXTRACT_COMMENTED_FILES" = "NO" ] ; then
      #COMMENT_TERM=`echo "${DEF_LINE}" | grep -oE "\\/\\*|\\*\\/"`
      COMMENT_TERM="${DEF_TERM}"
      if [ "$COMMENT_TERM"  = "/*" ] ; then BLOCK_COMMENT="ON" ; fi

      if [ "$BLOCK_COMMENT" = "ON" ] ; then DEF_TERM="" ; fi

      if [ "$COMMENT_TERM"  = "*/" ] ; then BLOCK_COMMENT="OFF" ; fi

      if [ $DEF_TERM ] ; then
        if [[ ${DEF_LINE} =~ //.*$DEF_TERM ]] ; then
          DEF_TERM=""
        fi
      fi
    fi

    if [ "${DEF_TERM}" ] ; then case "$DEF_TERM" in
      include)
        local SUB_DEF_FILE=`echo "${DEF_LINE}" | grep -wE "^include" | awk '{ print $2 }' | sed 's/\r//'`
        if [          ${SUB_DEF_FILE} ] ; then
          parse_defs "${SUB_DEF_FILE}"
        fi
        ;;
      file)
        if [[ ${DEF_LINE} =~ \ file\  ]] ; then
          HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*${DEF_TERM}\\ *\"\\)\\([^\"]*\\)\\(.*\\)/\\\2/`
        elif [[ ! ${DEF_LINE} =~ mapfile ]] ; then
          warning "Bad 'file' statement: ${DEF_LINE}"
        fi
        ;;
      mhkfile|model|voxel)
        HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*${DEF_TERM}\\ *\"\\)\\([^\"]*\\)\\(.*\\)/\\\2/`
        ;;
      front|right|back|left|top|bottom|down)
        HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*${DEF_TERM}\\ *\"\\)\\([^\"]*\\)\\(.*\\)/\\\2/`
        ;;
      ## Old Style
      definemodel)
        HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*${DEF_TERM}\\ *\"\\)\\([^\"]*\\)\\(.*\\)/\\\2/`
        ;;
      definemodelskin)
        HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*${DEF_TERM}\\ 0\\ \"\\)\\([^\"]*\\)\\(.*\\)/\\\2/`
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
    esac ; fi

    if [ "${HRP_FILE}" ] ; then
      extract_file "${HRP_FILE}"
      HRP_FILE=""
    fi

  done
} # parse_defs()


parse_cons() {
  local CON_FILE="$1"
  extract_file "${CON_FILE}"
  if [ -f "${CON_FILE}" ] ; then
    echo  "${CON_FILE}"
  elif [  -f "${EXTRACTDIR}/${GRP}/${CON_FILE}" ] ; then
    echo   -e "${CON_FILE} -> \e[0;33m${GRP}/\e[0m${CON_FILE^^}"
    CON_FILE="${EXTRACTDIR}/${GRP}/${CON_FILE^^}"
  else
    return
  fi

  MUSIC_FLAG=""
  MUSIC_POS=""

  BLOCK_COMMENT="OFF"

  cat "${CON_FILE}" | while read CON_LINE; do

    #echo "CON_LINE : ${CON_LINE}"
    #CON_TERM=`echo "${CON_LINE}" | grep -owE "include|setdefname|definelevelname|definesound|music|\\/\\*|\\*\\/"`
    #echo "CON_TERM : ${CON_TERM}"

    #if [[ ${CON_LINE} =~ include|setdefname|definelevelname|definesound|music|\/\*|\*\/ ]] ; then
    local TOKEN_LIST='\b(include\b'
    local TOKEN_LIST='^(include)'
    local TOKEN_LIST='(include|setdefname|definelevelname|definesound|music|\/\*|\*\/)'
    if [[ ${CON_LINE} =~ ${TOKEN_LIST} ]] ; then
      #echo "Rematch  : ${BASH_REMATCH}"
      CON_TERM="${BASH_REMATCH}"
    else
      CON_TERM=""
    fi

    if [ ${MUSIC_FLAG} ] && [ "${CON_TERM}" = "" ] ; then
      MUSIC_POS="1"
	  MUSIC_FLAG=""
    else
      MUSIC_POS=""
    fi

    if [ "${CON_TERM}" ] && [ "$EXTRACT_COMMENTED_FILES" = "NO" ] ; then
      COMMENT_TERM="${CON_TERM}"
      if [ "$COMMENT_TERM"  = "/*" ] ; then BLOCK_COMMENT="ON"  ; fi

      if [ "$BLOCK_COMMENT" = "ON" ] ; then CON_TERM=""         ; fi

      if [ "$COMMENT_TERM"  = "*/" ] ; then BLOCK_COMMENT="OFF" ; fi

      if [ $CON_TERM ] ; then
        if [[ ${CON_LINE} =~ //.*$CON_TERM ]] ; then
          CON_TERM=""
        fi
      fi
    fi

    if [ "${CON_TERM}" ] ; then case "$CON_TERM" in
      include)
        local SUB_CON_FILE=`echo "${CON_LINE}" | grep -wE "$CON_TERM" | awk '{ print $2 }' | sed 's/\r//'`
        if [          ${SUB_CON_FILE} ] ; then
          parse_cons "${SUB_CON_FILE}"
        fi
        ;;
      setdefname)
        local     DEF_FILE=`echo "${CON_LINE}" | grep -wE "$CON_TERM" | awk '{ print $2 }' | sed 's/\r//'`
        if [       ${DEF_FILE} ] ; then
          DEF_TOP="${DEF_FILE}"
          info "Toplevel DEF set to ${DEF_TOP}"
          echo "${DEF_TOP}"  >   "${EXTRACTDIR}/DEF_TOP.tmp"
        fi
        ;;
      definesound)
        SOUND_FILE=`echo "${CON_LINE}" | grep -wE "$CON_TERM" | awk '{ print $3 }' | sed 's/\r//'`
        if [            ${SOUND_FILE} ] ; then
          extract_file "${SOUND_FILE}"
        fi
        ;;
      definelevelname)
          MAP_FILE=`echo "${CON_LINE}" | grep -wE "$CON_TERM" | awk '{ print $4 }' | sed 's/\r//'`
        if [            ${MAP_FILE} ] ; then
          extract_file "${MAP_FILE}"
        fi
        ;;
      music)
        MUSIC_POS=3
        while [ ${MUSIC_POS} ] ; do
          MUSIC_FILE=`echo "${CON_LINE}" | grep -wE "$CON_TERM" | awk "{ print \\$$MUSIC_POS }" | sed 's/\r//'`
          if [            ${MUSIC_FILE} ] ; then
            extract_file "${MUSIC_FILE}"
            MUSIC_POS=$(($MUSIC_POS + 1))
            MUSIC_FLAG=true
          else
            MUSIC_POS=""
          fi
        done
        ;;
      *)
        ;;
    esac ; fi

    if [ ${MUSIC_POS} ] ; then
      while [ ${MUSIC_POS} ] ; do
        MUSIC_FILE=`echo "${CON_LINE}" | grep -wE ".*\\.mid" | awk "{ print \\$$MUSIC_POS }" | sed 's/\r//'`
        if [            ${MUSIC_FILE} ] ; then
          extract_file "${MUSIC_FILE}"
          MUSIC_POS=$(($MUSIC_POS + 1))
          MUSIC_FLAG=true
        else
          MUSIC_POS=""
        fi
      done
    fi

  done
} # parse_cons()


delete_empty_folders() {
  if [  -d "${EXTRACTDIR}" ] ; then
    rm -rf  ${EXTRACTDIR}/.svn
    DIRLIST=${EXTRACTDIR}/EXTRACT_DIRECTORIES.lst
    du     "${EXTRACTDIR}" > ${DIRLIST}
    cat ${DIRLIST} | while read DIR ; do
      if [ "0" = "`echo \"${DIR}\" | grep -owE \"0\"`" ] ; then
        EMPTYDIR="`echo \"${DIR}\" | sed -r --posix s/0//`"
        if [ -d ${EMPTYDIR} ] ; then
          rmdir --parents --ignore-fail-on-non-empty ${EMPTYDIR}
        fi
      fi
    done
    rm ${DIRLIST}
  else
    warning "No ${EXTRACTDIR}."
  fi
} # delete_empty_folders()


main() {

  EXTRACTDIR=../${HRPTYPE}_extract
  [[ ${HRPTYPE} =~ (.*)(/)(.*) ]] # greedy first .* required
  if [ ${BASH_REMATCH[3]} ] ; then
    EXTRACTDIR=../${BASH_REMATCH[3]}_extract
  fi
  echo "EXTRACT :" ${HRPROOT}/${EXTRACTDIR}

  if [ $FORCE = 0 ] ; then
    if ask "Proceed?"
      then echo "Extracting ${HRPTYPE} from \"${HRPROOT}\" "
      else exit 0
    fi
  fi

  #date +%F" "%H:%M:%S

  info "Deleting ${EXTRACTDIR} ..."
  rm -rf ${EXTRACTDIR}

  info "Copying  directory tree ..."
  copy_folders

  if [ "${HRPTYPE}" = "polymost" ] || [ "${HRPTYPE}" = "polymost_override" ] ||\
    [ "${HRPTYPE}" = "megaton" ] || [ "${HRPTYPE}" = "megaton_override" ] ; then

    info "DukePlus<>Polymost HRP compatibility patch ..."
    dukeplus_polymost_hrp_compatibility $DUKEPLUS_POLYMOST_COMPATIBILTY_APPROACH

    info "Attrition<>Polymost HRP compatibility patch ..."
    attrition_polymost_hrp_compatibility $ATTRITION_POLYMOST_COMPATIBILTY_APPROACH
  fi


  if [ "${HRPTYPE}" = "polymost" ]||[ "${HRPTYPE}" = "polymost_override" ]; then
    # Some people prefer unusual setups ... 
    zip -rq9 ${EXTRACTDIR}/polymost_hrp_polymer_maphacks.zip \
    maphacks/3drealms/*.mhk
  fi

  if [ "${HRPTYPE}" = "megaton" ] || [ "${HRPTYPE}" = "megaton_override" ]; then
    info "Copying  maphacks for Megaton ..."
    copy_polymost_mhk
  fi

  info "Extract  commented items - $EXTRACT_COMMENTED_FILES"
  info "Parsing  file hierarchy :"

  if [ "${HRPTYPE}" = "megaton" ]  || [ "${HRPTYPE}" = "full" ] ; then
    parse_defs duke3d_hrp_megaton.def
  fi
  if [ "${HRPTYPE}" = "polymost" ] || [ "${HRPTYPE}" = "full" ] ; then
    parse_defs duke3d_hrp_polymost.def
  fi
  if [ "${HRPTYPE}" = "polymer" ]  || [ "${HRPTYPE}" = "full" ] ; then
    parse_defs duke3d_hrp.def
  fi
  #if [ "${HRPTYPE}" = "voxels" ]   || [ "${HRPTYPE}" = "full" ] ; then
  if [ "${HRPTYPE}" = "voxels" ] ; then
    parse_defs duke3d_voxels.def
  fi
  if [ "${HRPTYPE}" = "sw_highres" ] ; then
    parse_defs highres/sw_hrp.def
  fi
  if [ "${HRPTYPE}" = "sw_lowres" ] ; then
    parse_defs lowres/sw_lrp.def
  fi
  if [ "${HRPTYPE}" = "maphacks" ] ; then
    parse_defs maphacks/mhk-extract.def
  fi
  if [ "${HRPTYPE}" = "${DEF_TOP}" ] ; then
    parse_defs "${DEF_TOP}"
  fi
  if [ "${HRPTYPE}" = "${CON_TOP}" ] ; then
    parse_cons "${CON_TOP}"
    if [ -f        "${EXTRACTDIR}/DEF_TOP.tmp" ] ; then
      DEF_TOP=`cat "${EXTRACTDIR}/DEF_TOP.tmp"`
      rm           "${EXTRACTDIR}/DEF_TOP.tmp"
      if [ -f      "${DEF_TOP}" ] ; then
        cp -p      "${DEF_TOP}" "${EXTRACTDIR}/${DEF_TOP}"
        parse_defs "${DEF_TOP}"
      else
        warning "${DEF_TOP} is missing!"
      fi
    fi
  fi
  if [ "${HRPTYPE}" = "${GRP_TOP}" ] ; then
    GRP="${GRP_TOP}"
    #parse_grp "${GRP}"
    if hash kextract 2>/dev/null; then
      #echo "kextract ${GRP} : "
      #kextract "${GRP}" | wc -l
      #kextract "${GRP}" > "${EXTRACTDIR}/${GRP}.lst"
      mkdir    "${EXTRACTDIR}/${GRP}" || exit_on_error\
        "Could not create ${EXTRACTDIR}/${GRP}"
      cd       "${EXTRACTDIR}/${GRP}"
      kextract "${WORKDIR}/${GRP}" "GAME.CON"  > /dev/null
      kextract "${WORKDIR}/${GRP}" "EDUKE.CON" > /dev/null
      cd "${WORKDIR}"
      if [ -f    "${EXTRACTDIR}/${GRP}/EDUKE.CON" ] ; then
        CON_FILE="EDUKE.CON"
        rm -f    "${EXTRACTDIR}/${GRP}/GAME.CON"
      elif [ -f  "${EXTRACTDIR}/${GRP}/GAME.CON" ] ; then
        CON_FILE="GAME.CON"
      else
        exit_on_error "No EDUKE.CON or GAME.CON in ${GRP}!"
      fi
      parse_cons "${CON_FILE}"

    else
      exit_on_error "No 'kextract' executable found."
    fi
  fi
  if [ "${HRPTYPE}" = "auto" ] ; then

    if [ -f "duke3d.grp" ] ; then GRP="duke3d.grp" ; fi
    if [ -f "DUKE3D.GRP" ] ; then GRP="DUKE3D.GRP" ; fi
    if [ ${GRP} ] ; then
      info "Auto mode found ${GRP}"
      if hash kextract 2>/dev/null; then
        mkdir "${EXTRACTDIR}/${GRP}"
      else
        info "No 'kextract' executable found."
        GRP=""
      fi
    fi

    if [     -f "EDUKE.CON" ] || [ -f "GAME.CON" ] ; then
      if [   -f "EDUKE.CON" ] ; then
        CON_TOP="EDUKE.CON"
      else
        CON_TOP="GAME.CON"
      fi
      info "Auto mode found ${CON_TOP}"
      parse_cons "${CON_TOP}"
      if [ -f        "${EXTRACTDIR}/DEF_TOP.tmp" ] ; then
        DEF_TOP=`cat "${EXTRACTDIR}/DEF_TOP.tmp"`
        rm           "${EXTRACTDIR}/DEF_TOP.tmp"
        if [ -f      "${DEF_TOP}" ] ; then
          cp -p      "${DEF_TOP}" "${EXTRACTDIR}/${DEF_TOP}"
          parse_defs "${DEF_TOP}"
        else
          warning "${DEF_TOP} is missing!"
        fi
      elif [ -f "duke3d.def" ] ; then
        DEF_TOP="duke3d.def"
        info "Auto mode found ${DEF_TOP}"
        parse_defs "${DEF_TOP}"
      elif [ -f "dukegdx.def" ] ; then
        DEF_TOP="dukegdx.def"
        info "Auto mode found ${DEF_TOP}"
        parse_defs "${DEF_TOP}"
      fi
    elif [ -f "duke3d.def" ] ; then
      DEF_TOP="duke3d.def"
      info "Auto mode found ${DEF_TOP}"
      parse_defs "${DEF_TOP}"
    elif [ -f "dukegdx.def" ] ; then
      DEF_TOP="dukegdx.def"
      info "Auto mode found ${DEF_TOP}"
      parse_defs "${DEF_TOP}"
    else
      exit_on_error "Please report to LeoD"
    fi

  fi

  info "Copying  'known' files ..."
  copy_known_files

  info "Deleting empty directories in ${EXTRACTDIR}/ ..."
  delete_empty_folders

  #date +%F" "%H:%M:%S

  #echo "Command line example for creating a ZIP package:"
  #echo "sh -c \"cd ${EXTRACTDIR}; zip -9rqn .jpg:.png:.svn:.zip \
  #      ${EXTRACTDIR}.zip highpal highres maphacks *.def *.txt\""
} # main()



PRGPATH=$0
HRPTYPE=$1
if [ "$2" = "y" ] ; then FORCE=1 ; else FORCE=0 ; fi
if [ "$2" = "v" ] && [ ! "$3" = "" ] ; then
  VERSION="$3"
  info "${VERSION}" > VERSION
fi
HRPROOT=.
WORKDIR=`pwd`

cd              "${HRPROOT}"
echo  "PWD     : ${WORKDIR}"
echo  "HRPROOT : ${HRPROOT}"

case "$HRPTYPE" in
  polymer|polymost_override|polymost|megaton_override|megaton|maphacks)
    main $HRPTYPE
    ;;
  full)
    if [ $FORCE = 0 ] ; then if ask "Extract full HRP (+ Override Packs)?"
      then echo "Extracting ${HRPTYPE} from \"${HRPROOT}\" "
      else exit 0
    fi ; fi
    ${PRGPATH} polymost_override y
    ${PRGPATH} megaton_override  y
    FORCE=1
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
  ovr)
    ${PRGPATH} polymost_override y
    ${PRGPATH} megaton_override  y
    ;;
  all)
    if [ $FORCE = 0 ] ; then if ask "Extract all packs from the repository?"
      then echo "Extracting ${HRPTYPE} from \"${HRPROOT}\" "
      else exit 0
    fi ; fi
    ${PRGPATH} both     y
    ${PRGPATH} megaton  y
    ${PRGPATH} maphacks y
    ${PRGPATH} full     y
    ;;
  voxels)
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
  auto)
    SET_VERSION=NO
    EXTRACT_COMMENTED_FILES=NO
    if [ -f "EDUKE.CON" ] || [ -f "GAME.CON" ] || [ -f "duke3d.def" ] || [ -f "dukegdx.def" ] ; then
      main $HRPTYPE
    else
      exit_on_error "Auto mode found no suitable toplevel file (EDUKE.CON|GAME.CON|duke3d.def|dukegdx.def)."
    fi
    ;;
  unused)
    exit_on_error "Option \"$1\" not yet implemented."
    ;;
  debug)
    exit_on_error "Nothing to debug."
    ;;
  *)
    if [ -f "${HRPTYPE}" ] ; then
      SET_VERSION=NO
      EXTRACT_COMMENTED_FILES=NO
      #EXTRACT_COMMENTED_FILES=YES
      if [      "${HRPTYPE##*.}" = "def" ] ; then
        DEF_TOP="${HRPTYPE}"
      elif [    "${HRPTYPE##*.}" = "CON" ] || [ "${HRPTYPE##*.}" = "con" ]; then
        CON_TOP="${HRPTYPE}"
      elif [    "${HRPTYPE##*.}" = "GRP" ] || [ "${HRPTYPE##*.}" = "grp" ]; then
        GRP_TOP="${HRPTYPE}"
      else
        exit_on_error "Bad file type: ${HRPTYPE##*.}."
      fi
      main $HRPTYPE
    else
      echo "Usage   : ${0} {auto|TOP_CON_FILE|TOP_DEF_FILE|GRP_FILE|HRPTYPE [v VERSION]}"
      echo "HRPTYPEs: {full|ovr|all}"
      echo "HRPTYPEs: {polymer|polymost_override|polymost|both}"
      echo "HRPTYPEs: {megaton_override|megaton}"
      echo "HRPTYPEs: {maphacks|voxels}"
      echo "HRPTYPEs: {sw_highres|sw_lowres|sw_both}"
      exit 1
    fi
    ;;
esac

exit 0
