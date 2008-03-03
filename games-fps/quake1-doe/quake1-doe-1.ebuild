# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_TITLE="Dissolution of Eternity"
MOD_CMDLINE_OPTIONS="-rogue"
MOD_DEPEND_UNZIP=n

inherit eutils games games-mod

DESCRIPTION="Dissolution of Eternity mission pack for Quake 1"
HOMEPAGE="http://www.idsoftware.com/games/quake/quake-mp2/"
SRC_URI=""

pkg_setup() {
	games_pkg_setup

	cdrom_get_cds Eternity/ROGUE/PAK0.PAK:rogue/pak0.pak
}

src_unpack() { :; }

src_install() {
	insinto "${dir}"/rogue
	newins "${CDROM_ROOT}/${CDROM_MATCH}" pak0.pak \
		|| die "newins ${CDROM_MATCH} failed"

	# CDROM_SET starts at 0
	if [[ "${CDROM_SET}" = "0" ]] ; then
		dodoc "${CDROM_ROOT}"/Eternity/*.TXT
	else
		dodoc "${CDROM_ROOT}"/*.txt
	fi

#	if use X ; then
#		# Wrapper for darkplaces engine
#		games_make_wrapper darkplaces-doe "darkplaces -rogue"
#		make_desktop_entry darkplaces-doe "Dark Places (Dissolution of Eternity)" darkplaces.png
#	fi

	games-mod_src_install_tidy

	prepgamesdirs
}
