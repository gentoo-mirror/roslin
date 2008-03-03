# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Floating sticky notes box"
HOMEPAGE="http://scourge.swifthost.net"
SRC_URI="http://scourge.swifthost.net/py/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND=">=dev-lang/python-2.4.3-r1
		>=dev-python/wxpython-2.6.3.3"

S=${WORKDIR}/${PN}

src_install () {
	dobin sticky || die "install failed"
	dodoc README
}
