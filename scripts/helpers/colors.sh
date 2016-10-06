#!/bin/bash

Color_Black='\033[0;30m'
Color_Red='\033[0;31m'
Color_Green='\033[0;32m'
Color_Orange='\033[0;33m'
Color_Blue='\033[0;34m'
Color_Purple='\033[0;35m'
Color_Cyan='\033[0;36m'
Color_LightGray='\033[0;37m'
Color_DarkGray='\033[1;30m'
Color_LightRed='\033[1;31m'
Color_LightGreen='\033[1;32m'
Color_Yellow='\033[1;33m'
Color_LightBlue='\033[1;34m'
Color_LightPurple='\033[1;35m'
Color_LightCyan='\033[1;36m'
Color_White='\033[1;37m'
Color_Reset='\033[0m'

function message
{
    printf  "%b" "${2}$1\e[0m\n"
}
