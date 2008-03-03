# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Catch monsters in bubbles"
HOMEPAGE="http://www.losersjuegos.com.ar/juegos/aqbubble/aqbubble.php"
SRC_URI="http://www.losersjuegos.com.ar/juegos/aqbubble/descargas/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.0.1
		media-libs/sdl-image
		media-libs/sdl-mixer"
#RDEPEND=""

src_compile() {
	egamesconf || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin "src/${PN}" || die "installing the binary failed"
	
	insinto "${GAMES_DATADIR}/${PN}/ima"
	( doins -r src/ima/*.png &&
	  doins -r src/ima/*.jpg   ) || die "installing images failed"
	insinto "${GAMES_DATADIR}/${PN}/sonidos"
	doins -r src/sonidos/*.wav   || die "installing sounds failed"
	
	dodoc README README_ES || die "installing docs failed"

	make_desktop_entry ${PN} "Aquatic Bubble" ${PN}.xpm

	prepgamesdirs
}
