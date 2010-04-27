# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_USES_QRACK=y
MOD_USES_TYRQUAKE=y

MOD_DIR="warpspasm"
MOD_MAP="qt_pre02"

#MOD_CMDLINE_END="-game quoth +map ${MOD_MAP}"

MOD_TITLE="Grendel's Keep"
MOD_CMDLINE_START="-hipnotic"
MOD_RDEPEND="games-fps/quake1-warpspasm"

inherit eutils games games-mod

DESCRIPTION="Travail prequel level Grendel's Keep"
HOMEPAGE="http://qexpo.tastyspleen.net/booth.php?id=77&page=354"
SRC_URI="http://www.quaddicted.com/filebase/qt_pre02.zip"
IUSE=""
KEYWORDS="~x86"
