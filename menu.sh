#!/bin/bash

declare -rg btkRed='\e[1;37;41m\e[K'
declare -rg btkGre='\e[1;37;42m\e[K'
declare -rg btkYel='\e[1;37;43m\e[K'
declare -rg btkBlu='\e[1;37;44m\e[K'
declare -rg btkPur='\e[1;37;45m\e[K'
declare -rg btkCya='\e[1;37;46m\e[K'
declare -rg btkLtRed='\e[1;37;101m\e[K'
declare -rg btkLtGre='\e[1;37;102m\e[K'
declare -rg btkLtYel='\e[1;37;103m\e[K'
declare -rg btkLtBlu='\e[1;37;104m\e[K'
declare -rg btkLtPur='\e[1;37;105m\e[K'
declare -rg btkLtCya='\e[1;37;106m\e[K'
declare -rg btkRes='\e[0m'
declare -rg btkRev='\e[1;7m\e[K'
declare -rg btkReturn='\n\e[K'

BTKexit(){
  local reason=${1:-Exiting as per your request.}
  echo -e "\n${btkRed} ${reason}${btkRes}\n"
  exit
}

declare -ag btkMenuOptions

BTKmenu(){
  local doConfirm=${1:-"y"}
  local heading=${2:-"Menu Heading"}
  local prompt=${3:-"Press a letter to choose: "}
  while true; do
clear
echo -e "${btkPur} Bash Menu${btkRes}"
  echo -e "${btkCya} ${heading}${btkRes}"
  chars=( {a..p} {r..w} {y..z} )
  menuChars=()
  for i in "${!btkMenuOptions[@]}"; do
    echo -e "${btkRev} ["${chars[i]}"] - ${btkMenuOptions[$i]}${btkRes}"
    menuChars+=("${chars[i]}")
  done
menuChars+=('q' 'x')
echo -e "${btkRev} [q] - Quit this Menu${btkRes}"
echo -e "${btkRev} [x] - Exit this Script${btkRes}"
  echo -e "${btkCya} ${prompt}${btkRes}"
  echo -e "${btkPur} ${btkRes}"
read -n1 -s menuAnswer
local count=0
for i in "${menuChars[@]}"; do
    if [ "$i" == "${menuAnswer}" ] ; then
      [[ "$i" == 'x' ]] && BTKexit
      [[ "$i" == 'q' ]] && return
      if [[ $doConfirm == 'y' ]]; then
        echo -e "${btkGre} You chose ${btkRes} ${btkMenuOptions[$count]} ${btkGre}, is this correct (y or
 n)${btkRes}"
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
    a) echo 'You picked A';;
    b) echo 'You picked B';;
    c|q) echo 'You did not choose a) or b)'; break;;
  esac
done