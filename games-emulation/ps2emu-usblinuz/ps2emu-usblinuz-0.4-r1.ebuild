# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/ps2emu-cddvdlinuz/ps2emu-cddvdlinuz-0.3-r1.ebuild,v 1.7 2007/04/06 18:56:48 nyhm Exp $

inherit games

PCSX2="pcsx2-0.9.4"

DESCRIPTION="PS2Emu USB plugin"
HOMEPAGE="http://www.pcsx2.net/"
SRC_URI="mirror://sourceforge/pcsx2/${PCSX2}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"

S="${WORKDIR}/${PCSX2}/plugins/usb/USBlinuz/Linux"

src_unpack() {
	unpack ${A}
	cd "${S}"
	
	epatch "${FILESDIR}/${PN}-use-gtk2.patch"
	
	sed -i \
		-e '/^CC =/d' \
		-e '/\bstrip\b/d' \
		-e 's/-O[0-9]\b//g' \
		-e 's/-fomit-frame-pointer\b//g' \
		Makefile || die
}

src_install() {
	exeinto "$(games_get_libdir)"/ps2emu/plugins
	newexe libUSBlinuz.so libUSBlinuz.${PV}.so || die "newexe failed"
	exeinto "$(games_get_libdir)"/ps2emu/plugins/cfg
	doexe cfgUSBlinuz || die "newexe failed"
	dodoc ../ReadMe.txt || die
	prepgamesdirs
}
