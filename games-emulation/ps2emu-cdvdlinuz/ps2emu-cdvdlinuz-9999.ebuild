# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games subversion

ESVN_REPO_URI="https://pcsx2.svn.sourceforge.net/svnroot/pcsx2/plugins/cdvd/CDVDlinuz"

DESCRIPTION="PS2Emu CDVD plugin"
HOMEPAGE="http://www.pcsx2.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-arch/bzip2
	sys-libs/zlib
	>=x11-libs/gtk+-2"
RDEPEND="${DEPEND}"

S=${WORKDIR}/CDVDlinuz

src_unpack() {
	subversion_src_unpack
	cd "${S}/Src/Linux"

	sed -i \
		-e '/^CC =/d' \
		-e '/\bstrip\b/d' \
		-e 's/-O[0-9]\b//g' \
		-e 's/-fomit-frame-pointer\b//g' \
		-e 's/-fPIC/$(CFLAGS) -fPIC/g' \
		Makefile || die
}

src_compile() {
	cd "${S}/Src/Linux"
	emake || die "emake failed"
}

src_install() {
	cd "${S}/Src/Linux"
	exeinto "`games_get_libdir`/ps2emu/plugins"
	newexe libCDVDlinuz.so libCDVDlinuz.so.${PV} || die
	exeinto "`games_get_libdir`/ps2emu/plugins/cfg"
	doexe cfgCDVDlinuz || die
	dodoc ../../readme.txt ../../ChangeLog.txt || die
	prepgamesdirs
}
