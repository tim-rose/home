#!/bin/sh
#
# Adjust the way Apple's font smoothing works...
#
#defaults -currentHost read -globalDomain AppleFontSmoothing
defaults -currentHost write -globalDomain AppleFontSmoothing -int ${1:-1}
