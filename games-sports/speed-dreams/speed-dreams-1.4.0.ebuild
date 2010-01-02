# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit games

DESCRIPTION="Open source racing game"
HOMEPAGE="http://speed-dreams.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/speed-dreams-${PV}-beta1-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="virtual/glut
	media-libs/plib
	media-libs/freealut
	media-libs/libpng
	media-libs/jpeg"

S=${WORKDIR}/${P}-beta1-src

src_prepare() {
	epatch "${FILESDIR}/${PV}-configure.patch"
	epatch "${FILESDIR}/${PV}-as-needed.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	emake DESTDIR="${D}" datainstall || die "datainstall failed"

	prepgamesdirs
}
