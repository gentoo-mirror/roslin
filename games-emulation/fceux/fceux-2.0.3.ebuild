# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games cmake-utils

DESCRIPTION="FCEUX is a cross platform Famicom/NES emulator based on FCE Ultra"
HOMEPAGE="http://fceux.com/web/htdocs/"
SRC_URI="mirror://sourceforge/fceultra/${P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug opengl"

RDEPEND="media-libs/libsdl[opengl?]
	sys-libs/zlib
	opengl? ( virtual/opengl )"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6"

S="${WORKDIR}/fceu"

src_prepare() {
	epatch "${FILESDIR}/${P}-cmakelists.patch"
	epatch "${FILESDIR}/${P}-build-fix.patch"
	
	local build_type
	
	use debug && build_type="debug"
	use debug || build_type="release"
	
	echo "add_subdirectory(${build_type})" \
	> cmake/native/CMakeLists.txt
}

src_configure() {
	local mycmakeargs

	use opengl || mycmakeargs="-DFCEUX_SDL_OPENGL:BOOL=OFF"
	cmake-utils_src_configure
}

src_install() {
	use debug && newgamesbin bin/${PN}DBG fceux
	use debug || newgamesbin bin/${PN}REL fceux
	
	dodoc AUTHORS TODO-PROJECT changelog.txt \
	    documentation/*.txt documentation/*.html \
	    documentation/faq documentation/todo
	doman documentation/fceux.6
	
	prepgamesdirs
}
