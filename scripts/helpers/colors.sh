#!/bin/bash

Color_Black=0
Color_Red=1
Color_Green=2
Color_Yellow=3
Color_Blue=4
Color_Purple=5
Color_Cyan=6
Color_White=7
Color_Orange=172
Color_LightGreen=190

function log_info
{
    echo "$(tput setaf ${Color_Blue}) [ MESSAGE ] $(tput sgr0) $1"
}
function log_ok
{
    echo "$(tput bold)$(tput setaf ${Color_Green}) [ SUCCESS ] $(tput sgr0) $1"
}
function log_warn
{
    echo "$(tput bold)$(tput setaf ${Color_Yellow}) [ WARNING ] $(tput sgr0) $1"
}
function log_err
{
    echo "$(tput bold)$(tput setaf ${Color_Red}) [  ERROR  ] $(tput sgr0) $1"
    exit 1
}