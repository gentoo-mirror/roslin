# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils games git-2

DESCRIPTION="A libsnes frontend based on the old bsnes GUI"
HOMEPAGE="http://byuu.org/bsnes/"
SRC_URI=""

EGIT_REPO_URI="git://gitorious.org/bsnes-qt/bsnes-qt.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ao alsa openal opengl oss pulseaudio sdl snesfilter +snesreader xv"

RDEPEND="ao? ( media-libs/libao )
	openal? ( media-libs/openal )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	xv? ( x11-libs/libXv )
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl[joystick] )
	snesfilter? ( dev-games/snesfilter )
	snesreader? ( dev-games/snesreader )
	>=x11-libs/qt-gui-4.5:4
	dev-games/bsnes-libretro"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gcc-4.4"

REQUIRED_USE="|| ( ao openal alsa pulseaudio oss )
	|| ( xv opengl sdl )"

disable_module() {
	sed -i "Makefile" -e "s|$1||"
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
	emake platform=x compiler=gcc || die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		prefix="${GAMES_PREFIX}" \
		install || die "install failed"

	prepgamesdirs
}
