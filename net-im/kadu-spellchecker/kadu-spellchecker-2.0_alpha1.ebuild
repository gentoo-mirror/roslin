# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kadu

DESCRIPTION="Spellchecker module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=""
IUSE="aspell +enchant"

RDEPEND=">=dev-qt/qtgui-5.2.0:5
	~net-im/kadu-core-${PV}
	aspell? ( app-text/aspell )
	enchant? ( app-text/enchant )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs="${mycmakeargs} \
		$(cmake-utils_use_with aspell ASPELL)
		$(cmake-utils_use_with enchant ENCHANT)"
	kadu_src_configure
}
