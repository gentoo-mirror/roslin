# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="5rivers"
MOD_TITLE="The Five Rivers Land"
MOD_MAP="5rivers_e1"

MOD_CMDLINE_START="-hipnotic"
MOD_RDEPEND_EXTRA="games-fps/quake1-quoth"

inherit games games-mod

DESCRIPTION="Mini campaign in DOOM 3 hell-style with three small to medium
sized, dark and scrary maps"
HOMEPAGE="http://lambert.jeanphilippe.free.fr/"
SRC_URI="${SRC_ADDICT}/${MOD_DIR}.zip"

dir=${GAMES_DATADIR}/quake1

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_install() {
	insinto "${dir}/${MOD_DIR}"
	doins -r gfx sound || die "doins failed"

	insinto "${dir}/${MOD_DIR}/maps"
	doins maps/*s_e* || die "doins failed"

	games-mod_src_install_tidy
}
