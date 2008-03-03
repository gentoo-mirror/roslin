# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="Mars, Land of No Mercy is a turn-based strategy game setting on Mars during the early stages of human colonization"
HOMEPAGE="http://www.marsnomercy.org/"
SRC_URI="mirror://sourceforge/mars/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="opengl"

RDEPEND="opengl? ( virtual/opengl )
	media-libs/sdl-image
	media-libs/sdl-ttf
	media-libs/libsdl"
DEPEND="${RDEPEND}
	dev-util/scons"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	sed -i \
		-e "s:data/:${GAMES_DATADIR}/${PN}/:g" \
		src/*.{h,cpp}
	rm -rf build config.log
}

src_compile() {
	use opengl && with_opengl=1 || with_opengl=0
	export warnings=0 strip=0 debug=0 with_opengl
	scons || die
}

src_install() {
	dogamesbin mars || die
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die
	dodoc README
	prepgamesdirs
}
