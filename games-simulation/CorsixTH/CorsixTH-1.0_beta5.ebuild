# Copyright 1999-2011 Gentoo Foundation
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
IUSE="opengl sdl +sound"

RDEPEND=">=dev-lang/lua-5.1
	x11-libs/agg
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl )
	sound? ( media-libs/sdl-mixer[timidity] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i "CorsixTH/CMakeLists.txt" \
		-e "/config.txt/d" \
		-e "/LICENSE.txt/d" \
		|| die "sed failed"

	epatch "${FILESDIR}/${PN}-unbundle-agg.patch"
}

src_configure() {
	local mycmakeargs="$(cmake-utils_use_with opengl OPENGL) \
		$(cmake-utils_use_with sdl SDL) \
		$(cmake-utils_use_with sound AUDIO) \
		-DCMAKE_INSTALL_PREFIX=${GAMES_DATADIR}"
	cmake-utils_src_configure
}

src_install() {
	DOCS="${PN}/README.txt ${PN}/changelog.txt" cmake-utils_src_install
	games_make_wrapper ${PN} "${GAMES_DATADIR}/${PN}/${PN}" || die
	make_desktop_entry ${PN}
	prepgamesdirs
}
