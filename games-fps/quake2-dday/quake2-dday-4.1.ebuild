# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="Deathmatch total conversion that brings the sting of battle from World War 2"
HOMEPAGE="http://dday.planetquake.gamespy.com/site/"
SRC_URI="ddaynormandy_v4.zip dday-${PV}-linux.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="fetch"

# Tested with the qudos engine - other engines might work also
RDEPEND="games-fps/qudos
	games-fps/quake2-data"
DEPEND="app-arch/unzip"

S=${WORKDIR}/dday
dir=${GAMES_DATADIR}/quake2/dday
libdir=${GAMES_LIBDIR}/qudos/dday

pkg_nofetch() {
	einfo "Please download:"
	einfo "  ${SRC_URI}"
	einfo "from ${HOMEPAGE}"
	einfo "and place them in ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	mv -f *.{so,txt} "${S}" || die

	find . -type f '(' -name '*.bat' -o -name '*.dll' -o -name '*.exe' ')' -delete
}

src_install() {
	insinto "${dir}"
	doins -r "${S}"/* || die
	rm "${D}/${dir}"/{game,grm,usa}i386.so || die

	exeinto "${libdir}"
	doexe "${S}"/*.so || die

	# Needs + at end of command-line
	games_make_wrapper ${PN} "qudos +set game dday +set deathmatch 1 +"
	make_desktop_entry ${PN} "QuDos - D-Day: Normandy" qudos.xpm

	prepgamesdirs
}