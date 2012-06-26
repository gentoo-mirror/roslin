# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="Jabber support module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=x11-libs/qt-gui-4.7.0
	~net-im/kadu-core-${PV}
	net-dns/libidn
	>=app-crypt/qca-ossl-2.0
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

