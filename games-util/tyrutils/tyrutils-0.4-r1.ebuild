# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

DESCRIPTION="light, vis, bspinfo, bsputil and qbsp tools for quake by tyrquake author"
HOMEPAGE="http://disenchant.net/utils.html"
SRC_URI="http://disenchant.net/files/utils/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-max_tstack.patch || die "epatch failed"
}

src_compile() {
	emake \
		CFLAGS="${CFLAGS}" \
		STRIP="echo" \
		|| die "emake failed"
}

src_install() {
	dogamesbin light/light || die "dogamesbin failed"
	dogamesbin vis/vis || die "dogamesbin failed"
	dogamesbin bspinfo/bspinfo || die "dogamesbin failed"
	dogamesbin bsputil/bsputil || die "dogamesbin failed"
	dogamesbin qbsp/qbsp || die "dogamesbin failed"

	dodoc *.txt || die "dodoc failed"

	prepgamesdirs
}
