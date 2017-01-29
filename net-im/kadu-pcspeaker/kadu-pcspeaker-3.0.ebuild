# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kadu

DESCRIPTION="PC Speaker notification for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-qt/qtcore-5.2.0:5
	>=dev-qt/qtgui-5.2.0:5
	>=dev-qt/qtwidgets-5.2.0:5
	>=dev-qt/qtnetwork-5.2.0:5
	>=dev-qt/qtxml-5.2.0:5
	>=dev-qt/qtwebkit-5.2.0:5
	>=dev-qt/qtdbus-5.2.0:5
	>=dev-qt/qtx11extras-5.2.0:5
	>=dev-qt/qtdeclarative-5.2.0:5[widgets]
	x11-libs/libX11
	>=dev-libs/injeqt-1.0.0
	~net-im/kadu-core-${PV}"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
