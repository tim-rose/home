#!/bin/sh
#
# COLORTEST --Print terminal colour information as a test-pattern of swatches.
#
. midden
require log
require getopt

opts="c.colors=8;$LOG_GETOPTS"

usage() { getopt_usage "colortest [-c colors]" "$1"; }

eval $(getopt_long_args -d "$opts" "$@" || usage "$opts" >&2 && exit 0)
log_getopts

debug 'colors=%d' $colors

colorise_8()
{
    local fg=$1 bg=$2 fmt=$3 label=$4

    printf "\033[%d;%dm" "$fg" "$bg"
    printf "$fmt" "$label"
    printf  "\033[m"
}
colorise_256()
{
    local fg=$1 bg=$2 fmt=$3 label=$4

    printf "\033[38;05;%d;48;05;%dm" "$fg" "$bg"
    printf "$fmt" "$label"
    printf  "\033[m"
}

swatch_8()
{
    for colour in $(seq 0 9); do
	colorise_8 37 "$colour" " %03d " "$colour"
    done
    echo ''
    for colour in $(seq 0 9); do
	colorise_8 37 $((40 + colour)) " %03d " "$colour"
    done
    echo ''
}

#
# for 256 colors, the escape sequence is:
# * foreground: \033[38;05;<colour>m
# * background: \033[48;05;<colour>m
#
swatch_256()
{
    for colour in $(seq 0 7); do
	colorise_256 7 "$colour" " %03d " "$colour"
    done
    echo ''
    for colour in $(seq 8 15); do
	colorise_256 0 "$colour" " %03d " "$colour"
    done
    echo ''
    for row in $(seq 0 35); do
	for column in $(seq 0 5); do
	    colour=$(( row*6 + column + 16))
	    colorise_256 7 "$colour" " %03d " "$colour"
	done
	echo ''
    done
    for row in $(seq 0 1); do
	for column in $(seq 0 11); do
	    colour=$(( row*12 + column + 232))
	    colorise_256 7 "$colour" " %03d " "$colour"
	done
	echo ''
    done
}

#
# main...
#
echo "8-color modes:"
swatch_8

if [ "$(tput colors)" = "256" ]; then
    echo "256-color modes:"
    swatch_256
fi
