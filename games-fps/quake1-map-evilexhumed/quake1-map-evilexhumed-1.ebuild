# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_USES_QRACK=y
MOD_USES_JOEQUAKE=y
MOD_USES_TYRQUAKE=y

MOD_DIR="id1"
MOD_MAP="${PN/quake1-map-/}"
MOD_TITLE="Evil Exhumed"

inherit eutils games games-mod

DESCRIPTION="Evil Exhumed by Willem (Warren Marshall)"
HOMEPAGE="http://www.celephais.net/board/view_thread.php?id=60261"
SRC_URI="http://wantonhubris.com/levels/${MOD_MAP}/EvilExhumed.zip"
IUSE=""
