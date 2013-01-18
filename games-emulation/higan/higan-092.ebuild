# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils games toolchain-funcs

MY_PV="${PV/0./}"
MY_PV="${MY_PV/_/}"
MY_P="${PN}_v${MY_PV}-source"

DESCRIPTION="A Nintendo multi-system emulator (formerly called bsnes)"
HOMEPAGE="http://byuu.org/higan/"
SRC_URI="http://higan.googlecode.com/files/${MY_P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ao alsa +ananke gtk openal opengl oss profile_accuracy +profile_balanced profile_performance pulseaudio +qt4 sdl xv"

RDEPEND="ananke? ( dev-games/ananke )
	ao? ( media-libs/libao )
	openal? ( media-libs/openal )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	xv? ( x11-libs/libXv )
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl[joystick] )
	gtk? ( x11-libs/gtk+:2 )
	qt4? ( >=x11-libs/qt-gui-4.5:4 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gcc-4.6"

S="${WORKDIR}/${MY_P}/${PN}"

REQUIRED_USE="|| ( ao openal alsa pulseaudio oss )
	|| ( xv opengl sdl )
	^^ ( profile_accuracy profile_balanced profile_performance )
	^^ ( gtk qt4 )"

disable_module() {
	sed -i "target-ethos/Makefile" -e "s|$1||"
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

	# regenerate .moc if needed
	if use qt4; then
		cd phoenix/qt && moc -i -I. -o platform.moc platform.moc.hpp
	fi
}

src_compile() {
	local myprofile

	if use profile_accuracy; then
		myprofile="accuracy"
	elif use profile_balanced; then
		myprofile="balanced"
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
		platform="x" \
		compiler="$(tc-getCXX)" \
		profile="${myprofile}" \
		phoenix="${mytoolkit}" || die "emake failed"

	sed -e "s:%GAMES_DATADIR%:${GAMES_DATADIR}:" \
		< "${FILESDIR}/higan-launcher" \
		> out/higan-launcher \
		|| die "sed failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		prefix="${GAMES_PREFIX}" \
		install || die "install failed"

	# install higan and our wrapper
	newgamesbin out/higan higan.real
	newgamesbin out/higan-launcher higan

	# copy home directory stuff to a global location
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/cheats.bml profile/*

	# install shaders
	if use opengl; then
		insinto "${GAMES_DATADIR}/${PN}/Video Shaders"
		doins ../shaders/*OpenGL*.shader || die
	fi

	prepgamesdirs
}
