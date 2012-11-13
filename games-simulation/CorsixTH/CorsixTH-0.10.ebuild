# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games cmake-utils

#MY_P="${P}-Source"
MY_P="${P}-Sourze"

DESCRIPTION="Open source clone of Theme Hospital"
HOMEPAGE="http://code.google.com/p/corsix-th/"
SRC_URI="http://corsix-th.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="truetype opengl +sdl +sound"

RDEPEND=">=dev-lang/lua-5.1
	media-libs/libsdl
	truetype? ( media-libs/freetype:2 )
	opengl? ( virtual/opengl )
	sdl? ( x11-libs/agg )
	sound? ( media-libs/sdl-mixer[timidity] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

#S="${WORKDIR}/${PN}"
S="${WORKDIR}"

PATCHES=("${FILESDIR}/${PN}-0.8-unbundle-agg.patch" \
		"${FILESDIR}/${PN}-0.7-nodoc.patch" \
		"${FILESDIR}/${P}-cmake.patch")

src_configure() {
	local mycmakeargs="$(cmake-utils_use_with opengl OPENGL) \
		$(cmake-utils_use_with sdl SDL) \
		$(cmake-utils_use_with sound AUDIO) \
		$(cmake-utils_use_with truetype FREETYPE2) \
		-DCMAKE_INSTALL_PREFIX=${GAMES_DATADIR}"
	cmake-utils_src_configure
}

src_install() {
	DOCS="${PN}/README.txt ${PN}/changelog.txt" cmake-utils_src_install
	games_make_wrapper ${PN} "${GAMES_DATADIR}/${PN}/${PN}" || die
	make_desktop_entry ${PN}
	prepgamesdirs
}
