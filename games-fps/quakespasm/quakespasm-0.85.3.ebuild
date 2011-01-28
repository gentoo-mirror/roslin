# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="A *nix firendly FitzQuake with new features."
HOMEPAGE="http://quakespasm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cdinstall debug demo sdl-net"

DEPEND="virtual/opengl
	sdl-net? ( media-libs/sdl-net )"
RDEPEND="${DEPEND}
	cdinstall? ( games-fps/quake1-data )
	demo? ( games-fps/quake1-demodata )"

S=${WORKDIR}/${P}/Quake

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-ldflags.patch

	sed -i \
		-e "s!basedir, host_parms.basedir!basedir, \"${GAMES_DATADIR}/quake1\"!" \
		common.c || die "sed failed"

	sed -i \
		-e "s!STRIP ?= strip!STRIP ?= echo!" \
		Makefile || die "sed failed"
}

src_compile() {
	local opts=""
	use debug && opts="DEBUG=1"
	use sdl-net && opts="${opts} SDLNET=1"

	emake ${opts} || die "emake failed"
}

src_install() {
	dogamesbin "${PN}" || die "dogamesbin failed"

	prepgamesdirs
}
