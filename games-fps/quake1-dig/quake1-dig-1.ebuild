# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="dig"
MOD_MAP="dig"
MOD_TITLE="The Dig"

inherit eutils games games-mod

DESCRIPTION="The Dig - small SP episode for Quake 1"
HOMEPAGE=""
SRC_URI="http://shub-hub.quaddicted.com/files/maps_singleplayer/dig.zip
	http://www.quaddicted.com/filebase/dig.zip"
IUSE=""

dir=${GAMES_DATADIR}/quake1/${MOD_DIR}

src_unpack() {
	unpack ${A}
	mv dig29\ readme.txt readme.txt || die "mv failed"
}

src_install() {
	insinto "${dir}"
	doins -r maps progs sound progs.dat || die "doins failed"

	dodoc *.txt || die "dodoc failed"

	if use darkplaces ; then
		games_make_wrapper darkplaces-${MOD_DIR} \
			"darkplaces -game ${MOD_DIR} +map ${MOD_DIR}"
		make_desktop_entry darkplaces-${MY_PN} \
			"Dark Places - The Dig" darkplaces.png
	fi

	prepgamesdirs
}
