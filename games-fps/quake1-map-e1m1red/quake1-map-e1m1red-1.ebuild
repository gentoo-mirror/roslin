# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="e1m1red"
MOD_TITLE="Bloody Slipgates"
MOD_MAP="e1m1red"

inherit games games-mod

DESCRIPTION="Bloody Slipgates - map evolved from The Slipgate Duplex."
HOMEPAGE="http://www.celephais.net/board/view_thread.php?id=60259"
SRC_URI="http://qexpo.tastyspleen.net/uploaded/4/${MOD_MAP}.zip
	http://shub-hub.com/files/maps_singleplayer/${MOD_MAP}.zip"
IUSE=""

dir=${GAMES_DATADIR}/quake1

src_install() {
	insinto "${dir}"/"${MOD_DIR}"
	doins -r maps progs progs.dat || die "doins failed"

	games-mod_src_install
}
