# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

DESCRIPTION="A fork of the ONScripter engine with added English support"
HOMEPAGE="http://dev.haeleth.net/onscripter.shtml"
SRC_URI="http://dev.haeleth.net/onscripter/${P}-src.tar.bz2"

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

src_prepare() {
	epatch "${FILESDIR}"/cxxflags.patch
	epatch "${FILESDIR}"/compiler-fix.patch
	epatch "${FILESDIR}"/gcc44.patch

	if use scale; then
	sed -i \
	    -e 's:-DLINUX:-DLINUX -DRCA_SCALE:' configure \
	    || die "sed failed"
	fi
}

src_install() {
	dogamesbin onscripter || die "dogamesbin failed"
	dodoc CHANGES INSTALL README || die "dodoc failed"
	dosym onscripter "${GAMES_BINDIR}/${PN}" || die "dosym failed"

	prepgamesdirs
}
