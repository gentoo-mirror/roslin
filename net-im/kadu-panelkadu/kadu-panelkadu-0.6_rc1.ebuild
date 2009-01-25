# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_LDFLAGS="-lX11 -lXtst"
MOD_TYPE="ext"

inherit kadu-module

SRC_URI="http://www.ultr.pl/kadu/panelkadu-${K_PV}.tar.gz"
DESCRIPTION="Kadu module that transforms main window into panel"
HOMEPAGE="http://www.ultr.pl/kadu"
KEYWORDS="amd64 x86"
IUSE=""
