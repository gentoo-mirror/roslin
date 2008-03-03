# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/liquidwar/liquidwar-5.6.3.ebuild,v 1.8 2006/10/30 10:47:38 nyhm Exp $

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

dir="${WORKDIR}/${P}beta"

src_unpack() {
	unpack ${A}
	cd "${dir}"

	epatch ${FILESDIR}/${P}-confiugure.patch
	epatch ${FILESDIR}/${P}-confiugure.ac.patch

	#elibtoolize
	libtoolize --copy --force || die
}

src_compile() {
	cd "${dir}"
	egamesconf \
		$(use_enable nls) || die "egamesconf failed"
#		--enable-optimize \
	emake || die "emake failed"
}

src_install() {
	einstall || die "emake install failed"
	prepgamesdirs
}
