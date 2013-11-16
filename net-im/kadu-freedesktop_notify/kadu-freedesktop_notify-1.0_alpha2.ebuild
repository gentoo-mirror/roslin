# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Kadu module for freedesktop notifications"
HOMEPAGE="http://kadu.im"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-qt/qtgui-4.8.0:4
	>=dev-qt/qtdbus-4.8.0:4
	~net-im/kadu-core-${PV}"
RDEPEND="${DEPEND}"
