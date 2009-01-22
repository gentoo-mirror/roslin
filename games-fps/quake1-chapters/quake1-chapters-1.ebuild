# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="chapters"
MOD_TITLE="Contract Revoked: Lost Chapters"
# The "hipnotic" expansion pack does *not* need to be installed.
MOD_CMDLINE_START="-hipnotic"
MOD_MAP="start"

inherit games games-mod

SRC_KELL="http://kell.leveldesign.org/${MOD_DIR}"

DESCRIPTION="Contract Revoked: Lost Chapters - Quake 1 single-player pack"
HOMEPAGE="http://kell.leveldesign.org/"
SRC_URI="${SRC_ADDICT}/${MOD_FILENAME}
	${SRC_KELL}/${MOD_FILENAME}"
IUSE=""
