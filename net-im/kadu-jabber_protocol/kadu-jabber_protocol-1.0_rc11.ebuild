# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Jabber support module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-qt/qtgui-4.8.0:4
	~net-im/kadu-core-${PV}
	net-dns/libidn
	>=app-crypt/qca-ossl-2.0
	sys-libs/zlib"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
