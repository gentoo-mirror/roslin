# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Automatic sender lookup module for Kadu"
HOMEPAGE="http://www.kadu.net/w/Anonymous_check"
SRC_URI="http://download.kadu.im/external-plugins/2.0/${MOD_NAME}-${PV/_p/-}.tar.bz2"
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
	>=dev-libs/injeqt-1.0.0
	>=net-im/kadu-core-2.0_alpha"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MOD_NAME}"
