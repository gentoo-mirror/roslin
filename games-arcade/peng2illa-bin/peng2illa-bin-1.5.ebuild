# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/peng2illa-bin/peng2illa-bin-1.5.ebuild,v 1.1 2005/12/27 12:20:05 egore Exp $

inherit games

DESCRIPTION="a free agility based Pong clone inside a circle"
HOMEPAGE="http://peng2illa.nukular.ch/"
SRC_URI="http://peng2illa.nukular.ch/files/Peng2illa-1.5.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86"
IUSE="dedicated"

DEPEND="${RDEPEND}"

S=${WORKDIR}/Peng2illa-${PV}

src_install() {
	insinto ${GAMES_DATADIR}/${PN}
	doins -r music PENG2ILLA.DAT replays || die "failed installing data"

	exeinto ${GAMES_DATADIR}/${PN}
	doexe Peng2illa || die "failed installing binary"
	if use dedicated; then
		doexe Peng2illa-Server || die "failed installing dedicated binary"
	fi

	games_make_wrapper ${PN} ./Peng2illa ${GAMES_DATADIR}/${PN}
	use dedicated && games_make_wrapper ${PN}-ded ./Peng2illa-Server ${GAMES_DATADIR}/${PN}

	prepgamesdirs
}
