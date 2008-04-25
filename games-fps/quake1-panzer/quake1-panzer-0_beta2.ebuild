# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="panzer"
MOD_TITLE="Panzer"
MOD_USES_TYRQW=y

inherit games games-mod

DESCRIPTION="Team-based mild strategy game."
HOMEPAGE="http://quakematt.quakedev.com/panzer.php"
SRC_URI="http://quakematt.quakedev.com/downloads/panzer_beta2.zip"

S=${WORKDIR}
dir=${GAMES_DATADIR}/quake1

src_unpack() {
	unpack ${A}
	cd ${S}

	rm demo1.dem autoexec.cfg || die "rm failed"
}
