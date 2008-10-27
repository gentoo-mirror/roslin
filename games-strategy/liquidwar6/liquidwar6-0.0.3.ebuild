# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games libtool

DESCRIPTION="Another unique multiplayer wargame"
HOMEPAGE="http://www.gnu.org/software/liquidwar6/"
SRC_URI="http://download.savannah.gnu.org/releases/liquidwar6/${PN}-0.0.3beta.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls"
#RESTRICT="test"

DEPEND="media-libs/libpng
	dev-scheme/guile"

S=${WORKDIR}/${P}beta

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/${P}-confiugure.patch
	epatch ${FILESDIR}/${P}-confiugure.ac.patch

	#elibtoolize
	libtoolize --copy --force || die
}

src_compile() {
	egamesconf \
		$(use_enable nls) || die "egamesconf failed"
#		--enable-optimize \
	emake || die "emake failed"
}

src_install() {
	einstall || die "emake install failed"
	prepgamesdirs
}
