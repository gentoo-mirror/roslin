# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Slot racers is a race-and-shooting game based on Slot Racers for Atari"
HOMEPAGE="http://www.zillode.be/"
SRC_URI="http://zillode.be/projects/Atari-game/atari-game.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="media-libs/sdl-gfx"
RDEPEND="${DEPEND}"

S=${WORKDIR}
dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm make.depend
	sed -i \
		-e "s|-lSDL_gfx|-lSDL_gfx ${LDFLAGS}|" \
		-e "s|-Wall -O2|${CXXFLAGS}|" \
		Makefile
	
	to_patch=$(grep -l '"data\/' *)
	sed -i \
		-e "s|data/|${dir}/data/|" \
		$to_patch || die "sed Makefile failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${dir}"
	doins -r data || die "doins failed"

	prepgamesdirs
}
