## gnucash [![Build Status](https://travis-ci.org/eikef/perl6-gnucash.svg?branch=master)](https://travis-ci.org/eikef/perl6-gnucash)

gnucash is a set of Perl 6 bindings to the gnucash engine / library / API. It is in development and by no means complete. 

## Limitations

Currently this is only tested on Linux. Unfortunately finding the correct path for the required libraries is hard to implement reliably, so
this currently requires a correctly-set LD_LIBRARY_PATH. Examples are noted below with the prerequisites.

*This module is in development. Do not use it for anything important*

## Prerequisites

[Gnucash](https://www.gnucash.org/)

### Debian/Ubuntu Linux

```
sudo apt-get install gnucash
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/gnucash/gnucash
```

### Fedora

```
dnf install gnucash
export LD_LIBRARY_PATH=/usr/lib64/gnucash
```

### ARch
```
pacman -Sy gnucash
export LD_LIBRARY_PATH=/usr/lib64/gnucash
```

## Installation

Since this module has not been submitted to any Perl 6 repository yet, a complete path is required

```
panda install git://github.com/eikef/perl6-gnucash.git
```
