# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_USES_QRACK=y
MOD_USES_JOEQUAKE=y
MOD_USES_TYRQUAKE=y

MOD_DIR="quoth"
MOD_MAP="src2"

#MOD_CMDLINE_END="-game quoth +map ${MOD_MAP}"

MOD_TITLE="Slime Refinery Complex"
MOD_RDEPEND="games-fps/quake1-quoth"

inherit eutils games games-mod

DESCRIPTION="Slime Refinery Complex for Quoth"
HOMEPAGE="http://www.celephais.net/board/view_thread.php?id=60175"
SRC_URI="http://lambert.jeanphilippe.free.fr/DownLoad/src2.zip"
