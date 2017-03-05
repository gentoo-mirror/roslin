# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-single-r1 games

DESCRIPTION="A thrilling isometric game where you use dynamite against evil"
HOMEPAGE="http://www.imitationpickles.org/pyweek1/"
SRC_URI="http://www.imitationpickles.org/pyweek1/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-lang/python
	dev-python/pygame
	media-libs/sdl-ttf"

DEPEND="${RDEPEND}"

src_install() {
	rm setup.py *.png dynamite
	newicon icon.ico ${PN}.ico

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data pgu *.py icon.tga || die "doins failed"

	dodoc *.txt || die "dodoc failed"

	make_desktop_entry ${PN} "Dynamite" ${PN} Game
	games_make_wrapper ${PN} "python ./play.py" "${GAMES_DATADIR}/${PN}"

	prepgamesdirs
}
