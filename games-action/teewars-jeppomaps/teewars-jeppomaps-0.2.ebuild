# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

SRCDEFAULT="http://jeppo.de/wordpress/wp-content/uploads"

DESCRIPTION="Additional maps by jeppo."
HOMEPAGE="http://jeppo.de/"
SRC_URI="${SRCDEFAULT}/2007/12/jdm1amap.zip
	${SRCDEFAULT}/2008/01/jdm2map.zip
	${SRCDEFAULT}/2008/02/jdm3map.zip
	racemod? ( ${SRCDEFAULT}/2007/12/jrace1amap.zip
		${SRCDEFAULT}/2008/01/jrace2amap.zip
		${SRCDEFAULT}/2008/02/jrace3map.zip )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="racemod"

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

	prepgamesdirs
}
