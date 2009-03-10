# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils confutils games

DESCRIPTION="A Super Famicom/SNES emulator written with absolute accuracy in mind"
HOMEPAGE="http://byuu.cinnamonpirate.com/bsnes/"
MY_PV="${PV/0./}"
SRC_URI="http://byuu.cinnamonpirate.com/files/${PN}_v${MY_PV}.tar.bz2"

LICENSE="bsnes"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ao alsa jma openal opengl -gtk oss pulseaudio +qt4 sdl xv zlib"

DEPEND="ao? ( media-libs/libao )
	openal? ( media-libs/openal )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	xv? ( x11-libs/libXv )
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl[joystick] )
	gtk? ( x11-libs/gtk+
	x11-libs/libXtst )
	qt4? ( >=x11-libs/qt-gui-4.4 )"

RDEPEND="${DEPEND}"

RESTRICT="strip"

S=${WORKDIR}/src

disable_module() {
	sed -i Makefile -e "s|$1 ||"
}

pkg_setup() {
	confutils_require_any ao openal alsa pulseaudio oss
	confutils_require_any xv opengl sdl
	confutils_require_one gtk qt4
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	
	# select gui
	if use gtk
	then
	    sed -e "s/ui_qt/ui_hiro/" \
	-i Makefile || die "sed failed"
	fi
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

