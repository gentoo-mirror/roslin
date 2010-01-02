# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4_rc2"

inherit kadu-base

MOD_URI="http://www.ultr.pl/kadu/${NAME}-${PV/_p/-}.tar.gz"
MOD_TYPE="ext"
MOD_PATCHES="silentmode-api-fix.patch"

inherit kadu-mod

DESCRIPTION="Global hotkey module for Kadu"
HOMEPAGE="http://www.ultr.pl/kadu/"
KEYWORDS="~amd64 ~x86"

IUSE=""
