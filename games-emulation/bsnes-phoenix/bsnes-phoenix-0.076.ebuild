# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils games

MY_PV="${PV/0./}"
MY_PV="${MY_PV/_/}"
MY_P="bsnes_v${MY_PV}-source"

DESCRIPTION="A Super Famicom/SNES emulator written with absolute accuracy in mind"
HOMEPAGE="http://byuu.org/bsnes/"
SRC_URI="http://bsnes.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ao alsa debug +gtk openal opengl oss profile_accuracy +profile_compatibility profile_performance pulseaudio qt4 sdl sgb xv"

REQUIRED_USE="|| ( ao openal alsa pulseaudio oss )
	|| ( xv opengl sdl )
	^^ ( profile_accuracy profile_compatibility profile_performance )
	^^ ( gtk qt4 )"

RDEPEND="ao? ( media-libs/libao )
	openal? ( media-libs/openal )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	xv? ( x11-libs/libXv )
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl[joystick] )
	sgb? ( dev-games/supergameboy )
	gtk? ( x11-libs/gtk+:2 )
	qt4? ( >=x11-libs/qt-gui-4.5:4 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/gcc-4.5
	!games-emulation/bsnes
	!games-emulation/bsnes-qt"

S="${WORKDIR}/${MY_P}/bsnes"

disable_module() {
	sed -i "ui/Makefile" -e "s|$1||"
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.075-makefile.patch \
		"${FILESDIR}"/${PN}-0.076-toolkit.patch

	# audio modules
	use ao || disable_module audio.ao
	use openal || disable_module audio.openal
	use pulseaudio || disable_module audio.pulseaudio
	use pulseaudio || disable_module audio.pulseaudiosimple
	use oss || disable_module audio.oss
	use alsa || disable_module audio.alsa

	# video modules
	use opengl || disable_module video.glx
	use xv || disable_module video.xv
	use sdl || disable_module video.sdl

	# input modules
	use sdl || disable_module input.sdl

	# debugger
	use debug && echo "flags += -DDEBUGGER" >>Makefile
}

src_compile() {
	local myprofile

	if use profile_accuracy; then
		myprofile="accuracy"
	elif use profile_compatibility; then
		myprofile="compatibility"
	else
		myprofile="performance"
	fi

	local mytoolkit
	if use gtk; then
		mytoolkit="gtk"
	else
		mytoolkit="qt"
	fi

	emake \
		platform=x \
		compiler=gcc \
		profile=${myprofile} \
		toolkit=${mytoolkit} || die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		prefix="${GAMES_PREFIX}" \
		install || die "install failed"

	dogamesbin out/bsnes || die

	prepgamesdirs
}
