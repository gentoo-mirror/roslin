# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_TITLE="Insomnia"

inherit eutils games games-mod

IUSE="lights"
DESCRIPTION="Classic Quake 1 mod with huge levels"
HOMEPAGE="http://retroquake.planetquake.gamespy.com/blog/?p=72"
SRC_URI="${SRC_ADDICT}/${MOD_FILENAME}
	${SRC_TERMINUS}/${MOD_FILENAME}
	lights? ( http://www.kgbsyndicate.com/romi/czg07.rar )"

MOD_DEPEND="app-arch/unrar"

src_unpack() {
	cd "${S}"
	unpack "${MOD_FILENAME}"

	if use lights; then
		unpack czg07.rar
		mkdir -p insomnia/maps
		mv *rtlights insomnia/maps
	fi

	rm *.zip

	games-mod_src_unpack_tidy
}
