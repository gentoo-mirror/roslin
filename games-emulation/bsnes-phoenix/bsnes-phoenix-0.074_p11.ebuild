# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils confutils games

MY_PV="${PV/0./}"
MY_PV="${MY_PV/_p/r}"
MY_PV="${MY_PV/_/}"

DESCRIPTION="A Super Famicom/SNES emulator written with absolute accuracy in mind"
HOMEPAGE="http://byuu.org/bsnes/"
SRC_URI="http://bsnes.googlecode.com/files/bsnes_v${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ao alsa openal opengl oss profile_accuracy +profile_compatibility profile_performance pulseaudio sdl sgb xv"

RDEPEND="ao? ( media-libs/libao )
	openal? ( media-libs/openal )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	xv? ( x11-libs/libXv )
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl[joystick] )
	sgb? ( dev-games/supergameboy )
	x11-libs/gtk+:2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/gcc-4.5
	!games-emulation/bsnes
	!games-emulation/bsnes-qt"

S="${WORKDIR}"

disable_module() {
	sed -i "ui/Makefile" -e "s|$1||"
}

pkg_setup() {
	confutils_require_any ao openal alsa pulseaudio oss
	confutils_require_any xv opengl sdl
	confutils_require_one profile_accuracy profile_compatibility profile_performance
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch

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

	emake platform=x compiler=gcc profile=${myprofile} || die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		prefix="${GAMES_PREFIX}" \
		install || die "install failed"

	dogamesbin out/bsnes || die

	prepgamesdirs
}
