# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python games

MY_P="${P}p"

DESCRIPTION="Two dimensional, turn based simulation-strategy game set in the gravity fields of several planets."
HOMEPAGE="http://www.slingshot-game.org/"
SRC_URI="mirror://sourceforge/${PN}-game/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-lang/python
	dev-python/pygame"

DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_install() {
	newicon data/shot.png ${PN}.png

	mv ../Readme.txt readme.txt
	dodoc readme.txt

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data *.py

	make_desktop_entry ${PN} "Slingshot" ${PN} Game
	games_make_wrapper ${PN} "python ./slingshot.py" "${GAMES_DATADIR}/${PN}"

	prepgamesdirs
}
