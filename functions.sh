#!/bin/bash

function title() {
	# colors
	RED='\033[0;31m'
	CYAN='\033[0;36m'
	NC='\033[0m' # No Color

	echo -e "${CYAN} ${1}${NC}"
	echo -e "${CYAN}================${NC}"
}

function subTitle() {
	# colors
	YELLOW='\033[0;33m'
	NC='\033[0m' # No Color

	echo -e "${YELLOW}${1}${NC}"
}
