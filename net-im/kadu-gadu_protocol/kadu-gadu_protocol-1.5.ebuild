# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="GaduGadu support module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-qt/qtgui-4.8.0:4
	>=dev-qt/qtxmlpatterns-4.8.0:4
	~net-im/kadu-core-${PV}
	>=net-libs/libgadu-1.12.1[threads]
	>=app-crypt/qca-2.0"
RDEPEND="${DEPEND}"
