# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_TITLE="Insomnia"

inherit eutils games games-mod

DESCRIPTION="Classic Quake 1 mod with huge levels"
HOMEPAGE="http://retroquake.planetquake.gamespy.com/blog/?p=72"
SRC_URI="${SRC_ADDICT}/${MOD_FILENAME}
	${SRC_TERMINUS}/${MOD_FILENAME}"

src_unpack() {
	unpack ${A}

	rm *.zip

	games-mod_src_unpack_tidy
}
