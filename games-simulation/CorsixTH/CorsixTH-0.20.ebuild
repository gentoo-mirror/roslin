# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games cmake-utils

MY_P="${P}-Source"

DESCRIPTION="Open source clone of Theme Hospital"
HOMEPAGE="http://code.google.com/p/corsix-th/"
SRC_URI="http://corsix-th.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ffmpeg truetype opengl +sdl +sound"

RDEPEND=">=dev-lang/lua-5.1
	media-libs/libsdl
	ffmpeg? ( virtual/ffmpeg )
	truetype? ( media-libs/freetype:2 )
	opengl? ( virtual/opengl )
	sound? ( media-libs/sdl-mixer[timidity] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

PATCHES=("${FILESDIR}/${PN}-0.7-nodoc.patch")

src_configure() {
	local mycmakeargs="$(cmake-utils_use_with opengl OPENGL) \
		$(cmake-utils_use_with sdl SDL) \
		$(cmake-utils_use_with sound AUDIO) \
		$(cmake-utils_use_with truetype FREETYPE2) \
		$(cmake-utils_use_with ffmpeg MOVIES) \
		-DCMAKE_INSTALL_PREFIX=${GAMES_DATADIR}"
	cmake-utils_src_configure
}

src_install() {
	DOCS="${PN}/README.txt ${PN}/changelog.txt" cmake-utils_src_install
	games_make_wrapper ${PN} "${GAMES_DATADIR}/${PN}/${PN}" || die
	make_desktop_entry ${PN}
	prepgamesdirs
}
