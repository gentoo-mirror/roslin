# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python games

DESCRIPTION="You're a seahorse - and you want to go to the moon!"
HOMEPAGE="http://www.imitationpickles.org/barbie/"
SRC_URI="http://www.imitationpickles.org/${PN}/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

RDEPEND=">=dev-lang/python-2.3
	>=dev-python/pygame-1.6"

DEPEND="${RDEPEND}"

src_install() {
	rm data/*.txt setup.py pyweek-upload.py preview.py create-upload.py

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data lib run_game.py || die "doins failed"

	dodoc *.txt

	games_make_wrapper ${PN} "python ./run_game.py" "${GAMES_DATADIR}/${PN}"

	prepgamesdirs
}
