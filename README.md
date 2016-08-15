## gnucash [![Build Status](https://travis-ci.org/eikef/perl6-gnucash.svg?branch=master)](https://travis-ci.org/eikef/perl6-gnucash)

gnucash is a set of Perl 6 bindings to the gnucash engine / library / API. It is in development and by no means complete. 

## Limitations

Currently this is only tested on Linux and will fail on Windows while finding the correct library path. On Linux it will fail if the Gnucash libraries are not installed
in /usr/lib64/gnucash. 

*This module is in development. Do not use it for anything important*

## Prerequisites

[Gnucash](https://www.gnucash.org/)

### Debian/Ubuntu Linux

```
sudo apt-get install gnucash
```

### Fedora

```
dnf install gnucash
```

## Installation

Since this module has not been submitted to any Perl 6 repository yet, a complete path is required

```
panda install git://github.com/eikef/perl6-gnucash.git
```

