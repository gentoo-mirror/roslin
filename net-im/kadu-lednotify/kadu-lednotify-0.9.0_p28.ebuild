# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.9.0"

inherit kadu-base

MOD_TYPE="ext"
MOD_URI="http://www.ultr.pl/kadu/${NAME}-${PV/_p/-}.tar.gz"

inherit kadu-mod

DESCRIPTION="LED notification module for Kadu"
HOMEPAGE="http://www.ultr.pl/kadu"
KEYWORDS="~amd64 ~x86"

IUSE=""
