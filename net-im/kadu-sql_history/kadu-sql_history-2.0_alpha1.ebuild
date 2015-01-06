# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="SQL history module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=" "
IUSE=""

DEPEND=">=dev-qt/qtgui-5.2.0:5
	>=dev-qt/qtconcurrent-5.2.0:5
	~net-im/kadu-core-${PV}
	 >=dev-qt/qtsql-5.2.0:5[sqlite]
	 ~net-im/kadu-history-${PV}"
RDEPEND="${DEPEND}"
