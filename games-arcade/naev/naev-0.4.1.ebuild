# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="NAEV is 2d action/rpg space game that combines elements from the action, rpg and simulation genres."
HOMEPAGE="http://code.google.com/p/naev/"
SRC_URI="http://naev.googlecode.com/files/${P}.tar.bz2
	http://naev.googlecode.com/files/ndata-${PV}"
# the second stands for data.
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="openal sdl-sound"

RDEPEND="dev-libs/libxml2
	media-libs/freetype
	media-libs/sdl-image
	media-libs/sdl-mixer
	virtual/opengl"
DEPEND="${RDEPEND}"

#src_unpack() {
#	unpack ${P}.tar.bz2
#	cp "${DISTDIR}"/ndata-"${PV}" "${T}"
#	cd "${S}"
	# use system png library.
#	sed -i \
#		-e "s:<png.h>:<libpng12/png.h>:" src/opengl.c || die "sed failed"

	# fix make system
#	epatch "${FILESDIR}/${PV}-Makefile.patch"

#	if ! use debug; then
#		sed -i -e "s!DEBUG := 1!DEBUG := 0!" Makefile || die "sed debug failed"
#	fi
#}

src_configure() {
	egamesconf \
		$(use_with openal) \
		$(use_with sdl-sound sdlmixer) \
		--disable-shave \
		|| die "egamesconf failed"
}

src_install() {
	dogamesbin "${PN}" || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}"
	newins "${DISTDIR}"/ndata-"${PV}" ndata || die "doins ndata falied"
	# todo install doc files

	dodoc conf.example AUTHORS README TODO || die "dodoc failed"
	doman ${PN}.6 || die "doman failed"

	prepgamesdirs
}
