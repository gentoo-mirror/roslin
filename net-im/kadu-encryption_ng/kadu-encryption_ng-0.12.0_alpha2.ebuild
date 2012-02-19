# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="Base encryption module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=""
IUSE=""

RDEPEND=">=x11-libs/qt-gui-4.7.0
	~net-im/kadu-core-${PV}
	app-crypt/qca-ossl:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
