# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.9.1"

inherit kadu-base

MY_PV="${PV/_p/-}"
MY_PV="${MY_PV/0.9.0/0.9.x}"

MOD_URI="http://www.ultr.pl/kadu/${NAME}-${MY_PV}.tar.gz"
MOD_TYPE="ext"

inherit kadu-mod

DESCRIPTION="Adds history of sent messages to Kadu chat window"
HOMEPAGE="http://www.ultr.pl/kadu/"
KEYWORDS="amd64 x86"

IUSE=""
