#!/bin/sh
#
# GIT-HIST --Customised version of git log that shows a colourful graph.
#
git log --graph \
      --pretty='format:%C(bold)%h%d%Creset %ar %Cgreen%an%Creset %s'  "$@";
