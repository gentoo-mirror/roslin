# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="GaduGadu support module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-qt/qtgui-5.2.0:5
	>=dev-qt/qtxmlpatterns-5.2.0:5
	~net-im/kadu-core-${PV}
	>=net-libs/libgadu-1.12.1[threads]
	>=app-crypt/qca-2.0"
RDEPEND="${DEPEND}"
