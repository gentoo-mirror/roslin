# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="An accuracy focused emulator for Sega Genesis/MegaDrive, Sega Master System, Sega Game Gear, Sega SC-3000 and Sega SG-1000"
HOMEPAGE="http://aamirm.hacking-cult.org/index_files/regen.htm"
SRC_URI="http://aamirm.hacking-cult.org/regen/${P}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="strip"

S="${WORKDIR}"

DEPEND="virtual/opengl
	x11-libs/gtk+:2
	media-libs/alsa-lib
	media-libs/libsdl[joystick]
	sys-libs/zlib
	x11-libs/libXrandr
	x11-libs/libXv"
RDEPEND="${DEPEND}"

src_install() {
	dogamesbin regen || die "dobin failed"
	dodoc README || die "dodoc failed"

	make_desktop_entry regen "Regen"

	prepgamesdirs
}
