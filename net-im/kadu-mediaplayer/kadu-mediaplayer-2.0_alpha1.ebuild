# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Media player support module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-qt/qtgui-5.2.0:5
	>=dev-qt/qtdbus-5.2.0:5
	~net-im/kadu-core-${PV}"
RDEPEND="${DEPEND}"
