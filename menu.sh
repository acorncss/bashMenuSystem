#!/bin/bash

declare -rg btkRedBg='\e[1;37;41m\e[K'
declare -rg btkGreBg='\e[0;30;42m\e[K'
declare -rg btkYelBg='\e[0;30;43m\e[K'
declare -rg btkBluBg='\e[1;37;44m\e[K'
declare -rg btkPurBg='\e[1;37;45m\e[K'
declare -rg btkCyaBg='\e[0;30;46m\e[K'
declare -rg btkRedFg='\e[1;31m'
declare -rg btkGreFg='\e[1;32m'
declare -rg btkYelFg='\e[1;33m'
declare -rg btkBluFg='\e[1;34m'
declare -rg btkPurFg='\e[1;35m'
declare -rg btkCyaFg='\e[1;36m'
declare -rg btkReset='\e[0m'
declare -rg btkReverse='\e[1;7m\e[K'
declare -rg btkReturn='\n\e[K'

BTKexit(){
  local reason=${1:-Exiting as per your request.}
  echo -e "\n${btkRedBg} ${reason}${btkReset}\n"
  exit
}

declare -ag btkMenuOptions

BTKmenu(){
  local doConfirm=${1:-"y"}
  local heading=${2:-"Menu Heading"}
  local prompt=${3:-"Type the letter of your choice:"}
  while true; do
    clear
    echo -e "${btkCyaBg} ${heading}${btkReset}"
    local chars=( {a..p} {r..w} {y..z} )
    local menuChars=()
    for i in "${!btkMenuOptions[@]}"; do
      echo -e "${btkGreFg} ["${chars[i]}"] ${btkCyaFg}${btkMenuOptions[$i]}${btkReset}"
      menuChars+=("${chars[i]}")
    done
    menuChars+=('q' 'x')
    echo -e "${btkGreFg} [q] ${btkCyaFg}Quit this Menu${btkReset}"
    echo -e "${btkGreFg} [x] ${btkCyaFg}Exit this Script${btkResert}"
    echo -e "${btkCyaBg} ${prompt}${btkReset}"
    read -n1 -s btkMenuAnswer
    local count=0
    for i in "${menuChars[@]}"; do
      if [ "$i" == "${btkMenuAnswer}" ] ; then
        [[ "$i" == 'x' ]] && BTKexit
        [[ "$i" == 'q' ]] && return
        if [[ $doConfirm == 'y' ]]; then
          echo -e "${btkCyaFg}You chose\n${btkGreFg} ${btkMenuOptions[$count]}\n${btkCyaFg}Is this correct (y|n)?${btkReset}"
          read -n1 -s confirm
          [[ $confirm == 'y' ]] && return
        else
        return
      fi
    fi
    ((count++))
    done
  done
}

while true; do
  btkMenuOptions=('Paste SSH public key into terminal' 'Create SSH Keypair on server' 'I will do it manually later.')
  BTKmenu
  case $btkMenuAnswer in
    a) echo 'You picked A'; break;;
    b) echo 'You picked B'; break;;
    c|q) echo 'You did not choose a) or b)'; break;;
  esac
done