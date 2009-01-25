# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SRC_URI="http://www.ultr.pl/kadu/nextinfo-${PV/_p/-}.tar.gz"

inherit kadu

MOD_DEPEND=">=net-im/kadu-notify-${MIN_REQ}"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="A module providing extended contact information support"
HOMEPAGE="http://www.ultr.pl/kadu"
KEYWORDS="amd64 x86"
IUSE=""
