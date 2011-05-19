# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MIN_VER="0.9.2"

MOD_DEPEND="aspell? ( app-text/aspell ) \
	enchant? ( app-text/enchant )"

inherit kadu-base kadu-mod

DESCRIPTION="Spellchecker module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="~amd64 ~x86"
IUSE="aspell +enchant"

src_configure() {
	local mycmakeargs="${mycmakeargs} \
		$(cmake-utils_use_with aspell ASPELL)
		$(cmake-utils_use_with enchant ENCHANT)"
	kadu-base_src_configure
}
