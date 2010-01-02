# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_USES_QRACK=y
MOD_USES_JOEQUAKE=y
MOD_USES_TYRQUAKE=y

MOD_DIR="id1"
MOD_MAP="wishes"
MOD_TITLE="The Well of Wishes"

inherit eutils games games-mod

DESCRIPTION="The Well of Wishes"
HOMEPAGE="http://www.quaddicted.com/wishes.html"
SRC_URI="${SRC_ADDICT}/${MOD_MAP}.zip"
IUSE=""
KEYWORDS="~x86"
