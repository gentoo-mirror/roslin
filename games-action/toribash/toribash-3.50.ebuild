# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Innovative fighting game where YOU design the moves!"
HOMEPAGE="http://www.toribash.com/"
SRC_URI="x86? ( http://linux.toribash.com/download/i386/toribash-3.50-i386.tar.gz )
	amd64? ( http://linux.toribash.com/download/amd64/toribash-3.50-amd64.tar.gz )"

LICENSE="toribash"
SLOT="0"
KEYWORDS=""
IUSE="povray"

RDEPEND="dev-lang/lua
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	virtual/glut"
DEPEND="povray? ( media-gfx/povray )"

if use x86; then S=${WORKDIR}/${P}-i386
else S=${WORKDIR}/${P}-amd64
fi

dir=${GAMES_PREFIX_OPT}/${PN}

src_install() {
	insinto "${dir}"
	doins -r data *cfg || die "doins failed"
	dodoc *txt || die "dodoc failed"

	exeinto "${dir}"
	doexe ${PN} || die "doexe failed"

	# ugly fix for missing lua
	dosym /usr/lib/liblua.so /usr/lib/liblua5.1.so.0

	newicon data/textures/logo.tga ${PN}.tga

	games_make_wrapper ${PN} ./${PN} "${dir}" "${dir}"
	make_desktop_entry ${PN} "Toribash" ${PN}

	prepgamesdirs
}
