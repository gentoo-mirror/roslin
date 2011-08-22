# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games git-2

DESCRIPTION="A simple GUI for SSNES using the phoenix toolkit"
HOMEPAGE="https://github.com/Themaister/SSNES-Phoenix"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Themaister/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-libs/libsdl[joystick]
	>=x11-libs/qt-gui-4.6:4
	games-emulation/SSNES"
DEPEND="dev-util/pkgconfig
	>=sys-devel/gcc-4.5
	${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-makefile.patch"
}

src_install() {
	dogamesbin ssnes-phoenix || die
	make_desktop_entry ssnes-phoenix ${PN}
	prepgamesdirs
}
