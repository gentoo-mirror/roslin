# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_USES_QRACK=y
MOD_USES_JOEQUAKE=y
MOD_USES_TYRQUAKE=y

MOD_DIR="quoth"
MOD_MAP="${PN/quake1-/}"

#MOD_CMDLINE_END="-game quoth +map ${MOD_MAP}"

MOD_TITLE="Slave to a Machine"
MOD_RDEPEND="games-fps/quake1-quoth"

inherit eutils games games-mod

DESCRIPTION="Slave to a Machine by RickyT23 for Quoth"
HOMEPAGE="http://www.celephais.net/board/view_thread.php?id=60184"
SRC_URI="${SRC_ADDICT}/${MOD_MAP}.zip"

dir=${GAMES_DATADIR}/quake1

src_install() {
	insinto "${dir}/${MOD_DIR}"
	doins -r gfx || die "doins failed"

	games-mod_src_install
}
