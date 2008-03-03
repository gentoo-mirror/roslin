# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games subversion

ESVN_REPO_URI="https://pcsx2.svn.sourceforge.net/svnroot/pcsx2/plugins/cdvd/CDVDnull"

DESCRIPTION="PS2Emu null CDVD plugin"
HOMEPAGE="http://www.pcsx2.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/CDVDnull"

src_unpack() {
	subversion_src_unpack
	cd "${S}/Src"
	
	sed -i \
		-e '/^CC =/d' \
		-e '/\${STRIP}/d' \
		-e 's/-O[0-9]\b//g' \
		-e 's/-fomit-frame-pointer\b//g' \
		-e 's/-ffast-math\b//g' \
		-e "s/^OPTIMIZE = /OPTIMIZE = ${CFLAGS} /" \
		Makefile || die
}

src_compile() {
	cd "${S}/Src"
	emake || die "emake failed"
}

src_install() {
	cd "${S}/Src"
	exeinto "`games_get_libdir`/ps2emu/plugins"
	newexe libCDVDnull.so libCDVDnull.so.${PV} || die
	dodoc ../ReadMe.txt || die
	prepgamesdirs
}
