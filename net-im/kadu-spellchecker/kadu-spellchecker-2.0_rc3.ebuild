# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kadu

DESCRIPTION="Spellchecker module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=""
IUSE="aspell +enchant"

RDEPEND=">=dev-qt/qtcore-5.2.0:5
	>=dev-qt/qtgui-5.2.0:5
	>=dev-qt/qtwidgets-5.2.0:5
	>=dev-qt/qtnetwork-5.2.0:5
	>=dev-qt/qtxml-5.2.0:5
	>=dev-qt/qtwebkit-5.2.0:5
	>=dev-qt/qtquick1-5.2.0:5
	>=dev-qt/qtdbus-5.2.0:5
	>=dev-qt/qtx11extras-5.2.0:5
	>=>=>=dev-libs/injeqt-1.0.0-1.0.0-1.0.0
	~net-im/kadu-core-${PV}
	aspell? ( app-text/aspell )
	enchant? ( app-text/enchant )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

REQUIRED_USE="^^ ( aspell enchant )"

src_configure() {
	local mycmakeargs="${mycmakeargs} \
		$(cmake-utils_use_with aspell ASPELL)
		$(cmake-utils_use_with enchant ENCHANT)"
	kadu_src_configure
}
