# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python games

DESCRIPTION="A thrilling isometric game where you use dynamite agains evil"
HOMEPAGE="http://www.imitationpickles.org/pyweek1/"
SRC_URI="http://www.imitationpickles.org/pyweek1/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/python-2.3
	>=dev-python/pygame-1.6
	media-libs/sdl-ttf"

DEPEND="${RDEPEND}"

src_install() {
	cd ${WORKDIR}/${P}
	rm setup.py *.png dynamite
	newicon icon.ico ${PN}.ico

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data pgu *.py icon.tga

	dodoc *.txt

	make_desktop_entry ${PN} "Dynamite" ${PN} Game
	games_make_wrapper ${PN} "python ./play.py" "${GAMES_DATADIR}/${PN}"

	prepgamesdirs
}
