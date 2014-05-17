# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Provides extended encryption using the OTR library"
HOMEPAGE="http://kadu.im"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-qt/qtgui-4.8.0:4
	~net-im/kadu-core-${PV}
	net-libs/libotr:4"
RDEPEND="${DEPEND}"
