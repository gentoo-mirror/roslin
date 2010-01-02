# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="nehahra"
MOD_MAP="mael"
MOD_CMDLINE_OPTIONS="-nehahra"
MOD_RDEPEND_EXTRA="games-fps/quake1-nehahra"

MOD_USES_JOEQUAKE="y"
MOD_USES_QRACK="y"

inherit eutils games games-mod

DESCRIPTION="Descent into the Maelstrom"
HOMEPAGE=""
SRC_URI="http://www.quaddicted.com/filebase/maelstromv2.zip
	http://shub-hub.quaddicted.com/files/maps_singleplayer/maelstromv2.zip"
IUSE=""
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}

	# some removes, deletes
	rm Quake/Nehahra/mael.wad || die "rm mael.wad failed"
	rm -rf Quake/Nehahra/gfx || die "rm gfx failed"

	mv Quake/Nehahra/* .
	rm -rf Quake
	games-mod_src_unpack_tidy
}
