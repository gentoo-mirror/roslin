# Copyright 1999-2010 Gentoo Foundation
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
IUSE="cdinstall debug demo"

DEPEND="cdinstall? ( games-fps/quake1-data )
	demo? ( games-fps/quake1-demodata )
	media-libs/sdl-net"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/Quake

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-missing_mkdir.patch
	epatch "${FILESDIR}"/"${P}"-userdir.patch

	sed -i \
		-e "s!basedir, host_parms.basedir!basedir, \"${GAMES_DATADIR}/quake1\"!" \
		common.c || die "sed failed"

	sed -i \
		-e "s!STRIP ?= strip!STRIP ?= echo!" \
		Makefile || die "sed failed"
}

src_compile() {
	if use debug; then
		emake DEBUG=1 || die "emake failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"

	prepgamesdirs
}
