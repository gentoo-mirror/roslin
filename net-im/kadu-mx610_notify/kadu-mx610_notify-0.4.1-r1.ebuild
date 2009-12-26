# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4_rc1"

inherit kadu-base

MOD_TYPE="ext"
MOD_DEPEND=">=net-im/kadu-notify-${MIN_VER}"
MOD_URI="http://www.kadu.net/~dorr/moduly/${P}.tar.bz2"

inherit kadu-mod

DESCRIPTION="Kadu notification using Logitech MX 610's mouse leds"
HOMEPAGE="http://kadu.net/~dorr"
KEYWORDS="~amd64 ~x86"

IUSE=""
