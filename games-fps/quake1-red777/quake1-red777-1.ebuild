# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="quoth"
MOD_MAP="red777"
MOD_CMDLINE_START="-hipnotic"
MOD_RDEPEND_EXTRA="games-fps/quake1-quoth"

inherit eutils games games-mod

SRC_KELL="http://kell.leveldesign.org/${MOD_MAP}"
DESCRIPTION="Red777"
HOMEPAGE="http://kell.leveldesign.org/"
SRC_URI="${SRC_KELL}/${MOD_MAP}.zip"
