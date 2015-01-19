# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="Base encryption module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=" "
IUSE=""

RDEPEND=">=dev-qt/qtgui-5.2.0:5
	~net-im/kadu-core-${PV}
	app-crypt/qca-ossl:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
