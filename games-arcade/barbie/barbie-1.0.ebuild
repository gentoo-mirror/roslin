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

# editor doesn't work, it tries to write in ${GAMES_DATADIR}/${PN}
#IUSE="editor"
IUSE=""

RDEPEND=">=dev-lang/python-2.3
	>=dev-python/pygame-1.6"

DEPEND="${RDEPEND}"

src_install() {
	cd ${WORKDIR}/${P}
	rm data/*.txt setup.py pyweek-upload.py preview.py create-upload.py

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data lib run_game.py || die "doins failed"

#	if use editor ; then
#		doins leveledit.py tileedit.py || die "doins failed"
#		# This is ugly!
#		touch leveledit.ini tileedit.ini || die "touch failed"
#		insopts -m0666 doins *.ini || die "doins *.ini failed"
#	fi

	dodoc *.txt

	games_make_wrapper ${PN} "python ./run_game.py" "${GAMES_DATADIR}/${PN}"

#	if use editor ; then
#		games_make_wrapper ${PN}-leveledit "python ./leveledit.py" \
#			"${GAMES_DATADIR}/${PN}"
#		games_make_wrapper ${PN}-tileedit "python ./tileedit.py" \
#			"${GAMES_DATADIR}/${PN}"
#	fi

	prepgamesdirs
}
