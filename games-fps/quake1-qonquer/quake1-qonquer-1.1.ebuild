# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="qonquer"
MOD_TITLE="Qonquer"
# The "hipnotic" expansion pack does *not* need to be installed.
MOD_MAP="qstart"

inherit games games-mod

HOMESRC="http://www.wantonhubris.com/qonquer"

DESCRIPTION="Qonquer - Fight waves of monsters in arena style maps with the aid of your minions."
HOMEPAGE="${HOMESRC}/Qonquer.html"
SRC_URI="${HOMESRC}/Qonquer_v1_1.zip"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"

	rm -r __MACOSX Qonquer_v1_1/Qonquer/qcc "Qonquer_v1_1/Qonquer/sample maps" \
		|| die "rm"
	find . '(' -name '.DS_Store' ')' -delete

	mv Qonquer_v1_1/Qonquer qonquer || die "mv"
	mv Qonquer_v1_1/*.txt ./ || die "mv2"

	rmdir Qonquer_v1_1

	games-mod_src_unpack_tidy
}
