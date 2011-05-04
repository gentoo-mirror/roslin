# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="Slot racers is a race-and-shooting game based on Slot Racers for Atari"
HOMEPAGE="http://zillode.be/"
SRC_URI="http://zillode.be/portfolio/projects/Atari-game/atari-game.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/sdl-gfx"
RDEPEND="${DEPEND}"

S=${WORKDIR}/Atari-game
dir=${GAMES_DATADIR}/${PN}

src_prepare() {
	sed -i \
		-e "s|-lSDL_gfx|-lSDL_gfx ${LDFLAGS}|" \
		-e "s|-Wall -O2|${CXXFLAGS}|" \
		Makefile || die "sed Makefile failed"

	to_patch=$(grep -l '"data\/' *)
	sed -i \
		-e "s|data/|${dir}/data/|" \
		$to_patch || die "sed failed"

	epatch "${FILESDIR}/${PV}-glibc.patch"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${dir}"
	doins -r data || die "doins failed"

	prepgamesdirs
}
