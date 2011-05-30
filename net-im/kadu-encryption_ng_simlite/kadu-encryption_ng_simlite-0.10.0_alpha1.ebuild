# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="QCA encryption module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""

CDEPEND=">=x11-libs/qt-gui-4.7.0
	~net-im/kadu-core-${PV}
    app-crypt/qca-ossl:2"
DEPEND="${CDEPEND}
    !net-im/kadu-encryption
    !net-im/kadu-ecnryption_old
	dev-util/pkgconfig"
RDEPEND="${CDEPEND}
	~net-im/kadu-encryption_ng-${PV}"
