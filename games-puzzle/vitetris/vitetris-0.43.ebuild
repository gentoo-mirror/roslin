# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Terminal-based Tetris clone by Victor Nilsson."
HOMEPAGE="http://victornils.net/tetris/"
SRC_URI="http://victornils.net/tetris/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE="X joystick ncurses net"

DEPEND="sys-libs/glibc 
	ncurses? ( sys-libs/ncurses )
	X? ( x11-libs/libX11 )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s|-strip --strip-all|echo|" \
		Makefile || die "sed Makefile failed"
}

src_compile() {
	egamesconf \
		$(use_with X x) \
		$(use_enable joystick js) \
		$(use_with ncurses curses) \
		$(use_enable net) \
		|| die "egamesconf failed"
	emake \
		LDFLAGS="${LDFLAGS}" \
		CCFLAGS="${CXXFLAGS}" \
		|| die "emake failed"
}

src_install() {
	newgamesbin tetris ${PN} || die "dogamesbin failed"

	dodoc README

	prepgamesdirs
}
