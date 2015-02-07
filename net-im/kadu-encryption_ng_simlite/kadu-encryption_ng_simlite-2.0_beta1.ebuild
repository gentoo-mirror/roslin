# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="QCA encryption module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-qt/qtcore-5.2.0:5
	>=dev-qt/qtgui-5.2.0:5
	>=dev-qt/qtwidgets-5.2.0:5
	>=dev-qt/qtnetwork-5.2.0:5
	>=dev-qt/qtxml-5.2.0:5
	>=dev-qt/qtwebkit-5.2.0:5
	>=dev-qt/qtquick1-5.2.0:5
	>=dev-qt/qtdbus-5.2.0:5
	>=dev-qt/qtx11extras-5.2.0:5
	dev-libs/injeqt
	>=app-crypt/qca-2.1.0:2[qt5,openssl]
	~net-im/kadu-encryption_ng-${PV}
	~net-im/kadu-core-${PV}"
DEPEND="${RDEPEND}
	!net-im/kadu-encryption
	!net-im/kadu-encryption_old
	virtual/pkgconfig"