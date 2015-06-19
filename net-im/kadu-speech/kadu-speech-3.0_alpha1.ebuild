# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Reads Kadu messages with the powiedz speech synthetizer"
HOMEPAGE="http://kadu.im"
KEYWORDS=""
IUSE=""

COMMON_DEP=">=dev-qt/qtcore-5.2.0:5
	>=dev-qt/qtgui-5.2.0:5
	>=dev-qt/qtwidgets-5.2.0:5
	>=dev-qt/qtnetwork-5.2.0:5
	>=dev-qt/qtxml-5.2.0:5
	>=dev-qt/qtwebkit-5.2.0:5
	>=dev-qt/qtquick1-5.2.0:5
	>=dev-qt/qtdbus-5.2.0:5
	>=dev-qt/qtx11extras-5.2.0:5
	>=dev-libs/injeqt-1.0.0
	~net-im/kadu-core-${PV}"
RDEPEND="${COMMON_DEP}
	app-accessibility/powiedz"
DEPEND="${COMMON_DEP}
	virtual/pkgconfig"
