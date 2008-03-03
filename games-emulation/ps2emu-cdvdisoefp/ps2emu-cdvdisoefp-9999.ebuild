# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-cdvdiso/ps2emu-cdvdiso-0.5.ebuild,v 1.5 2007/04/06 19:53:05 nyhm Exp $

inherit subversion games

ESVN_REPO_URI="https://pcsx2.svn.sourceforge.net/svnroot/pcsx2/plugins/cdvd/CDVDisoEFP"

DESCRIPTION="PS2Emu ISO CDVD EFP plugin"
HOMEPAGE="http://www.pcsx2.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-arch/bzip2
	sys-libs/zlib
	>=x11-libs/gtk+-2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/CDVDisoEFP"

src_unpack() {
	subversion_src_unpack
	cd "${S}/src/Linux"

	sed -i \
		-e '/^CC =/d' \
		-e '/\bstrip\b/d' \
		-e 's/-g\b//g' \
		-e 's/-fPIC/$(CFLAGS) -fPIC/' \
		Makefile || die
}

src_compile() {
	cd "${S}/src/Linux"
	emake || die
}

src_install() {
	cd "${S}/src/Linux"
	exeinto "`games_get_libdir`/ps2emu/plugins"
	newexe libCDVDisoEFP.so libCDVDisoEFP.so.${PV} || die
	exeinto "`games_get_libdir`/ps2emu/plugins/cfg"
	doexe cfgCDVDisoEFP || die
	dodoc ../../readme.txt || die
	prepgamesdirs
}
