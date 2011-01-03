# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_USES_QRACK=y
MOD_USES_TYRQUAKE=y

MOD_DIR="quoth"
MOD_MAP="chapter_necros2"

#MOD_CMDLINE_END="-game quoth +map ${MOD_MAP}"

MOD_TITLE="Are you yet Living?"
MOD_CMDLINE_START="-hipnotic"
MOD_RDEPEND_EXTRA="games-fps/quake1-quoth"

inherit eutils games games-mod

DESCRIPTION="Are you yet Living? for Quoth"
HOMEPAGE="http://www.celephais.net/board/view_thread.php?id=60263"
SRC_URI="http://shub-hub.com/files/maps_singleplayer/${MOD_MAP}.zip"
IUSE=""
KEYWORDS="~x86"
