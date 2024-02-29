#==================================================================================================
# clnwlf()
#==================================================================================================
clnwlf(){	
	#===========================================================================
	#  Colors
	#===========================================================================
	# Fades from Red to Light Green
	#for i in {196..199} {46..51} ; do echo -en "\e[48;5;${i}m \e[0m" ; done ; echo
	GRADIENT=(196 202 208 214 220 226 227 228 191 192 154 155 83 82 46 40 34)
	WHITE='15'
	#===========================================================================
	#  Functions
	#===========================================================================
	apply_gradient(){
		NC='\e[0m'
		GRAD_LEN=${#GRADIENT[@]}
		DATA_LEN=$#
		echo  "$DATA_LEN"
		DIV=$(($DATA_LEN/$GRAD_LEN))
		i=$((0))
		for arg in $@; do 
			num=${arg::-1}
			key=$((i/$DIV))
			# In Progress
			COLOR="\e[48;5;${GRADIENT[$key]}m"
			echo -e "${COLOR}$arg${NC}"
			i=$(($i+1))
		done
	}
	gen_line(){
		LINE=''
		for (( i=0; i < ($LEN+7+4+8+4+2);i++)); do
			if [[ $i -eq 0 || $i -eq 11 || i -eq 22 ]]; then
				MARKER="+"
			else
				MARKER="-"
			fi
			LINE=$(echo "${LINE}${MARKER}")
		done
		echo "$LINE+"
	}
	#===========================================================================
	#  Parameter Definitions
	#===========================================================================
	KILA=10240
	MEGA=$((1024**2))
	GIGA=$((1024**3))

	#===========================================================================
	#  Main Script
	#===========================================================================
	TOP=$(pwd| cut -d'/' -f 1-6)
	SORTED_WLFS=$(find . -name "*.wlf*" -exec ls -alS {} \;|sort -t' ' -nk5)
	DATE=$(echo "$SORTED_WLFS"|awk '{print $6" "$7}')
	export SIZE=$(echo "$SORTED_WLFS"|awk '{print $5}')
	SIZE_WITH_UNITS=""
	for num in $SIZE; do
		if [[ $num/$GIGA -gt 0 ]];then
			T=$(echo -e "scale=6;$num / $GIGA"|bc|awk '{printf("%7.2fG",$1)}')
			SIZE_WITH_UNITS=$(echo -e "${SIZE_WITH_UNITS}\n${T}")
		elif [[ $num/$MEGA -gt 0 ]];then
			T=$(echo -e "scale=6;$num / $MEGA"|bc|awk '{printf("%7.2fM",$1)}')
			SIZE_WITH_UNITS=$(echo -e "${SIZE_WITH_UNITS}\n$T")
		elif [[ $num/$KILA -gt 0 ]];then
			T=$(echo -e "scale=6;$num / $KILA"|bc|awk '{printf("%7.2fK",$1)}')
			SIZE_WITH_UNITS=$(echo -e "${SIZE_WITH_UNITS}\n${T}")
		else 
			T=$(echo "$num\n")
		fi
	done
	SIZE_WITH_UNITS=$(echo "$SIZE_WITH_UNITS"|tail -n +2)
	#apply_gradient $SIZE_WITH_UNITS
	#SIZE_WITH_UNITS=$(apply_gradient $SIZE_WITH_UNITS)
	PATHS=$(echo "$SORTED_WLFS"|awk '{print $9}')
	LEN=$(echo "$PATHS"|awk '{print length" "$1}'|sort -t' ' -nk1|awk '{print $1}'|head -n 1)
	RAW_FORMAT=$(paste  <(echo "$SIZE_WITH_UNITS") <(echo "$DATE") <(echo "$PATHS") --delimiters ' ')

	TEST=$(echo "$RAW_FORMAT"|awk  -F' ' -v g="$LEN" '{printf("| %8s | %4s %3s | %-*s |\n",$1,$2,$3,g,$4)}'|head -n -1)
	LINE=$(gen_line)
	echo -e "$LINE"
	echo -e "$TEST"
	echo -e "$LINE"

}
