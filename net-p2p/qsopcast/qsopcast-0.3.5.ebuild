# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils kde-functions qt3

DESCRIPTION="qt front-end of the p2p iptv"
HOMEPAGE="http://lianwei3.googlepages.com/home2"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-p2p/sopcast-bin"
RDEPEND="${DEPEND}"

RESTRICT="primaryuri"

src_prepare() {
	sed -i \
		-e "s+/usr/local+/usr+" src/${PN}.pro || die "sed failed"
	
	epatch "${FILESDIR}"/${PN}-gcc43.patch
}

src_compile() {
	cd "${S}"/src

	eqmake3 || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin src/"${PN}" || die "dobin failed"

	doicon "${FILESDIR}"/sopcast.gif
	make_desktop_entry qsopcast "QSopCast - P2P Internet TV Viewer" \
		sopcast.gif

	dodoc AUTHORS README || die "dodoc failed"
}
