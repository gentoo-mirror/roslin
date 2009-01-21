# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Awesome high-paced multi-player galactic action-strategy game."
HOMEPAGE="http://www.galcon.com/"
SRC_URI="http://www.imitationpickles.org/galcon/files/${PN}.tgz"

LICENSE="As Is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="mirror strip"

DEPEND="virtual/opengl
	media-libs/sdl-ttf"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	exeinto "${dir}"
	doexe ${PN} || die "doexe failed"
	insinto "${dir}"
	doins -r data *.{so,ico,png} || die "doins failed"

	dodoc README.txt || die "dodoc failed"
	newicon icon64.png ${PN}.png

	games_make_wrapper ${PN} ./${PN} "${dir}" "${dir}"
	make_desktop_entry ${PN} "Galcon" ${PN}

	prepgamesdirs
}
