# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="An accuracy-focused Sega Genesis/MegaDrive/Master System/Game Gear/SC-3000/SG-1000 emulator"
HOMEPAGE="http://aamirm.hacking-cult.org/index_files/regen.htm"
SRC_URI="http://aamirm.hacking-cult.org/regen/${P}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

QA_PRESTRIPPED="${GAMES_BINDIR:1}/regen"

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
