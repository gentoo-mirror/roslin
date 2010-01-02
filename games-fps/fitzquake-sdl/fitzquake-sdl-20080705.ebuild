# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

MY_PN="${PN/-/_}"

DESCRIPTION="Modified glquake based on the source code released by id Software."
HOMEPAGE="http://www.celephais.net/fitzquake http://www.kristianduske.com/fitzquake/"
SRC_URI="http://www.kristianduske.com/fitzquake/${MY_PN}_${PV}_src.zip
	mirror://sourceforge/uhexen2/${MY_PN}_${PV}_Makefile.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="games-fps/quake1-data
	media-libs/sdl-net"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_PN}_${PV}_src/Quake

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/"${PN}"-save-in-home.patch

	mv ../../Makefile ./

	sed -i \
		-e "s!basedir, host_parms.basedir!basedir, \"${GAMES_DATADIR}/quake1\"!" \
		common.c || die "sed failed"

	sed -i \
		-e "s!STRIP_CMD := strip!STRIP_CMD := echo!" \
		Makefile || die "sed failed"
}

src_compile() {
	if use debug; then
		emake DEBUG=1 || die "emake failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	dogamesbin ${PN/-sdl/} || die "dobin failed"

	prepgamesdirs
}
