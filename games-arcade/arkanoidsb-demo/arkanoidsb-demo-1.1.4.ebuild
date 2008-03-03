# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

MY_PN="arkanoidsb"

DESCRIPTION="Vertical mouse-controlled shareware clone of Arkanoid"
HOMEPAGE="http://www.wegroup.org/games/arkanoid-games/arkanoid-space-ball.html"
SRC_URI="http://www.wegroup.org/downloads/${MY_PN}-${PV}.tar.bz2"

# See README file
LICENSE="${PN}"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=media-libs/libsdl-1.2.5
	>=media-libs/sdl-image-1.2.5
	>=media-libs/sdl-mixer-1.2.7
	media-libs/libmikmod"
DEPEND=""

S=${WORKDIR}/${MY_PN}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	insinto "${dir}"
	doins -r * || die
	rm "${D}/${dir}/${MY_PN}"

	exeinto "${dir}"
	doexe ${MY_PN} || die

	newicon "${MY_PN}.png" ${PN}.png || die
	games_make_wrapper ${PN} "./${MY_PN}" "${dir}"
	make_desktop_entry ${PN} "Arkanoid: Space Ball (Demo)"

	prepgamesdirs
}

