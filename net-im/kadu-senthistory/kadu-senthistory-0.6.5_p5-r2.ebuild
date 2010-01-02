# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4_rc2"

inherit kadu-base

MOD_URI="http://www.ultr.pl/kadu/${NAME}-${PV/_p/-}.tar.gz"
MOD_TYPE="ext"

inherit kadu-mod

DESCRIPTION="Adds history of sent messages to Kadu chat window"
HOMEPAGE="http://www.ultr.pl/kadu/"
KEYWORDS="~amd64 ~x86"

IUSE=""