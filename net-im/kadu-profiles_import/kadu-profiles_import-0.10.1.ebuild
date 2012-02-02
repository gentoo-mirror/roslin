# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="Imports profiles from older Kadu versions"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.7.0
	~net-im/kadu-core-${PV}
	~net-im/kadu-gadu_protocol-${PV}
    ~net-im/kadu-history_migration-${PV}"
RDEPEND="${DEPEND}"

