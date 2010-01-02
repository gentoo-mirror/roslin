# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="arcade"
MOD_TITLE="Arcade Quake"

inherit games games-mod

DESCRIPTION="2D Quake!"
HOMEPAGE="http://qexpo.tastyspleen.net/booth.php?id=124&page=260"
SRC_URI="http://darkmaster.quakedev.com/files/arcQuake_QE2008_demo.7z"
IUSE=""

MOD_DEPEND="app-arch/p7zip"

S=${WORKDIR}
dir=${GAMES_DATADIR}/quake1

#src_unpack() {
#	unpack ${A}
#	cd "${S}"
#
#	rm  || die "rm failed"
#}
