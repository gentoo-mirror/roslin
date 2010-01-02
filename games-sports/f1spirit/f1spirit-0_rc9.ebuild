# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
MY_PV=${PV/_/.}

inherit eutils games

DESCRIPTION="Konami's MSX1 classic F1-Spirit remake"
HOMEPAGE="http://www.braingames.getput.com/f1spirit/default.asp"
SRC_URI="http://braingames.jorito.net/${PN}/${PN}.src_${MY_PV}-1412.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl[joystick,opengl]
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-net
	net-misc/curl"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P/_/.}

src_prepare() {
	epatch "${FILESDIR}/${MY_PV}-Makefile.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc readme.txt || die "dodoc failed"

	games_make_wrapper ${PN} "./${PN}" "${GAMES_DATADIR}/${PN}"
	make_desktop_entry ${PN} "F1 Spirit" ${PN}
	prepgamesdirs
}
