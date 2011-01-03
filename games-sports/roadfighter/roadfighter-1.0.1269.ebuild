# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

DESCRIPTION="Konami's Road Fighter remake"
HOMEPAGE="http://roadfighter.jorito.net/"
SRC_URI="http://braingames.jorito.net/${PN}/downloads/${PN}.src_${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-net
	media-libs/sdl-ttf"
DEPEND="${RDEPEND}
	media-libs/sdl-sound"

src_prepare() {
	epatch "${FILESDIR}/${PV}-Makefile.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc readme.txt || die "dodoc failed"

	games_make_wrapper ${PN} "./${PN}" "${GAMES_DATADIR}/${PN}"
	make_desktop_entry ${PN} "Road Fighter" ${PN}
	prepgamesdirs
}
