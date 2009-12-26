# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="warpspasm"
MOD_TITLE="Warpspasm"

inherit eutils games games-mod

DESCRIPTION="Warpspasm level pack for Quoth"
HOMEPAGE="http://www.celephais.net/board/view_thread.php?id=60073"
SRC_URI="${SRC_ADDICT}/quoth.zip
	${SRC_KELL}/quoth.zip
	${SRC_ADDICT}/${MOD_DIR}.zip"
IUSE=""

dir=${GAMES_DATADIR}/quake1

src_unpack() {
	unpack ${MOD_DIR}.zip
	mv warp/pak2.pak pak4.pak
	mv warp/pak1.pak pak3.pak
	mv warp/pak0.pak pak2.pak

	unpack quoth.zip

	rm quoth*txt

	games-mod_src_unpack_tidy
}

#src_install() {
#	insinto "${dir}/${MOD_DIR}"
#	doins
#}
