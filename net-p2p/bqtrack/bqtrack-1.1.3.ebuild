# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="A BitTorrent tracker with minimal functionality and a fast and robust C++ implementation"
HOMEPAGE="http://bisqwit.iki.fi/source/bqtrack.html"
SRC_URI="http://bisqwit.iki.fi/src/arch/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/libevent
	dev-libs/openssl
	sys-devel/make"

src_install() {
	dobin ${PN} || die "dobin failed"
	dohtml README.html
}
