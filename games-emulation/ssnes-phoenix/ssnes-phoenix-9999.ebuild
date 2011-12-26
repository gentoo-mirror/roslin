# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games git-2

DESCRIPTION="A simple GUI for SSNES using the phoenix toolkit"
HOMEPAGE="https://github.com/Themaister/SSNES-Phoenix"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Themaister/SSNES-Phoenix.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="gtk qt4"

RDEPEND="media-libs/libsdl[joystick]
	>=x11-libs/qt-gui-4.6:4
	games-emulation/ssnes"
DEPEND="dev-util/pkgconfig
	>=sys-devel/gcc-4.5
	${RDEPEND}"

pkg_setup() {
	confutils_require_one gtk qt4
	games_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-makefile.patch"
}

src_compile() {
	if use gtk; then
		emake -f Makefile.gtk
	elif use qt4; then
		emake -f Makefile.qt
	fi
}

src_install() {
	dogamesbin ssnes-phoenix || die
	make_desktop_entry ssnes-phoenix ${PN}
	prepgamesdirs
}
