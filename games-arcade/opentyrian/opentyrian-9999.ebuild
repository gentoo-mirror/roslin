# Copyright 2007-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion

PN_DATA="tyrian21"

DESCRIPTION="Port of the classic DOS game Tyrian to C using SDL"
HOMEPAGE="http://code.google.com/p/opentyrian/"
SRC_URI="http://it.travisbsd.org/foo/tyrian/tyrian21.zip
	http://darklomax.org/tyrian/tyrian21.zip"

ESVN_REPO_URI="http://opentyrian.googlecode.com/svn/classic/trunk/"
ESVN_PROJECT="${PN}"

LICENSE="GPL-2"
RESTRICT="nomirror"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="media-libs/libsdl"

S="${WORKDIR}/${PN}"
SD="${WORKDIR}/${PN_DATA}"

dir="${GAMES_DATADIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${SD}"
	rm *.exe *.int *.txt file_id.diz
	rm order.* setup.* shipedit.* helpme.*

	subversion_src_unpack
	cd "${S}"

	if use !debug; then
		sed -i \
			-e "s|DEBUG := 1|DEBUG := 0|" \
			Makefile || die "sed failed"
	fi

	sed -i \
		-e "s|sdl-config --cflags)|sdl-config --cflags) ${CFLAGS}|" \
		-e "s|sdl-config --libs)|sdl-config --libs) ${LDFLAGS}|" \
		Makefile || die "sed failed"
}

src_install() {
	exeinto "${dir}"
	doexe ${PN/open/} || die "doexe failed"

	games_make_wrapper ${PN} ./${PN/open/} "${dir}"

	cd "${SB}"
	insinto "${dir}"
	doins * || die "doins failed"

	dodoc COMMENTS LICENSE-TEMPLATE README || die "dodoc failed"
}
