# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

MY_PN=psyno
MY_PV=${PV//./.}

DESCRIPTION="shinichiro hamaji's Psyno "
HOMEPAGE="http://shinh.skr.jp/psyno/"
SRC_URI="http://shinh.skr.jp/psyno/${MY_PN}-${MY_PV}.zip
        http://shinh.skr.jp/sdlpad/SDL_pad-0.1.5.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"

DEPEND="media-libs/libsdl
	media-libs/mesa
	media-libs/sdl-mixer"

S=${WORKDIR}/${MY_PN}

pkg_setup() {
        games_pkg_setup

	# gcc must be built with "d" USE-FLAG
	if ! built_with_use sys-devel/gcc:4.1 d; then
		ewarn "sys-devel/gcc must be built with d for this package"
		ewarn "to function."
		die "recompile gcc with USE=\"d\""
	fi
	if [ "$(gcc-major-version)" == "4" ] && [ "$(gcc-minor-version)" == "2" ] ; then
		die "gdc doesn't work with sys-devel/gcc-4.2 currently - use 4.1 instead"
	fi

}

src_unpack(){
	cd ${WORKDIR}
	unpack ${MY_PN}-${MY_PV}.zip
	cd "${S}/src/"
        unpack SDL_pad-0.1.5.tar.bz2
	epatch ${FILESDIR}/${P}.diff
	sed -i \
        -e 's:"\(data/[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i sound.d \
        -e 's:`\(data/[^"]*\)`:"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i scene_select.d \
        -e 's:"\(data/[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i rc.d \
        -e 's:"\(data/[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i myglbf.d \
        -e 's:"\(data/[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i texture.d \
        -e 's:"\(replay/[^"]*\)":"'${GAMES_STATEDIR}'/'${PN}'/\1":g' -i scene_select.d \
        -e 's:"\(save/[^"]*\)":"'${GAMES_STATEDIR}'/'${PN}'/\1":g' -i rc.d \
        -e 's:`\(save/[^"]*\)`:"'${GAMES_STATEDIR}'/'${PN}'/\1":g' -i rc.d \
        -e 's:"\(save/[^"]*\)":"'${GAMES_STATEDIR}'/'${PN}'/\1":g' -i sino.d \
		|| die "sed failed"
}

src_compile() {
	cd "${S}/src/SDL_pad"
	egamesconf \
		--disable-shared \
		--enable-static \
		|| die
	emake || die "emake failed"
	cd "${S}/src/"
	make
}

src_install() {
	dogamesbin ${PN}

	local datadir="${GAMES_DATADIR}"/${PN}
	if [ ! -e ${GAMES_STATEDIR}/${PN}/replay ]
	then
		dodir "${GAMES_STATEDIR}/${PN}/replay/"
		
	fi
	if [ ! -e ${GAMES_STATEDIR}/${PN}/save ]
	then
		dodir "${GAMES_STATEDIR}/${PN}/save/"
		insinto "${GAMES_STATEDIR}/${PN}/save/"
	        doins save/* || die
	fi

	dodir ${datadir}
        insinto "${GAMES_DATADIR}"/${PN}/data
	doins data/* || die
        insinto "${GAMES_DATADIR}"/${PN}/data/sound
	doins data/sound/* || die
        insinto "${GAMES_DATADIR}"/${PN}/data/texture
	doins data/texture/* || die
	newicon ${FILESDIR}/${PN}.png ${PN}.png
	make_desktop_entry ${PN} ${PN}
	dodoc readme*
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
}
