# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games qt4

DESCRIPTION="Game based on the long-running Bomberman franchise"
HOMEPAGE="http://axem.boo.pl/maxem"
SRC_URI="http://axem.boo.pl/maxem/${PN}/${PN}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="editor"

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	editor? ( $(qt4_min_version 4.2) )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	rm ${PN} ${PN}-leveleditor

	tar xvjf ${PN}-src.tar.bz2

	sed -i \
		-e "s|-mtune=i686 -o2 -Wall -pedantic|${CFLAGS}|" \
		${PN}-src/Makefile || die "sed"
	
	if use editor ; then
		tar xvjf ${PN}-leveleditor-src.tar.bz2
		
		sed -i \
			-e "s|-pipe -O2 -Wall -W -D_REENTRANT|FLAGI|" \
			-e "s|CFLAGS        = FLAGI|CFLAGS = ${CFLAGS}|" \
			-e "s|CXXFLAGS      = FLAGI|CXXFLAGS = ${CXXFLAGS}|" \
			-e "s|/usr/lib/qt4/mkspecs|/usr/share/qt4/mkspecs|" \
			-e "s|lib/qt4/mkspecs/common/unix.conf|share/qt4/mkspecs/common/unix.conf|" \
			-e "s|/usr/lib/qt4/bin/qmake|/usr/bin/qmake|" \
			${PN}-leveleditor-src/Makefile || die "sed"
	fi
}

src_compile() {
	cd ${S}/${PN}-src
	emake || die "emake failed"

	if use editor ; then
		cd ${S}/${PN}-leveleditor-src
		emake || die "emake failed"
	fi
}

src_install() {
	insinto "${dir}"
	doins -r gfx levels sfx

	exeinto "${dir}"
	doexe ${PN}-src/${PN}

	if use editor ; then
		doexe ${PN}-leveleditor-src/${PN}-leveleditor
	fi

	dodoc README

	newicon data/icon.png ${PN}.png

	make_desktop_entry ${PN} "Bomb Attack" ${PN}.png Game
	games_make_wrapper ${PN} "./${PN}" "${GAMES_DATADIR}/${PN}"

	if use editor ; then
		make_desktop_entry ${PN} "Bomb Attack - Level Editor" ${PN}.png Game
		games_make_wrapper ${PN}-leveleditor "./${PN}-leveleditor" "${GAMES_DATADIR}/${PN}"
	fi

	prepgamesdirs
}
