# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="aop"
MOD_TITLE="Abyss Of Pandemonium"
MOD_MAP="start"

#MOD_USES_TYRQUAKE=y

inherit games games-mod

DESCRIPTION="Abyss Of Pandemonium - The Final Mission v2.0"
HOMEPAGE="http://qexpo.tastyspleen.net/booth.php?id=117"
SRC_URI="http://www.quakeone.com/aop/AOP-The_Final_Mission_v2.0.rar"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"

	mv "AOP - The Final Mission v2.0" "${MOD_DIR}"
	for i in "${MOD_DIR}"/*\ *; do mv "$i" "${i//\ /_}"; done

	games-mod_src_unpack_tidy
}
