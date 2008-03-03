# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-cddvdlinuz/ps2emu-cddvdlinuz-0.3-r1.ebuild,v 1.7 2007/04/06 18:56:48 nyhm Exp $

inherit games subversion

ESVN_REPO_URI="https://pcsx2.svn.sourceforge.net/svnroot/pcsx2/plugins/usb/USBlinuz"

DESCRIPTION="PS2Emu USB plugin"
HOMEPAGE="http://www.pcsx2.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/CDVDlinuz

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
	exeinto "$(games_get_libdir)"/ps2emu/plugins
	newexe libUSBlinuz.so libUSBlinuz.${PV}.so || die "newexe failed"
	exeinto "$(games_get_libdir)"/ps2emu/plugins/cfg
	doexe cfgUSBlinuz || die "newexe failed"
	dodoc ../readme.txt
	prepgamesdirs
}
