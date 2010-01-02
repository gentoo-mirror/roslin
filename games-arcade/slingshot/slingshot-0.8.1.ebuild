# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

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

S=${WORKDIR}/${MY_P}/${PN}

src_install() {
	newicon data/shot.png ${PN}.png || die "newicon failed"

	mv ../Readme.txt readme.txt || die "Moving docs failed"
	dodoc readme.txt || die "dodoc failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data *.py || die "doins failed"

	make_desktop_entry ${PN} "Slingshot" ${PN} Game
	games_make_wrapper ${PN} "python ./slingshot.py" "${GAMES_DATADIR}/${PN}"

	prepgamesdirs
}
