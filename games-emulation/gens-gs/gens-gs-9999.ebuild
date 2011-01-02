# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

EGIT_REPO_URI="git://gs_server.gerbilsoft.ddns.info/srv/git/gens.git"

inherit autotools games git

DESCRIPTION="A Gens fork which aims to clean up the source code and combine features from other forks"
HOMEPAGE="http://info.sonicretro.org/Gens/GS"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus debug opengl"

RDEPEND="dbus? ( dev-libs/dbus-glib )
	opengl? ( virtual/opengl )
	>=media-libs/libsdl-1.2[opengl?]
	x11-libs/gtk+:2
	virtual/libiconv
	!games-emulation/gens"
DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98"

src_prepare() {
	eautoreconf || die
}

src_configure() {
	egamesconf \
		$(use_with opengl) \
		$(use_enable debug) \
		$(use_with dbus) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install \
		|| die "install failed"
	dodoc AUTHORS.txt ChangeLog.txt NEWS.txt README.txt
	prepgamesdirs
}
