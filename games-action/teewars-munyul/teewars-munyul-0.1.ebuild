# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

SRCMU="http://www.munyul.com/d/"

DESCRIPTION="Additional maps by Eric Sambach."
HOMEPAGE="http://jeppo.de/"
SRC_URI="${SRCMU}/mvtwctf01.zip
	${SRCMU}/mvtwdm01.zip
	${SRCMU}/mvtwdm02.zip
	${SRCMU}/mvtwdm03.zip
	${SRCMU}/mvtwdm04.zip"

# see text files included
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="<games-action/teewars-0.4"
DEPEND="${RDEPEND}
	app-arch/zip"

T_MAPS="teewars/data/maps"
dir=${GAMES_DATADIR}/${T_MAPS}
S=${WORKDIR}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	insinto "${dir}"
	doins *map

	dodoc *txt

	prepgamesdirs
}
