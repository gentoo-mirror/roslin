# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="quoth"
MOD_MAP="kellmet1"
MOD_CMDLINE_START="-hipnotic"
MOD_RDEPEND_EXTRA="games-fps/quake1-quoth"

inherit eutils games games-mod

SRC_KELL="http://kell.quaddicted.com/${MOD_MAP}"
DESCRIPTION="I pity thee not - map for Quoth"
HOMEPAGE="http://kell.quaddicted.com/"
SRC_URI="${SRC_KELL}/${MOD_MAP}.zip"
IUSE=""
