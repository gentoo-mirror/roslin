# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils games

DESCRIPTION="Fun game in which you engage your group of penguins in a snowball fight."
HOMEPAGE="http://joey101.net/snowballz/"
SRC_URI="http://joey101.net/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-python/pygame
	dev-python/pyopengl
	dev-python/numeric
	dev-python/rabbyt"
#	dev-python/imaging
RDEPEND="${DEPEND}"

src_install() {
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r *.py buildings cellulose data gooeypy maps plugins || die "doins failed"
	prepgamesdirs
	dodoc README.txt
	newicon data/snow.png ${PN}.png
	make_desktop_entry ${PN} "Snowballz" ${PN} Game
	games_make_wrapper ${PN} "python ./snowballz.py" "${GAMES_DATADIR}/${PN}"
}
