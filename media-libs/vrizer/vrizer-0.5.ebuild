# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

P_N="${PN/vr/VR}"

DESCRIPTION="Library to create stereoscopic output for arbitrary opengl software."
HOMEPAGE="http://futurelab.aec.at/vrizer/"
SRC_URI="http://futurelab.aec.at/${PN}/${P_N}-${PV}-bin.tar.gz"

LICENSE="vrizer"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/opengl"
DEPEND="${RDEPEND}"

src_install() {
	dolib ${PN}.so || die "dolib failed"
	dobin ${PN}_rconfig || die "dobin failed"
	dodoc AUTHORS README || die "dodoc failed"
}
