# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils games

DESCRIPTION="Side-scrolling beat-em-up in the style of Beats of Rage"
HOMEPAGE="http://paintown.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-libs/allegro-4.1
	media-libs/aldumb
	media-libs/freetype
	media-libs/libpng"
DEPEND="${RDEPEND}
	dev-util/cmake"

dir=${GAMES_DATADIR}/${PN}

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="README LEGAL doc/* TODO" cmake-utils_src_install
	prepgamesdirs
}
