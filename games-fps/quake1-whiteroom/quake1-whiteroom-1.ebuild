# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="whiteroom"
MOD_TITLE="White Room"
MOD_MAP="whiteroom"

inherit games games-mod

DESCRIPTION="White Room - Quake 1 SP Mod by Willem."
HOMEPAGE="http://www.celephais.net/board/view_thread.php?id=60277"
SRC_URI="http://wantonhubris.com/levels/WhiteRoom/${MOD_DIR}.zip"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"

	rm -r __MACOSX || die "rm"
	find . '(' -name '.DS_Store' ')' -delete

	games-mod_src_unpack_tidy
}
