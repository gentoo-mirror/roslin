# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils confutils games toolchain-funcs git-r3

MY_PV="${PV/0./}"
MY_PV="${MY_PV/_/}"

DESCRIPTION="A feature-oriented fork of bsnes mostly aimed at debugging"
HOMEPAGE="https://github.com/devinacker/bsnes-plus"
SRC_URI=""
EGIT_REPO_URI="https://github.com/devinacker/bsnes-plus.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ao alsa openal opengl oss pulseaudio sdl sgb snesfilter +snesreader xv"

RDEPEND="ao? ( media-libs/libao )
	openal? ( media-libs/openal )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	xv? ( x11-libs/libXv )
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl[joystick] )
	sgb? ( dev-games/supergameboy )
	snesfilter? ( dev-games/snesfilter )
	snesreader? ( dev-games/snesreader )
	>=dev-qt/qtgui-4.5:4"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gcc-4.4
	!games-emulation/bsnes"

S="${WORKDIR}/${P}/bsnes"

disable_module() {
	sed -i "ui-qt/Makefile" -e "s|$1||"
}

pkg_setup() {
	confutils_require_any ao openal alsa pulseaudio oss
	confutils_require_any xv opengl sdl
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-makefile.patch

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
	emake platform=x compiler="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		prefix="${GAMES_PREFIX}" \
		install || die "install failed"

	prepgamesdirs
}
