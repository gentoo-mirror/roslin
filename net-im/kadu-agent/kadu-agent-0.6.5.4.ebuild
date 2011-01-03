# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.5.4"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-notify-${MIN_VER}"

inherit kadu-mod

DESCRIPTION="Kadu module for checking who has you on their list"
HOMEPAGE="http://kadu.net/"
KEYWORDS="amd64 x86"

IUSE=""
