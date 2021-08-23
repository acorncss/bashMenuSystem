#!/bin/bash

##########################
# Name: bashMenuSystem
# Version: 0.1
# Info: https://github.com/acorncss/bashMenuSyste
# Donate: https://www.paypal.com/donate?hosted_button_id=P8USAAG7U2T28
##########################

declare -rg btkRed='\e[1;37;41m\e[K'
declare -rg btkGre='\e[1;37;42m\e[K'
declare -rg btkYel='\e[1;37;43m\e[K'
declare -rg btkBlu='\e[1;37;44m\e[K'
declare -rg btkRes='\e[0m'
declare -rg btkRev='\e[1;7m\e[K'

declare -rg btkPur='\e[1;37;45m\e[K'
declare -rg btkCya='\e[1;37;46m\e[K'
declare -ag btkMenuOptions

BTKpause(){
  echo -e "${btkBlu}Check above lines. Press any key to Clear & Continue.${btkRes}"
  read -n 1 -s
  clear
  echo "Continuing..."
}

function BTKeasyMenu(){
  local gotit='n'
  until [[ $gotit == 'y' ]]; do
    clear
    BTKmakeMenu "$1" "$2"
    read -n 1 -s answer
    [[ $answer -lt ${#btkMenuOptions[@]} ]] && [[ $answer != '' ]] && gotit='y'
  done
  btkAnswer="${btkMenuOptions[$answer]}"
  echo -e "${btkRev}You have chosen $btkAnswer.${btkRes}\n"
}

function BTKmakeMenu(){
	local heading=${1:-"Menu Heading"}
	local prompt=${2:-"Type a number or press enter key to quit."}
	echo -e "${btkPur} Bash Menu System${btkRes}"
	echo -e "${btkCya} ${heading}${btkRes}"
	for i in "${!btkMenuOptions[@]}"; do
    echo -e "${btkRev} ["$i"] - ${btkMenuOptions[$i]}${btkRes}"
  done
  echo -e "${btkCya} ${prompt}${btkRes}"
	echo -e "${btkPur} ${btkRes}"
}

# END of Menu functions the code below is examples.

function mainMenu(){
  btkSelection="x"
  clear
  until [ "$btkSelection" == "" ]; do
    btkMenuOptions=( 'Server Setup' 'User Setup')
    BTKmakeMenu 'MAIN MENU'
    read -n 1 -s btkSelection
    case $btkSelection in
      0 ) setupMenu ;;
      1 ) userMenu ;;
    esac
  done
  btkSelection="x"
  clear
}

function setupMenu(){
  clear
  until [ "$btkSelection" == "" ]; do
    btkMenuOptions=( 'Basic Server Setup' 'Nginx Setup' 'Postfix Setup' )
    BTKmakeMenu 'SETUP MENU'
    read -n 1 -s btkSelection
    case $btkSelection in
      0 ) ./basicServerSetup.sh ;;
      1 ) ./nginxSetup.sh ;;
      2 ) ./postfixSetup.sh
    esac
  done
  btkSelection="x"
  clear
}

function userMenu(){
  clear
  until [ "$btkSelection" == "" ]; do
    btkMenuOptions=( 'Add system user' 'Add Nginx user' 'Add Postfix User')
    BTKmakeMenu 'SETUP MENU'
    read -n 1 -s btkSelection
    case $btkSelection in
      0 ) ./basicServerSetup.sh ;;
      1 ) ./nginxSetup.sh ;;
      2 ) ./postfixSetup.sh
    esac
  done
  btkSelection="x"
  clear
}

echo "Lets get our user to select from timezones we support."
BTKpause
btkMenuOptions=( 'Australia/Sydney' 'Australia/Brisbane' 'Australia/Melbourne' 'Australia/Perth' 'Australia/Adelaide' 'Australia/Canberra' 'Australia/Darwin' )
BTKeasyMenu 'Select a timezone from the list below...' 'Type in a number: '
echo "That was our Menu that only allowed you to choose from the available options and not quit."
echo "The next menu is a chaining menu, quit to go back to previous menu."
BTKpause
mainMenu
