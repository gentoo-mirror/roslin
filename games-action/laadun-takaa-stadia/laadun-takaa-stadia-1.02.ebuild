# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

MY_PN=lts
MY_PV=${PV}

DESCRIPTION="bullethell shooter"
HOMEPAGE="http://kiintee.tp/pui/pui_games.html"
SRC_URI="http://kiintee.tp/pui/laadun_takaa_stadia_v102.zip
        http://kiintee.tp/pui/lts-1.02.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"

DEPEND="media-libs/libsdl
	media-libs/mesa
        dev-util/scons
        >=x11-libs/wxGTK-2.6.3.3
        media-libs/sdl-mixer
	media-libs/sdl-mixer"

S=${WORKDIR}/${MY_PN}-${MY_PV}

pkg_setup() {
        games_pkg_setup


}

src_unpack(){
	unpack ${A}
	epatch ${FILESDIR}/fix.diff
	cd "${S}"

	sed -i \
        -e 's:"\(gfx/[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i src/main.cpp \
        -e 's:"\(snd/[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i src/main.cpp \
        -e 's:"\(txt/[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i src/main.cpp \
		|| die "sed failed"
}

src_compile() {
	tc-export CXX
	scons || die "scons failed"
}

src_install() {
	dogamesbin ${WORKDIR}/${MY_PN}-${MY_PV}/build/${MY_PN} || die "dogamesbin failed"
        insinto "${GAMES_DATADIR}"/"${PN}"
        cd ${WORKDIR}
        doins -r gfx snd txt || die "doins failed"
	newicon ${FILESDIR}/${PN}.png ${PN}.png
	make_desktop_entry lts ${PN}
}

pkg_postinst() {
	games_pkg_postinst
}
