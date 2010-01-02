# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_TITLE="Dissolution of Eternity"
MOD_CMDLINE_OPTIONS="-rogue"
MOD_DEPEND_UNZIP=n

inherit eutils games games-mod

DESCRIPTION="Dissolution of Eternity mission pack for Quake 1"
HOMEPAGE="http://www.idsoftware.com/games/quake/quake-mp2/"
SRC_URI="vispatch? ( mirror://sourceforge/vispatch/rogue_vis.tgz )"

IUSE="vispatch"

DEPEND="vispatch? (
		games-util/vispatch
		app-arch/zip )"

pkg_setup() {
	games_pkg_setup

	cdrom_get_cds Eternity/ROGUE/PAK0.PAK:rogue/pak0.pak
}

src_unpack() {
	if use vispatch; then
		unpack ${A}
		mkdir rogue
		cp "${CDROM_ROOT}/${CDROM_MATCH}" rogue/pak0.pak
		vispatch -dir "${S}"/rogue -data "${S}"/rogue.vis || die "vispatch failed"
	fi
}

src_install() {
	insinto "${dir}"/rogue
	if use vispatch; then
		newins "${S}"/rogue/pak0.pak pak0.pak \
			|| die "newins ${S}/rogue/pak0.pak failed"
	else
		newins "${CDROM_ROOT}/${CDROM_MATCH}" pak0.pak \
			|| die "newins ${CDROM_MATCH} failed"
	fi

	# CDROM_SET starts at 0
	if [[ "${CDROM_SET}" = "0" ]] ; then
		dodoc "${CDROM_ROOT}"/Eternity/*.TXT || die "dodoc failed"
	else
		dodoc "${CDROM_ROOT}"/*.txt || die "dodoc failed"
	fi

	games-mod_src_install_tidy

	prepgamesdirs
}
