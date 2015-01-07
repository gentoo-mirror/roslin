# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Jabber support module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-qt/qtgui-5.2.0:5
	~net-im/kadu-core-${PV}
	net-dns/libidn
	>=app-crypt/qca-2.1.0:2[qt5,ssl]
	sys-libs/zlib"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
