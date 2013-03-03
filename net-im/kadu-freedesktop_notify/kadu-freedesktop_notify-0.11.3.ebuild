# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="Kadu module for freedesktop notifications"
HOMEPAGE="http://kadu.im"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-qt/qtgui-4.7.0
	>=dev-qt/qtdbus-4.7.0
	~net-im/kadu-core-${PV}"
RDEPEND="${DEPEND}"
