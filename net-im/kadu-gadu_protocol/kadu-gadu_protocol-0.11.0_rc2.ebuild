# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="GaduGadu support module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.7.0
	>=x11-libs/qt-xmlpatterns-4.7.0
	~net-im/kadu-core-${PV}
	>=net-libs/libgadu-1.11.1[threads]
	>=app-crypt/qca-2.0"
RDEPEND="${DEPEND}"

