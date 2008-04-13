# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="stealth"
MOD_TITLE="Stealth Quake"

MOD_USES_TYRQUAKE=y

MY_PN="${PN/quake1-s/S}"

SRC_RENNYC="http://renegadec.digitalfunk.org/Quake%20Mods"

inherit games games-mod

DESCRIPTION="Stealth Quake is a retelling of Quake if it were a stealth survival horror game,"
HOMEPAGE="http://forums.inside3d.com/viewtopic.php?p=10210"
SRC_URI="!darkplaces? ( ${SRC_RENNYC}/${MY_PN}WQ.rar )
	darkplaces? ( ${SRC_RENNYC}/${MY_PN}DP.rar )"

DEPEND="app-arch/unrar"

pkg_setup() {
	games_pkg_setup

	if use darkplaces && use tyrquake; then
		einfo ""
		einfo "Can't build with \"darkplaces\" and \"tyrquake\" support."
		einfo "Package has two different sources:"
		einfo "  1) High Quality to use with Darkplaces engine."
		einfo "  2) Normal for every other engine."
		einfo ""
		einfo "Please select only one \"engine\" USE flag."
		die ""darkplaces" and "tyrquake" USE flags enabled."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}

	if use darkplaces; then
		mv Stealth stealth || die "mv failed"
	else
		mv StealthWQ stealth || die "mv failed"
	fi

	mv src/* stealth/src/ || die "mv failed"
	mv progs.dat stealth/ || die "mv failed"
	mv readme.txt stealth/ || die "mv failed"

	games-mod_src_unpack_tidy
}
