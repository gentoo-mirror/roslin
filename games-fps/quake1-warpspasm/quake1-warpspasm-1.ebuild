# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_USES_QRACK=y
MOD_USES_DARKPLACES=n
MOD_USES_JOEQUAKE=n

MOD_DIR="warpspasm"
MOD_TITLE="Warpspasm"
MOD_CMDLINE_OPTIONS="-game warpspasm -heapsize 48000"
MOD_RDEPEND="app-arch/p7zip"

inherit eutils games games-mod

DESCRIPTION="Warpspasm level pack for Quoth"
HOMEPAGE="http://www.celephais.net/board/view_thread.php?id=60073"
SRC_URI="${SRC_ADDICT}/quoth.zip
	${SRC_KELL}/quoth.zip
	http://shub-hub.quaddicted.com/files/mods_singleplayer/warpspasm.7z"

src_unpack() {
	unpack warpspasm.7z
	mv pak2.pak pak3.pak
	mv pak1.pak pak2.pak
	mv pak0.pak pak1.pak

	unpack quoth.zip

	games-mod_src_unpack_tidy
}
