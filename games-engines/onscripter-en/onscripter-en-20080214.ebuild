# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="A fork of the ONScripter engine with added English support"
HOMEPAGE="http://dev.haeleth.net/onscripter.shtml"
SRC_URI="http://dev.haeleth.net/onscripter/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="scale"

DEPEND="media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/smpeg
	app-arch/bzip2"
RDEPEND="${DEPEND}"

pkg_setup() {
	games_pkg_setup

	if ! built_with_use "media-libs/sdl-image" png ; then
		die "media-libs/sdl-image has to be compiled with USE='png'"
	fi

	if ! built_with_use "media-libs/sdl-image" jpeg ; then
		die "media-libs/sdl-image has to be compiled with USE='jpeg'"
	fi

	if ! built_with_use "media-libs/sdl-mixer" vorbis ; then
		die "media-libs/sdl-mixer has to be compiled with USE='vorbis'"
	fi

	if ! built_with_use "media-libs/sdl-mixer" mp3 ; then
		die "media-libs/sdl-mixer has to be compiled with USE='mp3'"
	fi
}


src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/configure-fix.patch

	if use scale; then
	sed -i \
	    -e 's:-DLINUX:-DLINUX -DRCA_SCALE:' configure \
	    || die "sed failed"
	fi
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin onscripter
	dodoc CHANGES INSTALL README

	prepgamesdirs
}


