# Home is Where the Cruft is

This is the source repository for my various rc and config files, and
some custom scripts.

## Prerequisites
### Devkit

The files in here are *not* simply cloned into the HOME directory,
they're installed via **make**(1), using the macros defined
in [devkit](git@github.com:tim-rose/devkit.git), so you'll have to get
and install that first.

### Adminkit

Most of the scripts in this directory rely on libraries of shell
functions provided by *another* repository:
[adminkit](git@github.com:tim-rose/adminkit.git). 
