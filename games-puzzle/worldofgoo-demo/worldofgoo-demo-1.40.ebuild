# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

MY_PN="WorldOfGooDemo"

DESCRIPTION="World of Goo is a puzzle computer game with a strong emphasis on physics"
HOMEPAGE="http://2dboy.com/"
SRC_URI="${MY_PN}.${PV}.tar.gz"

RESTRICT="fetch"

LICENSE="2dboy-EULA"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="media-libs/libpng
	media-libs/sdl-mixer
	media-libs/libogg
	net-misc/curl
	dev-libs/openssl"

S=${WORKDIR}/${MY_PN}
dir=${GAMES_PREFIX_OPT}/${PN}

pkg_nofetch() {
	einfo "To download the demo, naviage to"
	einfo "http://worldofgoo.com/dl2.php?lk=demo"
	einfo "download ${A} manually and place it in"
	einfo "${DISTDIR}"
}

src_install() {
	insinto "${dir}"
	doins -r properties || die "doins failed"
	doins -r res || die "doins failed"

	exeinto "${dir}"
	newexe WorldOfGoo.bin ${PN} || die "newexe failed"

	dodoc linux-issues.txt readme.html || die "dodoc failed"

	newicon icon.png ${PN}.png || die "newicon failed"
	games_make_wrapper ${PN} ./${PN} "${dir}" "${dir}"
	make_desktop_entry ${PN} "World Of Goo - DEMO" ${PN}
	
	prepgamesdirs
}
