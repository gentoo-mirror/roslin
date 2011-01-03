# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games cmake-utils

MY_P="${P}-src"

DESCRIPTION="An ONScripter clone with Unicode support and other features"
HOMEPAGE="http://sourceforge.net/projects/onslaught-vn/"
SRC_URI="mirror://sourceforge/onslaught-vn/${MY_P}.7z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

RDEPEND="media-libs/sdl-image[jpeg,png]
	media-libs/sdl-mixer[mp3,vorbis]
	app-arch/bzip2
	media-libs/freetype"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6
	app-arch/p7zip"

src_prepare() {
	sed -i CMakeLists.txt \
	    -e "/EXECUTABLE_OUTPUT_PATH/d" \
	    || die "sed failed"

	epatch "${FILESDIR}/${P}-sdl_bilinear.patch"
}

src_install() {
	dogamesbin ../${MY_P}_build/${PN} || die "gamesbin failed"
	dodoc ChangeLog.txt KnownIssues.txt PFAQ.txt README.txt doc/*.txt
	dohtml -r doc/ONScripter_reference

	prepgamesdirs
}
