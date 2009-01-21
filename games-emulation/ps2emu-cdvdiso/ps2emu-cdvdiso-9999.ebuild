# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion games

ESVN_REPO_URI="https://pcsx2.svn.sourceforge.net/svnroot/pcsx2/plugins/cdvd/CDVDiso"

DESCRIPTION="PS2Emu ISO CDVD plugin"
HOMEPAGE="http://www.pcsx2.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-arch/bzip2
	sys-libs/zlib
	>=x11-libs/gtk+-2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/CDVDiso"

src_unpack() {
	subversion_src_unpack
	cd "${S}/src/Linux"

	sed -i \
		-e 's/CFLAGS =/CFLAGS +=/' \
		-e '/^CC =/d' \
		-e '/\bstrip\b/d' \
		-e 's/-g\b//g' \
		Makefile || die
}

src_compile() {
	cd "${S}/src/Linux"
	emake || die
}

src_install() {
	cd "${S}/src/Linux"
	exeinto "`games_get_libdir`/ps2emu/plugins"
	newexe libCDVDiso.so libCDVDiso.so.${PV} || die
	exeinto "`games_get_libdir`/ps2emu/plugins/cfg"
	doexe cfgCDVDiso || die
	dodoc ../../ReadMe.txt || die
	prepgamesdirs
}
