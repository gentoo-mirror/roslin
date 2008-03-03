# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_TITLE="Digs"

inherit eutils games games-mod

DESCRIPTION="A Quake Single Plyer episode by Digs"
HOMEPAGE="http://digs.alfaspace.net/quake"
SRC_URI="${SRC_ADDICT}/${MOD_FILENAME}"

src_unpack() {
	unpack ${A}

	mv readme.eng readme.eng.txt
	mv readme.rus readme.rus.txt

	games-mod_src_unpack_tidy
}
