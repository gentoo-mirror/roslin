# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="QCA encryption module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""

RDEPEND=">=x11-libs/qt-gui-4.7.0
	~net-im/kadu-core-${PV}
    app-crypt/qca-ossl:2
	~net-im/kadu-encryption_ng-${PV}"
DEPEND="${RDEPEND}
    !net-im/kadu-encryption
    !net-im/kadu-encryption_old
	dev-util/pkgconfig"
