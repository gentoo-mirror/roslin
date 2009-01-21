# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games subversion

ESVN_REPO_URI="https://pcsx2.svn.sourceforge.net/svnroot/pcsx2/plugins/dev9/dev9null"

DESCRIPTION="PS2Emu null DEV9 plugin"
HOMEPAGE="http://www.pcsx2.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/dev9null"

src_unpack() {
	subversion_src_unpack

	cd "${S}/src"
	sed -i \
		-e '/^CC =/d' \
		-e '/\bstrip\b/d' \
		-e 's/-O[0-9]\b//g' \
		-e 's/-fomit-frame-pointer\b//g' \
		Makefile || die
}

src_compile() {
	cd "${S}/src"
	emake || die
}

src_install() {
	cd "${S}/src"
	exeinto "`games_get_libdir`/ps2emu/plugins"
	newexe libDEV9null.so libDEV9null.so.${PV} || die
	dodoc ../ReadMe.txt || die
	prepgamesdirs
}
