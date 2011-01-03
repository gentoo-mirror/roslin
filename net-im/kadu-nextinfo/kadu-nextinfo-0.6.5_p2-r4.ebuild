# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4"

inherit kadu-base

MOD_URI="http://www.ultr.pl/kadu/${NAME}-${PV/_p/-}.tar.gz"
MOD_DEPEND=">=net-im/kadu-notify-${MIN_VER}"
MOD_TYPE="ext"

inherit kadu-mod

DESCRIPTION="A module providing extended contact information support"
HOMEPAGE="http://www.ultr.pl/kadu"
KEYWORDS="amd64 x86"
IUSE=""
