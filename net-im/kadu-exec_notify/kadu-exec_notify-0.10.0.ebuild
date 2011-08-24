# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="Exec notification module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""

RDEPEND=">=x11-libs/qt-gui-4.7.0
	~net-im/kadu-core-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
