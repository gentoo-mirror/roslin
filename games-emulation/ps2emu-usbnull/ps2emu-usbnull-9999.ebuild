# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games subversion

ESVN_REPO_URI="https://pcsx2.svn.sourceforge.net/svnroot/pcsx2/plugins/usb/USBnull"

DESCRIPTION="PS2Emu null USB plugin"
HOMEPAGE="http://www.pcsx2.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=x11-libs/gtk+-2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/USBnull"

src_unpack() {
	subversion_src_unpack
	cd "${S}/Linux"

	sed -i \
		-e '/^CC =/d' \
		-e '/\bstrip\b/d' \
		-e 's/-O[0-9]\b//g' \
		-e 's/-fomit-frame-pointer\b//g' \
		Makefile || die
}

src_compile() {
	cd "${S}/Linux"
	emake || die "emake failed"
}

src_install() {
	cd "${S}/Linux"
	exeinto "`games_get_libdir`/ps2emu/plugins"
	newexe libUSBnull.so libUSBnull.so.${PV} || die
	exeinto "`games_get_libdir`/ps2emu/plugins/cfg"
	doexe cfgUSBnull || die
	dodoc ../ReadMe.txt || die
	prepgamesdirs
}
