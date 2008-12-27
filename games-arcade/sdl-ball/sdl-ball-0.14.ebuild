# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils flag-o-matic games

DESCRIPTION="Arkanoid/Breakout clone with pretty graphics."
HOMEPAGE="https://sourceforge.net/projects/sdl-ball"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+sound wiiuse"

DEPEND="media-libs/sdl-ttf
	media-libs/sdl-image
	sound? ( media-libs/sdl-mixer[vorbis] )
	wiiuse? ( games-util/wiiuse )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use !sound; then
		rm -r themes/snd || die "rm failed"
	fi

	epatch "${FILESDIR}/${PV}-Makefile.patch"
}

src_compile() {
	export LIBS

	if use sound; then
		LIBS+=" -lSDL_mixer"
	else
		append-flags "-DNOSOUND"
	fi

	if use wiiuse; then
		append-flags "-DWITH_WIIUSE"
		LIBS+=" -lwiiuse"
	fi

	emake DATADIR="${dir}/themes/" || die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"

	insinto "${dir}"
	doins -r themes/ || die "doins failed"

	dodoc README || die "dodoc failed"
	prepgamesdirs
}
