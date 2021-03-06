# What is Mosh?
Mosh is a free and fast interpreter for Scheme as specified in the R6RS.(R6RS is the latest revision of the Scheme standard)
The current release of Mosh supports all of the features R6RS.
See detailed information on http://mosh.monaos.org.

# Building and Installing Mosh
Get a release of Mosh from [Download](http://code.google.com/p/mosh-scheme/downloads/list).

    % ./configure
    % make
    % make check
    % make install

On Windows or FreeBSD platforms, see [Build](http://mosh.monaos.org/files/doc/text/Download-txt.html).

# Building the cutting-edge Mosh
## Requirements

- [Mosh 0.2.5](http://code.google.com/p/mosh-scheme/downloads/list) or higher
- [Gauche](http://practical-scheme.net/gauche/)
- [re2c](http://re2c.org/) 0.13.5 or higher
- [bison](http://www.gnu.org/software/bison/)
- [subversion](http://subversion.tigris.org/)
- [autoconf](http://www.gnu.org/software/autoconf/) 2.63 or higher
- [automake](http://www.gnu.org/software/automake/)
- [libtool](http://www.gnu.org/software/libtool/)

### auto tools
Following autotools version works.

- libtool 2.2.6b, autoconf 2.65 and automake 1.11.
- libtool 2.2.6a, autoconf 2.63 and automake 1.10.

## Building

    % git clone git://github.com/higepon/mosh.git
    % cd mosh
    % ./gen-git-build.sh
    % make
    % make check
    % make install
