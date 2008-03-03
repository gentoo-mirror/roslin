# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# See disclaimers section in nehahra.txt for license
MOD_DIR="nehahra"
MOD_IUSE="movie"
# Might be able to download from ${SRC_ADDICT} in the future
MOD_RESTRICT="fetch mirror"
# Only darkplaces can run it stably
MOD_CMDLINE_OPTIONS="-nehahra"

MOD_USES_JOEQUAKE="y"
MOD_USES_QRACK="y"

inherit eutils games games-mod

DESCRIPTION="Classic story-driven mission & movie pack"
HOMEPAGE="http://nehahra.planetquake.gamespy.com/"
SRC_URI="movie? ( The_Seal_Of_Nehahra.zip )
	nehahra1.zip
	nehahra2.zip
	nehahra3.zip
	elek_neh_episode4.zip
	nehupdate3.zip
	nehmusicfix.zip"

src_unpack() {
	unpack ${A}

	# neh5.xm and NEH5.xm (from elek_neh_episode4.zip) are identical
	rm Quake/"${MOD_DIR}"/mods/NEH5.xm || die "rm NEH5.xm failed"

	if ! use movie ; then
		# Use tiny dummy pak0.pak file instead of 30mb one
		unpack ./QUAKE/nehahra/pak0.zip
	fi
	rm QUAKE/"${MOD_DIR}"/pak0.zip

	mv QUAKE/"${MOD_DIR}" .
	mv Quake/"${MOD_DIR}"/maps "${MOD_DIR}"
	mv Quake/"${MOD_DIR}"/mods/* "${MOD_DIR}"/mods
	rm -rf Quake QUAKE

	games-mod_src_unpack_tidy
}
