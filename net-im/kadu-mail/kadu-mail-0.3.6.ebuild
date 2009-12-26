# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-notify-${MIN_VER}"
MOD_URI="http://kadu.net/~michal/${NAME}/${NAME}-${PV}.tar.bz2"
MOD_TYPE="ext"

inherit kadu-mod

DESCRIPTION="Mail checker module for Kadu"
HOMEPAGE="http://kadu.net/~michal"
KEYWORDS="amd64 x86"

IUSE=""
