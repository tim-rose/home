#!/bin/sh
. midden
require tap
require path

plan 15

test_dirs='alpha beta gamma delta epsilon'
mkdir $test_dirs
atexit "rmdir $test_dirs"

#
# filter_out_path() tests
#
ok_eq "$(filter_out_path)" '' 'no arguments'
ok_eq "$(filter_out_path alpha alpha)" '' 'identical simple dir'
ok_eq "$(filter_out_path alpha:beta alpha beta)" '' 'identical compound dir'
ok_eq "$(filter_out_path alpha alpha beta)" 'beta' 'remove first dir'
ok_eq "$(filter_out_path alpha alpha unk-beta)" '' 'non-existing directories removed'
ok_eq "$(filter_out_path alpha:beta alpha beta gamma)" 'gamma' 'path has two items'
ok_eq "$(filter_out_path alpha:beta:gamma alpha delta beta gamma epsilon)" 'delta:epsilon' 'order is preserved'

#
# prepend_path() tests
#
ok_eq "$(prepend_path alpha beta)" 'beta:alpha' 'simple dir merge'
ok_eq "$(prepend_path '' beta)"    'beta' 'empty initial path'
ok_eq "$(prepend_path alpha)"      'alpha' 'empty addition (implicit)'
ok_eq "$(prepend_path alpha '')"   'alpha' 'empty addition (explicit)'
ok_eq "$(prepend_path alpha:beta 'alpha')"   'alpha:beta' 'add existing dir is a NOP'
ok_eq "$(prepend_path alpha:beta 'beta')"   'alpha:beta' 'add existing dir is a NOP'
ok_eq "$(prepend_path alpha:beta 'beta')"   'alpha:beta' 'add existing dir is a NOP'
ok_eq "$(prepend_path alpha:beta 'gamma')"   'gamma:alpha:beta' 'add new dir'
