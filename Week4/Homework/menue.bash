#!/bin/bash

# Description: Menu for Admins, VPN and Sec functions

function invalid_opt() {
  echo ""
  echo "Invalid option"
  echo ""
  sleep 2
  
}
function menu() {

# clears the screen
	clear

	echo "[1] Admin Menu"
	echo "[2] Sec Menu "
	echo "[3] Threat Menu "
	echo "[4] Exit"
	read -p "Please pick by number: " choice

	case "$choice" in

		1) admin_menu
		;;

		2) security_menu
		;;

		3) threat_menu
		;;

		4) exit 0

		;;

		*)
			invalid_opt
			#calls the main menu
			menu
		;;

	esac
}


function admin_menu() {

	clear
	echo "[L]ist Running Procces"
	echo "[N]etwork Socketes "
	echo "[V] PN Menu"
	echo "[X] Exit"
	read -p "Please pick an option: " choice

	case "$choice" in

		L|l) ps -ef |less
		;;
		N|n) netstat -an --inet |less
		;;
		V|v) vpn_menu
		;;
		X|x) exit 0
		;;

		*)
			invalid_opt

			admin_menu
		;;


	esac

admin_menu
}


function vpn_menu() {

	clear
	echo "[A]dd a user conf"
	echo "[D]elete a peer"
	echo "[B]ack to admin menu"
	echo "[C]heck if user exists"
	echo "[X] Exit"
	read -p "Please pick an option: " choice

	case "$choice" in

		A|a)

		 bash peer.bash
		 tail -6 wg0.conf |less

		;;
		D|d)

		#	clear

			# Create a prompt  for the user
			echo -n "Please enter the user you wish to delete:"
			read t_user
			# Calling the arguement and entering the variable for the user

			echo ${t_user}

			bash manage-users.bash -d -u "${t_user}"


		;;
		B|b) admin_menu
		;;
		M|m) menu
		;;
		C|c)

		  echo -n "What user are you looking for?"
		  read user

		  if grep -q "$user" wg0.conf
		  then
		  # if user is found
		  echo "This user already exists"
		  else
		  # if the user is not found
		  echo "This user does not exist"
		  fi

		  # Timer so that it actually shows the result
		  sleep 2


		;;
		X|x) exit 0
		;;
		*)
			invalid_opt

		;;

	esac
vpn_menu
}

# function for security menu


function security_menu() {

	clear

	echo "[O]pen sockets"
	echo "[L]ogged in users"
	echo "[H]istory of the last 10 users"
	echo "[C]heck users with UID of 0"
	echo "[X] Exit"
	read -p "Please select an option: " choice

	case "$choice" in

		# all of these are commands associated with the menu
		O|o)

			ss -nutlp | less

		;;
		L|l)

			who | less

		;;
		H|h)

			last -10 | less

		;;
		C|c)

			grep 'x:0:' /etc/passwd | less

		;;
		X|x)exit 0
		;;

		*)

			invalid_opt

		;;

	esac
security_menu
}

# Creating threat menu and using the bash add ons for the selection

function threat_menu() {

	clear

	echo "[M]ac blocklist generator"
	echo "[L]inux blocklist generator"
	echo "[W]indows blocklist generator"
	echo "[U}rl blocklist generator"
	echo "[X] Exit"
	read -p "Please ouck and otion: " choice
	
	case "$choice" in

		M|m)

			bash threat-menu.bash -M
			sleep 3
		;;

		L|l)

			bash threat-menu.bash -L
			sleep 3
		;;

		W|w)

			bash threat-menu.bash -W
			sleep 3
		;;

		U|u)

			bash threat-menu.bash -U
			sleep 3
		;;

		X|x)
			 exit 0
		;;

		*)
			invalid_opt

		;;

	esac

menu
}

# Calling menu function

menu
