# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils autotools flag-o-matic games

DESCRIPTION="A kart racing game starring Tux, the linux penguin (TuxKart fork)"
HOMEPAGE="http://supertuxkart.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.bz2
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug nls"

DEPEND=">=media-libs/plib-1.8.4
	virtual/opengl
	media-libs/libvorbis
	media-libs/openal
	media-libs/libsdl"

pkg_setup() {
    if use debug; then
	filter-flags -fomit-frame-pointer
	replace-flags -O? -O0
    fi
}

src_prepare() {
	epatch "${FILESDIR}"/"${PV}"-Makefile.patch \
		"${FILESDIR}"/"${PV}"-desktop.patch
	
	eautoreconf
}

src_configure() {
	egamesconf \
		--datadir="${GAMES_DATADIR_BASE}" \
		$(use_enable debug) \
		$(use_enable nls) \
		--disable-optimization || die
}

src_install() {
	emake DESTDIR="${D}" install || die "einstall failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
	prepgamesdirs
}
