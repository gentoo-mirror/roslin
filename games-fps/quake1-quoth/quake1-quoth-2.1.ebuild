# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="quoth"
MOD_TITLE="Quoth"
# The "hipnotic" expansion pack does *not* need to be installed.
MOD_MAP="start"

MOD_USES_TYRQUAKE=y

inherit games games-mod

SRC_KELL="http://kell.quaddicted.com/${MOD_DIR}"

DESCRIPTION="Quoth - Expansion pack for Quake 1"
HOMEPAGE="http://kell.quaddicted.com//"
SRC_URI="${SRC_KELL}/${MOD_DIR}.zip
	${SRC_ADDICT}/${MOD_DIR}.zip"
IUSE=""
