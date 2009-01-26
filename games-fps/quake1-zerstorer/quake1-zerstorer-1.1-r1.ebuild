# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_TITLE="Zerstorer"
MOD_DIR="zer"

MOD_USES_QRACK=y
MOD_USES_TYRQUAKE=y

inherit eutils versionator games games-mod

MY_PV=$(delete_all_version_separators)
# Has "oe" in directory names, just to be confusing
SRC_PM="ftp://ftp.planetmirror.com/pub/idgames2/partial_conversions/zerstoerer"
SRC_B="ftp://ftp.fu-berlin.de/pc/games/idgames2/partial_conversions/zerstoerer"
SRC_G="http://www.gamers.org/pub/idgames2/partial_conversions/zerstoerer"

DESCRIPTION="Story-driven Quake 1 campaign with new weapons and monsters"
HOMEPAGE="http://shotgun1.shackspace.com/"

SRC_URI="${SRC_PM}/${MOD_DIR}.zip
	${SRC_B}/${MOD_DIR}.zip
	${SRC_ADDICT}/${MOD_DIR}.zip
	${SRC_G}/${MOD_DIR}.zip
	${SRC_PM}/${MOD_DIR}${MY_PV}.zip
	${SRC_B}/${MOD_DIR}${MY_PV}.zip
	${SRC_ADDICT}/${MOD_DIR}${MY_PV}.zip
	${SRC_G}/${MOD_DIR}${MY_PV}.zip
	vispatch? ( http://mlodyinteligent.pl/~lazy_bum/quake-vis/zervis.zip )"

IUSE="vispatch"

DEPEND="vispatch? (
		games-util/vispatch
		app-arch/zip
		)"

src_unpack() {
	unpack ${A}

	rm DEVKIT.* *.{DAT,CFG}

	if use vispatch; then
		mv PAK0.PAK pak0.pak
		vispatch -dir "${S}" -data "${S}"/zer.vis \
			|| die "vispatch failed"
		# Clean the vis files
		rm zer.vis zer.dat
	fi

	games-mod_src_unpack_tidy
}
