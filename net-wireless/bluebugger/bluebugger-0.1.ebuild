# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Simple implementation of the bluebug technique"
# Not sure about this...
HOMEPAGE="http://www.remote-exploit.org/"
SRC_URI="http://www.remote-exploit.org/codes/${PN}/${P}.tar.gz"

# blob?
LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-wireless/bluez-utils"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s|= -O2|= ${CFLAGS}|" Makefile || die "sed Makefile failed"
}

src_install() {
	dobin ${PN}
	dodoc README
}
