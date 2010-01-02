# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4_rc1"

inherit kadu-base

MOD_TYPE="ext"
MOD_DEPEND=">=net-im/kadu-notify-${MIN_VER}"
MOD_URI="http://kadu.net/~blysk/${NAME}-${PV}.tar.bz2"

inherit kadu-mod

DESCRIPTION="LED notification module for Kadu"
HOMEPAGE="http://kadu.net/~blysk"
KEYWORDS="~amd64 ~x86"

IUSE=""
