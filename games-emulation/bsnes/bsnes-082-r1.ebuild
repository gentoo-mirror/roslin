# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils confutils games

MY_PV="${PV/0./}"
MY_PV="${MY_PV/_/}"
MY_P="${PN}_v${MY_PV}-source"

DESCRIPTION="A Super Famicom/SNES emulator written with absolute accuracy in mind"
HOMEPAGE="http://byuu.org/bsnes/"
SRC_URI="http://bsnes.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ao alsa debug +gtk openal opengl oss profile_accuracy +profile_compatibility profile_performance pulseaudio qt4 sdl snesfilter xv"

RDEPEND="ao? ( media-libs/libao )
	openal? ( media-libs/openal )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	xv? ( x11-libs/libXv )
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl[joystick] )
	gtk? ( x11-libs/gtk+:2 )
	qt4? ( >=x11-libs/qt-gui-4.5:4 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/gcc-4.5"

S="${WORKDIR}/${MY_P}/bsnes"

disable_module() {
	sed -i "ui/Makefile" -e "s|$1||"
}

pkg_setup() {
	confutils_require_any ao openal alsa pulseaudio oss
	confutils_require_any xv opengl sdl
	confutils_require_one profile_accuracy profile_compatibility profile_performance
	confutils_require_one gtk qt4
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-077-makefile.patch \
		"${FILESDIR}"/${P}-global-paths.patch

	sed -e "s:%GAMES_DATADIR%:${GAMES_DATADIR}:" \
		-i "${S}/ui/tools/cheat-database.cpp" \
		-i "${S}/ui/general/main-window.cpp" \
		|| die "sed failed"

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
		cd phoenix/qt && moc -i -I. -o qt.moc qt.moc.hpp
	fi
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

	local myoptions
	use debug && myoptions="debugger"

	emake \
		platform=x \
		compiler=gcc \
		profile=${myprofile} \
		phoenix=${mytoolkit} \
		options=${myoptions} || die "emake failed"

	if use snesfilter; then
		emake \
			compiler=gcc \
			link="" \
			-C "${S}/../snesfilter" \
			|| die "emake failed"
	fi
}

src_install() {
	emake \
		DESTDIR="${D}" \
		prefix="${GAMES_PREFIX}" \
		install || die "install failed"

	dogamesbin out/bsnes || die

	# install cheat db
	insinto "${GAMES_DATADIR}/${PN}"
	doins data/cheats.xml || die

	# install shaders
	insinto "${GAMES_DATADIR}/${PN}/shaders"
	doins ../snesshader/*OpenGL*.shader || die

	# install filters
	if use snesfilter; then
		insinto "${GAMES_DATADIR}/${PN}/filters"
		doins ../snesfilter/out/*.filter || die
	fi

	prepgamesdirs
}
