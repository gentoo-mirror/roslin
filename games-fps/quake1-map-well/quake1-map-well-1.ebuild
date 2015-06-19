# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_USES_QRACK=y
MOD_USES_TYRQUAKE=y

MOD_DIR="id1"
MOD_MAP="${PN/quake1-map-/}"
MOD_TITLE="The Well of Lost Souls"

inherit eutils games games-mod

DESCRIPTION="The Well of Lost Souls"
HOMEPAGE="http://www.quaddicted.com/well.html"
SRC_URI="${SRC_ADDICT}/${MOD_MAP}.zip"
IUSE=""
KEYWORDS="~x86"
