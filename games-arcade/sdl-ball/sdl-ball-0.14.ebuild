# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Arkanoid/Breakout clone with pretty graphics."
HOMEPAGE="https://sourceforge.net/projects/sdl-ball"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="wiiuse"

DEPEND="media-libs/sdl-ttf
	media-libs/sdl-image
	media-libs/sdl-mixer
	wiiuse? ( games-util/wiiuse )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s!themes/!${dir}/themes/!" \
		-e "s!-c -Wall!${CFLAGS} -c -Wall!" \
		-e "s!-lSDL_ttf!-lSDL_ttf ${LDFLAGS}!" \
		Makefile || die "sed Makefile failed"

	if use wiiuse; then
		sed -i \
			-e "s!CC=g++!CC=g++ -DWITH_WIIUSE!" \
			-e "s!-c -Wall!-lwiiuse -c -Wall!" \
			Makefile || die "sed wiiuse Makefile failed"
	fi
}

src_install() {
	dobin ${PN}
	insinto ${dir}
	doins -r data
}
