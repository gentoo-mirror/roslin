# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games cmake-utils

MY_PV="${PV/1.0_/}"
MY_PV="${MY_PV/beta/Beta}"
MY_P="${PN}-${MY_PV}-Source"

DESCRIPTION="Open source clone of Theme Hospital"
HOMEPAGE="http://code.google.com/p/corsix-th/"
SRC_URI="http://corsix-th.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="+audio opengl sdl"

DEPEND=">=dev-lang/lua-5.1
	audio? ( media-libs/sdl-mixer[timidity] )
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i "CorsixTH/CMakeLists.txt" \
		-e "/config.txt/d" \
		-e "/LICENSE.txt/d" \
		|| die "sed failed"
}

src_configure() {
	local mycmakeargs="$(cmake-utils_use_with opengl OPENGL) \
		$(cmake-utils_use_with sdl SDL) \
		$(cmake-utils_use_with audio AUDIO) \
		-DCMAKE_INSTALL_PREFIX=${GAMES_DATADIR}"
	cmake-utils_src_configure
}

src_install() {
	DOCS="${PN}/README.txt ${PN}/changelog.txt" cmake-utils_src_install
	games_make_wrapper ${PN} "${GAMES_DATADIR}/${PN}/${PN}" || die
	prepgamesdirs
}

