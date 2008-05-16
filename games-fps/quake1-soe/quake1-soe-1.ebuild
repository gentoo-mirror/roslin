# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="soe"
MOD_TITLE="Soul of Evil"
MOD_USES_TYRQUAKE=y

inherit games games-mod

DESCRIPTION="Contract Revoked - Quake 1 single-player pack"
HOMEPAGE="http://tronyn.planetquake.gamespy.com/"
SRC_URI="${SRC_ADDICT}/${MOD_DIR}_full.zip"

dir=${GAMES_DATADIR}/quake1

src_unpack() {
	unpack "${A}"
	cd "${S}"

	mkdir "${MOD_DIR}"
	unzip soe_readme.zip || die "html failed to unpack."
	mv "Soul of Evil - Readme.htm" soul_of_evil.htm
	rm soe_readme.zip

	games-mod_src_unpack_tidy
}

src_install() {
	dohtml -r html "${MOD_DIR}"/*htm || die "dohtml failed"
	dodoc *txt || die "dodoc failed"

	insinto "${dir}"/"${MOD_DIR}"
	doins "${MOD_DIR}"/pak* || die "doins failed"

	games-mod_src_install_wrapper

	prepgamesdirs
}
