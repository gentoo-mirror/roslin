# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils confutils games

MY_PV="${PV/0./}"
MY_PV="${MY_PV/_/}"

DESCRIPTION="A Super Famicom/SNES emulator written with absolute accuracy in mind"
HOMEPAGE="http://byuu.org/bsnes/"
SRC_URI="http://bsnes.googlecode.com/files/${PN}_v${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ao alsa debug openal opengl oss pulseaudio sdl sgb snesfilter +snesreader xv"

RDEPEND="ao? ( media-libs/libao )
	openal? ( media-libs/openal )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	xv? ( x11-libs/libXv )
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl[joystick] )
	snesfilter? ( sys-devel/gcc[openmp] )
	>=x11-libs/qt-gui-4.5:4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/gcc-4.4"

S="${WORKDIR}/${PN}"

disable_module() {
	sed -i "ui-qt/Makefile" -e "s|$1||"
}

build_plugin() {
	einfo "Building $1..."

	emake \
	    -C "${WORKDIR}/$1" \
	    platform=x \
	    compiler=gcc \
	    || die "emake $1 failed"
}

install_plugin() {
	emake \
	    -C "${WORKDIR}/$1" \
	    prefix="/usr" \
	    DESTDIR="${D}" install \
	    || die "install $1 failed"
}

pkg_setup() {
	confutils_require_any ao openal alsa pulseaudio oss
	confutils_require_any xv opengl sdl
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.071-makefile.patch

	# debugger
	if use debug ; then
	    sed -i "snes/snes.hpp" \
		-e "s://\(#define DEBUGGER\):\\1:" \
		|| die "sed failed"
	fi

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
	for i in accuracy compatibility performance; do
		emake platform=x compiler=gcc profile=$i || die "emake failed"
		make clean
	done

	cd launcher && sh cc.sh || die

	# build bundled plugins
	use snesfilter && build_plugin snesfilter
	use snesreader && build_plugin snesreader
	use sgb && build_plugin supergameboy
}

src_install() {
	for i in accuracy compatibility performance; do
		emake \
			DESTDIR="${D}" \
			prefix="${GAMES_PREFIX}" \
			profile=$i \
			install || die "install failed"
	done

	dogamesbin out/bsnes || die

	# install plugins
	use snesfilter && install_plugin snesfilter
	use snesreader && install_plugin snesreader
	use sgb && install_plugin supergameboy

	prepgamesdirs
}

