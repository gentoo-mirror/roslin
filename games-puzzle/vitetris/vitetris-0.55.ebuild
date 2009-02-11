# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="Terminal-based Tetris clone by Victor Nilsson."
HOMEPAGE="http://victornils.net/tetris/"
SRC_URI="http://victornils.net/tetris/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="X allegro joystick ncurses net"

DEPEND="sys-libs/glibc
	allegro? ( media-libs/allegro )
	ncurses? ( sys-libs/ncurses )
	X? ( x11-libs/libX11 )"
RDEPEND=""

src_prepare() {
	sed -i \
		-e "s|-strip --strip-all|echo|" \
		-e "s|PROGNAME = tetris|PROGNAME = vitetris|" \
		Makefile || die "sed Makefile failed"
		
	epatch "${FILESDIR}"/${PN}-configure.patch
}

src_configure() {
	egamesconf \
		$(use_enable X xlib) \
		$(use_enable joystick js) \
		$(use_enable ncurses curses) \
		$(use_enable net network) \
		|| die "egamesconf failed"
}

src_compile() {
	emake \
		LDFLAGS="${LDFLAGS}" \
		CCFLAGS="${CXXFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dogamesbin vitetris || die "dogamesbin failed"

	dodoc README || die "dodoc failed"

	prepgamesdirs
}
