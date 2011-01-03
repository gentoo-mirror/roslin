# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_TITLE="Deja Vu"
MOD_DIR="dejavu"
MOD_MAP="dvstart"

MY_PN="DejaVu"

inherit eutils versionator games games-mod

MY_P="${MY_PN}$(delete_all_version_separators)"

KEYWORDS=""

DESCRIPTION="Deja Vu - Six Map Mini Episode"
HOMEPAGE="http://www.celephais.net/board/view_thread.php?id=60115"
SRC_URI="${SRC_ADDICT}/quoth.zip
	${SRC_KELL}/quoth.zip
	http://shub-hub.com/files/maps_singleplayer/${MY_P}.zip"
IUSE=""

src_unpack() {
	unpack ${MY_P}.zip
	mv Pak1.pak pak1.pak

	unpack quoth.zip

	games-mod_src_unpack_tidy
}
