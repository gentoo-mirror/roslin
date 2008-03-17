# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_USES_QRACK=y
MOD_USES_JOEQUAKE=y

MOD_DIR="fort_ratsack"
MOD_MAP="base_debris"

MOD_TITLE="Attack On Fort Ratsack"
MOD_RDEPEND="games-fps/quake1-quoth"

inherit eutils games games-mod

DESCRIPTION="Attack On Fort Ratsack! - part of dead Base Pack for Quoth"
HOMEPAGE="http://www.celephais.net/board/view_thread.php?id=60179"
SRC_URI="http://biff.leveldesign.org/maps/q1/sp/${MOD_MAP}.zip
	${SRC_ADDICT}/${MOD_MAP}.zip"
