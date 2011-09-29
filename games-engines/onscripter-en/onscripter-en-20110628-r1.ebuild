# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils flag-o-matic games

DESCRIPTION="A fork of the ONScripter engine with added English support"
HOMEPAGE="http://onscripter.denpa.mobi/?page_id=26"
SRC_URI="http://onscripter.denpa.mobi/pub/onscr/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="scale"

DEPEND="media-libs/sdl-image[jpeg,png]
	media-libs/sdl-mixer[mp3,vorbis]
	media-libs/sdl-ttf
	media-libs/smpeg
	app-arch/bzip2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-src"

pkg_setup() {
	append-flags "-Wno-error"
	games_pkg_setup
}

src_prepare() {
	edos2unix configure
	epatch "${FILESDIR}"/${PN}-20110314-compiler.patch

	if use scale; then
	sed -i \
	    -e 's:-DLINUX:-DLINUX -DRCA_SCALE:' configure \
	    || die "sed failed"
	fi
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	dodoc CHANGES INSTALL README || die "dodoc failed"

	prepgamesdirs
}
