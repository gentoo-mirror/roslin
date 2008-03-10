# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="quoth"
MOD_TITLE="Quoth"
# The "hipnotic" expansion pack does *not* need to be installed.
MOD_MAP="start"

inherit games games-mod

SRC_KELL="http://kell.leveldesign.org/${MOD_DIR}"

DESCRIPTION="Quoth - Expansion pack for Quake 1"
HOMEPAGE="http://kell.leveldesign.org/"
SRC_URI="${SRC_ADDICT}/${MOD_FILENAME}
	${SRC_KELL}/${MOD_FILENAME}"
