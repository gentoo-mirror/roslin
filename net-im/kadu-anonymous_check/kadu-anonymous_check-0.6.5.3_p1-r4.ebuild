# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-notify-${MIN_VER}"
MOD_URI="http://grubelek.pl/mziab/${NAME}-${PV/_p/-}.tar.bz2"
MOD_TYPE="ext"

inherit kadu-mod

DESCRIPTION="Automatic sender lookup module for Kadu"
HOMEPAGE="http://kadu.net/~patryk"
KEYWORDS="amd64 x86"

IUSE=""
