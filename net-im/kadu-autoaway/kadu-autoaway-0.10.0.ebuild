# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="Autoaway module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.7.0
	~net-im/kadu-core-${PV}
	~net-im/kadu-idle-${PV}"
RDEPEND="${DEPEND}"
