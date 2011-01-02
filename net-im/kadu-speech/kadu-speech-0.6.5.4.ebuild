# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4"

inherit kadu-base

MOD_DEPEND="app-accessibility/powiedz
>=net-im/kadu-notify-${MIN_VER}"

inherit kadu-mod

DESCRIPTION="Reads Kadu messages with the powiedz speech synthetizer"
HOMEPAGE="http://kadu.net/~blysk"
KEYWORDS="amd64 x86"

IUSE=""
