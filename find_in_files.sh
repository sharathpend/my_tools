#!/bin/sh

# Author: Sharath Pendyala - sharathpawan@gmail.com

MYNAME='~/my_tools/find_in_file.sh'  # Short program name for diagnostic messages.
VERSION='1.3'
LAST_CHANGE='2024_05_22'
# Includes support for -i -e -f -l -a -b
# Help and debug using -h -d -v -V

# Ver 1.1:  added -w for whole word enable/disable.
#           added -c for case sensitive/insensitive.
#           added --color in egrep

# Ver 1.2:  Fix for -i and -e for single and multiple calls.
#           Wildcard at the end of -i

# Ver 1.3:  Added -I for wildcard after arg.
#           Reverted -i to no wildcard after arg.

INCL_DEF='\*'
EXCL_DEF='\*'
TO_INCL=0
INCL_CNT=0
TO_EXCL=0
EXCL_CNT=0
INC_VAL=1
TO_FIND=0

OPT_VERBOSE=0
OPT_INCL=$INCL_DEF
OPT_INCL=$EXCL_DEF
OPT_SEARCH='-Rn'
OPT_LOC="'./'"
OPT_AFT=0
OPT_BEF=0
OPT_DEBUG=0

usage () {
  cat << EOF

Function: Find in files.
Usage   : $MYNAME [-hdvV] [-f arg] ...
Usage   : $MYNAME [-hdvV] [-cw] [-f arg] ...

Options:
  -i arg   include filetype as --include=\*arg (default = *)
  -I arg   include filetype as --include=\*arg* (default = *)
  -e arg   exclude filetype as --exclude=\*{arg1,arg2,...,argn} (default = no exclude)
  -f arg   find string 'arg' (required)
  -l arg   find at location 'arg' (default = ./)
  -a arg   display 'arg' lines before match (default = 0)
  -b arg   display 'arg' lines after match (default = 0)
  -w       Enable whole-word match. Default = Disable whole-word match.
  -c       Enable case-insensitive search. Default = case-sensitive search.
  -h       display this help text and exit
  -d       my debug
  -v       verbose mode
  -V       display version and exit

EOF
  exit $1
}

version () {
  cat << EOF

Find in File script Version: $VERSION
Last Changed on $LAST_CHANGE

EOF
  exit $1
}

parse_options () {
    while getopts i:I:e:f:l:a:b:wchdvV opt; do
        case $opt in
            (i) CUR_INCL=$OPTARG
                INCL_CNT=$(($INCL_CNT + $INC_VAL))
                if [ $INCL_CNT = 1 ]
                then
                    TO_INCL=1
                    PREV_INCL=$CUR_INCL
                    OPT_INCL="$INCL_DEF$CUR_INCL"
                elif [ $INCL_CNT = 2 ]
                then
                    OPT_INCL="$INCL_DEF{$PREV_INCL,$CUR_INCL}"
                else
                    OPT_INCL="${OPT_INCL::-1},$CUR_INCL}"
                fi;;
            (I) CUR_INCL=$OPTARG
                INCL_CNT=$(($INCL_CNT + $INC_VAL))
                if [ $INCL_CNT = 1 ]
                then
                    TO_INCL=1
                    PREV_INCL=$CUR_INCL
                    OPT_INCL="$INCL_DEF$CUR_INCL*"
                elif [ $INCL_CNT = 2 ]
                then
                    OPT_INCL="$INCL_DEF{$PREV_INCL,$CUR_INCL*}"
                else
                    OPT_INCL="${OPT_INCL::-1},$CUR_INCL*}"
                fi;;
            (e) CUR_EXCL=$OPTARG
                EXCL_CNT=$(($EXCL_CNT + $INC_VAL))
                if [ $EXCL_CNT = 1 ]
                then
                    TO_EXCL=1
                    PREV_EXCL=$CUR_EXCL
                    OPT_EXCL="$EXCL_DEF$CUR_EXCL"
                elif [ $EXCL_CNT = 2 ]
                then
                    OPT_EXCL="$EXCL_DEF{$PREV_EXCL,$CUR_EXCL}"
                else
                    OPT_EXCL="${OPT_EXCL::-1},$CUR_EXCL}"
                fi;;
            (f) OPT_PRE_FIND=$OPTARG
                OPT_FIND="\"$OPT_PRE_FIND\""
                TO_FIND=1;;
            (l) OPT_PRE_LOC=$OPTARG
                OPT_LOC="'$OPT_PRE_LOC'";;
            (a) OPT_AFT=$OPTARG;;
            (b) OPT_BEF=$OPTARG;;
            (w) OPT_SEARCH="${OPT_SEARCH}w";;
            (c) OPT_SEARCH="${OPT_SEARCH}i";;
            (h) usage 0;;
            (d) OPT_DEBUG=1;;
            (v) OPT_VERBOSE=1;;
            (V) version 0;;
            (?) echo ""
                echo "Undefined option"
                usage 1;;
        esac
    done
}

parse_options "$@"
shift $((OPTIND - 1))   # Shift away options and option args.

if [ $TO_FIND = 1 ]
then
    if [ $TO_EXCL = 1 ]
    then
        CMD_TO_SEND="egrep --color -A $OPT_AFT -B $OPT_BEF --include=$OPT_INCL --exclude=$OPT_EXCL $OPT_SEARCH $OPT_LOC -e $OPT_FIND"
        if [ $OPT_DEBUG = 1 ]
        then
            echo $CMD_TO_SEND
        else
            if [ $OPT_VERBOSE = 1 ]
            then
                echo "About to send the command"
            fi
            echo "$CMD_TO_SEND" | bash
        fi
    else
        CMD_TO_SEND="egrep --color -A $OPT_AFT -B $OPT_BEF --include=$OPT_INCL $OPT_SEARCH $OPT_LOC -e $OPT_FIND"
        if [ $OPT_DEBUG = 1 ]
        then
            echo $CMD_TO_SEND
        else
            if [ $OPT_VERBOSE = 1 ]
            then
                echo "About to send the command"
            fi
            echo "$CMD_TO_SEND" | bash
        fi
    fi
else
    echo "Please specify -f argument (string to find). -h for script usage."
    usage 1
fi

