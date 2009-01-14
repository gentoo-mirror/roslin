# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games subversion

ESVN_REPO_URI="http://nesemu.googlecode.com/svn/trunk/"

DESCRIPTION="A cross-platform Nintendo NES emulator targeting PCs and Consoles"
HOMEPAGE="http://code.google.com/p/nesemu/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/libpng"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i nesemu.defs \
	    -e "s/-O3 -fomit-frame-pointer -funroll-loops/${CFLAGS}/" \
	    || die "sed failed"
	    
	sed -i Makefile.linux \
	    -e "s/CFLAGS =/CFLAGS +=/" \
	    || die "sed failed"
}

src_compile() {
	emake -f Makefile.linux || die "emake failed"
}

src_install() {
	newgamesbin ${PN}.linux.elf ${PN}
	dodoc README
	
	prepgamesdirs
}
