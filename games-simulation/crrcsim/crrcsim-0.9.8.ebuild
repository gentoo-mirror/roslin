# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Crrcsim is a model-airplane flight simulation program"
HOMEPAGE="http://crrcsim.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="portaudio"

RDEPEND=">=media-libs/libsdl-1.2
	virtual/glut
	>=media-libs/plib-1.8.4
	portaudio? ( >=media-libs/portaudio-18.1 )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:/usr/local/share/games/${PN}:${GAMES_DATADIR}/${PN}:" \
		-e "s:/usr/local/bin:${GAMES_BINDIR}:" \
		Makefile.linux || die "sed Makefile.linux failed"

	if use !portaudio ; then
		sed -i -e \
			"s:CRRC_LINKER_FLAGS +=:#CRRC_LINKER_FLAGS +=:" \
			Makefile.linux || die "sed portaudio Makefile.linux failed"
		sed -i -e \
			"s:COMPILE_AUDIO_INTERFACE 1:COMPILE_AUDIO_INTERFACE 0:" \
			crrc_config.h || die "sed portaudio crrc_config.h failed"
	fi

	mv Makefile.linux Makefile
}

src_compile() {
	emake \
		OPT_FLAGS="$(CFLAGS)" \
		|| die "emake failed"
}

src_install() {
	# We have some (a lot? ;) mess in documentation
	DOC="documentation"
	rm $DOC/Install_Win32.txt 
	dodoc $DOC/*.txt $DOC/README || die "dodoc failed"
	dohtml $DOC/*.html

	insinto ${GAMES_DATADIR}/${PN}/models
	doins models/*.xml || die "doins models failed"

	insinto ${GAMES_DATADIR}/${PN}/objects
	doins objects/*.ac || die "doins objects failed"

	insinto ${GAMES_DATADIR}/${PN}/scenery
	doins scenery/*.xml scenery/*.tga || die "doins scenery failed"

	insinto ${GAMES_DATADIR}/${PN}/sounds
	doins -r sounds/* || die "doins sounds failed"

	insinto ${GAMES_DATADIR}/${PN}/textures
	doins textures/*.rgb textures/*.bw || die "doins textures failed"

	dobin ${PN} || die "dobin ${PN} failed"

	newicon packages/icons/crrcsim.xpm ${PN}.xpm || die "newicon"
	make_desktop_entry ${PN} "CRRCsim" ${PN}

	prepgamesdirs
}
