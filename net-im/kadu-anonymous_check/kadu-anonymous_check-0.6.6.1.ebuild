# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.9.0"

inherit kadu-base

MOD_URI="http://kadu.net/~patryk/${NAME}/${NAME}-${PV/_p/-}.tar.bz2"
MOD_TYPE="ext"

inherit kadu-mod

DESCRIPTION="Automatic sender lookup module for Kadu"
HOMEPAGE="http://kadu.net/~patryk"
KEYWORDS="amd64 x86"

IUSE=""
