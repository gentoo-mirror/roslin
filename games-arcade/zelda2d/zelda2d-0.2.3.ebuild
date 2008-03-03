# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="A Zelda related Jump'n'Run Game in 2D"
HOMEPAGE="http://zelda.netster.de/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug editor"

RDEPEND="media-libs/sdl-image
	media-libs/sdl-gfx
	media-libs/sdl-mixer
	dev-libs/boost
	editor? ( >=x11-libs/wxGTK-2.6 )"
DEPEND="${RDEPEND}"

src_compile() {
	if use debug; then
		emake engine || die "emake engine failed"
	else
		emake CFLAGS="${CFLAGS} -DLUA_USE_LINUX" CXXFLAGS="${CXXFLAGS}" engine || die "emake engine failed"
	fi

	if use editor && ! use debug; then
		emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" editor || die "emake editor failed"
	fi
	if use editor && use debug; then
		emake editor || die "emake editor failed"
	fi
	#luabind/src dont respect cxxflags
	#g++ -g -ftemplate-depth-100 -Wall -DLUABIND_BUILDING
}

src_install() {
	exeinto "${GAMES_DATADIR}/${PN}"
	doexe ${PN}	|| die "doexe failed"

	if use editor; then
		exeinto "${GAMES_DATADIR}/${PN}"
		doexe ${PN}editor	|| die "doexe failed"

		newicon ${S}/leveleditor/leveleditor.ico ${PN}-editor.ico
		make_wrapper zelda2d-editor ./zelda2deditor "/usr/share/games/zelda2d/" "/usr/share/games/zelda2d"
		insinto /usr/share/applications/
		doins ${FILESDIR}/zelda2d-editor.desktop
	fi

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r resources	|| die "doins failed"
	prepgamesdirs

	insinto /usr/share/applications/
	doins ${FILESDIR}/zelda2d.desktop
	make_wrapper zelda2d ./zelda2d "/usr/share/games/zelda2d" "/usr/share/games/zelda2d"
	newicon ${S}/resources/engine/hud/bow64x64.png ${PN}.png
	dodoc CREDITS INSTALL README TODO
}
