#!/bin/sh

# Duke Nukem 3D High Resolution Pack Extractor  v0.1  2012-03-14
#
# Author: LeoD
# License: ISC license : http://opensource.org/licenses/isc-license.txt
#
# This script extracts a PolyMER or PolyMOST only HRP from your working copy of
# the Duke Nukem 3D High Resolution Pack's Subversion repository.
# Note : "//" and "/* */"-like comments in DEF files are currently ingnored and
# may lead to false warning messages or copying of actually unused files.
# On Windows you need MSYS' zip to create package files.
# ("mingw-get install msys-zip")
# MinGW/MSYS performance is horrible, better go Linux. Even my virtual Debian
# machine accessing the Windows drive is 5 to 10 times faster.
# But it still sucks. This needs to become a Perl script one day.

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


copy_known_files()
{
  cp -pv *.txt      "${EXTRACTDIR}"

  if [ "${HRPTYPE}" = "polymost" ] || [ "${HRPTYPE}" = "polymost_override" ] ; then
    cp -pv duke3d_hrp_polymost.def "${EXTRACTDIR}/duke3d_hrp.def"
  fi

  if [ "${HRPTYPE}" = "polymost" ] ; then
    cp -pv duke3d.def "${EXTRACTDIR}"
    #cp -pv duke3d_hrp_polymost.def               "${EXTRACTDIR}"
    #cp -pv highres/screen/menu/2492_polymost.png "${EXTRACTDIR}/highres/screen/menu"
  fi

  if [ "${HRPTYPE}" = "full" ] ; then
    cp -pv duke3d_hrp_polymost.def "${EXTRACTDIR}"
  fi

  if [ "${HRPTYPE}" = "polymost_override" ] || [ "${HRPTYPE}" = "full" ] ; then
    cp -pv highres/screen/menu/2492_ver_polymost.png "${EXTRACTDIR}/highres/screen/menu"
  fi

  if [ "${HRPTYPE}" = "polymer" ] || [ "${HRPTYPE}" = "full" ] ; then
    cp -pv duke3d.def                   "${EXTRACTDIR}"
    cp -pv duke3d_hrp.def               "${EXTRACTDIR}"
    echo                  "\`*.mhk' -> \`${EXTRACTDIR}/*.mhk'"
    cp -p  *.mhk                        "${EXTRACTDIR}"
    #cp -pv highres/screen/menu/2492.png "${EXTRACTDIR}/highres/screen/menu"

    #cp -pv highres/common/black.png                       "${EXTRACTDIR}/highres/common"
    #cp -pv highres/screen/fonts/digital/digital_minus.png "${EXTRACTDIR}/highres/screen/fonts/digital"
    #cp -pv highres/screen/menu/2493_old.png               "${EXTRACTDIR}/highres/screen/menu"
    #cp -pv highres/sprites/monsters/1960_reconcar_s.png   "${EXTRACTDIR}/highres/sprites/monsters"
    #cp -pv highres/sprites/props/4387.png                 "${EXTRACTDIR}/highres/sprites/props"
    #cp -pv highres/sprites/signs/4378.png                 "${EXTRACTDIR}/highres/sprites/signs"
    #cp -pv highres/sprites/signs/4379.png                 "${EXTRACTDIR}/highres/sprites/signs"
    #cp -pv highres/sprites/signs/4381.png                 "${EXTRACTDIR}/highres/sprites/signs"
    #cp -pv highres/sprites/signs/4382.png                 "${EXTRACTDIR}/highres/sprites/signs"
    #cp -pv highres/sprites/signs/4383.png                 "${EXTRACTDIR}/highres/sprites/signs"
    #cp -pv highres/sprites/signs/4384.png                 "${EXTRACTDIR}/highres/sprites/signs"
    #cp -pv highres/sprites/signs/4385.png                 "${EXTRACTDIR}/highres/sprites/signs"
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
      if [ ! "${MHK_REPLACE1}" = "" ] ; then
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


duke_plus_compatibility()
{
  echo "DukePlus compatibility patch for Polymost HRP export is not yet implemented."
} # duke_plus_compatibility()


parse_defs()
{
  echo "$1"
  cat $1 | while read DEF_LINE; do

    #DOS only: DEF_FILE=`echo "${DEF_LINE}" | grep -wE "^include" | sed s/include\ //`
    DEF_FILE=`echo "${DEF_LINE}" | grep -wE "^include" | sed s/include\ // | sed s/\\\r//`
    if [ "${DEF_FILE}" != "" ] ; then
      cp -p      "${DEF_FILE}" "${EXTRACTDIR}/${DEF_FILE}"
      parse_defs "${DEF_FILE}"
    fi

    HRP_TERM=`echo "${DEF_LINE}" | grep -owE "file|model|front|right|back|left|top|down"`

    case "$HRP_TERM" in
      file)
        #HRP_FILE=`echo "${DEF_LINE}" | sed -r s/^.*file\ *\"//g | sed s/\".*//`
        # Mastering the backslash :-) ... hm, no big performance gain ... :
        HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*file\\ *\"\\)\\([^\"]*\\)\\(.*\\)/\\\2/`
        # Ignore comments WIP:
        #HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*file\\ *\\)\\(\\"\\(.*\\)\\"\\)\\(.*\\)/\\\3/`
        ;;
      model)
        HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*model\\ *\"\\)\\([^\"]*\\)\\(.*\\)/\\\2/`
        ;;
      front|right|back|left|top|down)
        #HRP_FILE=`echo "${DEF_LINE}" | sed -r s/^.*${HRP_TERM}\ *\"//g | sed s/\".*//`
        HRP_FILE=`echo "${DEF_LINE}" | sed -r --posix s/\\(^.*${HRP_TERM}\\ *\"\\)\\([^\"]*\\)\\(.*\\)/\\\2/`
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

    #echo "### Duke Plus compatibility patch ... ###"
    #duke_plus_compatibility
  fi

  echo "### Parsing DEF file hierarchy ... ###"
  if [ "${HRPTYPE}" = "polymost" ] || [ "${HRPTYPE}" = "full" ] ; then
    parse_defs duke3d_hrp_polymost.def
  fi
  if [ "${HRPTYPE}" = "polymer" ] || [ "${HRPTYPE}" = "full" ] ; then
    parse_defs duke3d_hrp.def
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
HRPROOT=.

cd               "${HRPROOT}"
echo  "PWD     :" `pwd`
echo  "HRPROOT :" ${HRPROOT}

if [ ! -f "./duke3d.def" ] ; then
  echo "ERROR : ./duke3d.def not found. This is no HRP root directory. Exit."
  exit 1
fi

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
  unused)
    echo "Option \"$1\" not yet implemented."
    ##(cd ${1}; tar cf - . ) | (cd ${2}; tar xf -)
    ;;
  debug)
    echo "Nothing to debug."
    ;;
  *)
    echo "Usage: ${0} {full|polymer|polymost_override|polymost|both|all}"
    exit 1
    ;;
esac

exit 0
