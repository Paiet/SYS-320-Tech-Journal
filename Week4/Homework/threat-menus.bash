#!/bin/bash

#Description: Menu for putting all of the parsing threat tools together

while getopts 'MLUWH:' OPTION ; do

	case "$OPTION" in


			M) mac_fw=${OPTION}
			;;
			L) linux_fw=${OPTION}
			;;
			U) url_parsing=${OPTION}
			;;
			W) windows_parsing=${OPTION}
			;;
			H)

				echo ""
				echo "Usage:-M for Mac fw parsing  -L for Linux fw parsing -W for Windows fw parsing and  -U for url parsing"
				echo ""
				exit 1

			;;
			*)

				echo "Invalid value press H for help"
				exit 1

																																							;;

																															
	esac

																																done


# Check to see if a selection was made

if [[ (${mac_fw} == "" && ${linux_fw} == "" && ${url_parsing}  == "" &&  ${windows_parsing} == "") ]]

then

	echo "Please specify an option pres H for options"

fi

# calling the bash scripts for each option

if [[ ${mac_fw} ]]
then

	bash parse-threat-mac.bash
	exit 0
fi


if [[ ${linux_fw} ]]
then

	bash parse-threat-linux.bash
	exit 0

fi

if [[ ${url_parsing} ]]
then

	bash url-parse.bash
	exit 0

fi


if [[ ${windows-parsing} ]]
then

	bash parse-threat-windows.bash
	exit 0
fi
