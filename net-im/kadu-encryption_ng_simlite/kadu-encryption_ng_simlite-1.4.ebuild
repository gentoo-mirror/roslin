# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="QCA encryption module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-qt/qtgui-4.8.0:4
	~net-im/kadu-core-${PV}
	app-crypt/qca-ossl:2
	~net-im/kadu-encryption_ng-${PV}"
DEPEND="${RDEPEND}
	!net-im/kadu-encryption
	!net-im/kadu-encryption_old
	virtual/pkgconfig"
