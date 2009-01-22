# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="quess"
MOD_CMDLINE_END="+teamplay 0"

inherit eutils versionator games games-mod

BASE_PV="13"
MY_PV=$(delete_all_version_separators)

DESCRIPTION="Playable chess with Quake 1 monsters"
HOMEPAGE="http://retroquake.planetquake.gamespy.com/blog/?p=175"
SRC_URI="${SRC_TERMINUS}/${MOD_DIR}${BASE_PV}.zip
	${SRC_TERMINUS}/${MOD_DIR}${MY_PV}.zip"
IUSE=""

src_unpack() {
	unpack ${A}

	rm *.{BAT,dat}

	games-mod_src_unpack_tidy
}
