# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="A Super Famicom/SNES emulator written with absolute accuracy in mind"
HOMEPAGE="http://byuu.cinnamonpirate.com/bsnes/"
MY_PV="${PV/0./}"
SRC_URI="http://byuu.cinnamonpirate.com/files/${PN}_v${MY_PV}.tar.bz2"

LICENSE="bsnes"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ao alsa jma openal opengl oss pulseaudio sdl xv zlib"

DEPEND="ao? ( media-libs/libao )
	openal? ( media-libs/openal )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	xv? ( x11-libs/libXv )
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl )
	x11-libs/gtk+
	x11-libs/libXtst"

RDEPEND="${DEPEND}"

RESTRICT="strip"

S=${WORKDIR}/src

disable_module() {
	sed -i Makefile -e "s|$1 ||"
}

pkg_setup() {
	if ! use ao && ! use openal && ! use alsa && ! use pulseaudio && ! use oss
	then
	    die "You need to select at least one audio backend."
	fi
	
	if ! use xv && ! use opengl && ! use sdl
	then
	    die "You need to select at least one video backend."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	
	epatch "${FILESDIR}"/${PN}-makefile.patch
}


src_compile() {
	# audio modules
	use ao || disable_module audio.ao
	use openal || disable_module audio.openal
	use pulseaudio || disable_module audio.pulseaudio
	use oss || disable_module audio.oss
	use alsa || disable_module audio.alsa

	# video modules
	use opengl || disable_module video.glx
	use xv || disable_module video.xv
	use sdl || disable_module video.sdl

	# input modules
	use sdl || disable_module input.sdl

	local myconf
	use zlib && myconf="enable_gzip=true"
	use jma && myconf="${myconf} enable_jma=true"

	emake platform=x compiler=gcc ${myconf} || die "emake failed"
}

src_install() {
	dogamesbin ../${PN} || die "failed bin"
	doicon data/${PN}.png || die "failed icon"
	#dodoc ../*.txt || die "failed docs"
	make_desktop_entry ${PN}

	prepgamesdirs
}

