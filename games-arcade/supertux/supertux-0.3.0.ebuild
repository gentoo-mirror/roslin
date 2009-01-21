# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="A game similar to Super Mario Bros."
HOMEPAGE="http://super-tux.sourceforge.net"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86"
IUSE="debug"

RDEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-image-1.2.2
	sys-libs/zlib
	dev-util/ftjam
	>=dev-games/physfs-1.0.0
	media-libs/libvorbis
	media-libs/libogg
	>=media-libs/openal-1.5.304"
DEPEND="${RDEPEND}
	x11-libs/libXt"

src_compile() {
	egamesconf \
		$(use_enable debug) || die
	jam || die "jam failed"
}

src_install() {
	DESTDIR=${D} jam install || die "jam install failed"
	dodoc README || die "dodoc failed"
	prepgamesdirs
}
