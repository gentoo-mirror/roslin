# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SRC_URI="http://myslenice.one.pl/~boogie/desc_history/desc_history-${PV}.tar.bz2"

MOD_TYPE="ext"
MOD_DEPEND=">=dev-db/sqlite-3.0.0"

inherit kadu-module

DESCRIPTION="Kadu module for status descriptions history"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""
