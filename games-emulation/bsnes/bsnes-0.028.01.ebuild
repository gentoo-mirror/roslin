# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="A Super Famicom/SNES emulator written with absolute accuracy in mind"
HOMEPAGE="http://byuu.cinnamonpirate.com/bsnes/"
MY_PV="${PV/.0/}"
MY_PV="${MY_PV/./_}"
SRC_URI="http://byuu.cinnamonpirate.com/files/${PN}_v${MY_PV}.tar.bz2"

LICENSE="bsnes"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jma zip"

DEPEND="media-libs/freealut
	x11-libs/gtk+
	media-libs/libsdl
	virtual/opengl"

RDEPEND="${DEPEND}"

S=${WORKDIR}/src

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s|flags = -O3 -fomit-frame-pointer|flags = ${CXXFLAGS}|" \
		Makefile || die "sed"
}


src_compile() {
	local MY_USE
	use zip && MY_USE="enable_gzip=true"
	use jma && MY_USE="${MY_USE} enable_jma=true"
	
	emake platform=x compiler=gcc ${MY_USE} || die "emake failed"
}

src_install() {
	dogamesbin ../${PN} || die "failed bin"
	doicon data/${PN}.png || die "failed icon"
	dodoc ../*.txt || die "failed docs"
	make_desktop_entry ${PN}

	prepgamesdirs
}

