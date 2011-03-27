# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="dd"
MOD_TITLE="Death's Dominion"
MOD_CMDLINE_OPTIONS="-hipnotic -game ${MOD_DIR}"
MOD_RDEPEND_EXTRA="games-fps/quake1-soa"

inherit eutils games games-mod

DESCRIPTION="Death's Dominion Level Pack for Scourge of Armagon"
# no homepage, but we will use this
HOMEPAGE="http://www.quaddicted.com/reviews/dd.html"
SRC_URI="${SRC_ADDICT}/dd.zip"
IUSE=""
