# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Kadu module for automatic window hiding"
HOMEPAGE="http://kadu.im"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

DEPEND=">=dev-qt/qtgui-4.8.0:4
	~net-im/kadu-core-${PV}
	~net-im/kadu-idle-${PV}"
RDEPEND="${DEPEND}"
