# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games python git-2

DESCRIPTION="Universal frontend for libretro-based emulators"
HOMEPAGE="http://themaister.net/retroarch.html"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Themaister/RetroArch.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="alsa cg +dynamic +fbo ffmpeg jack netplay openal oss png pulseaudio python sdl sdl-image truetype xml xv"

RDEPEND="sdl? ( >=media-libs/libsdl-1.2.10[joystick] )
	alsa? ( media-libs/alsa-lib )
	cg? ( media-gfx/nvidia-cg-toolkit )
	ffmpeg? ( virtual/ffmpeg )
	jack? ( >=media-sound/jack-audio-connection-kit-0.120.1 )
	openal? ( media-libs/openal )
	xml? ( dev-libs/libxml2 )
	truetype? ( media-libs/freetype:2 )
	pulseaudio? ( media-sound/pulseaudio )
	sdl-image? ( media-libs/sdl-image )
	xv? ( x11-libs/libXv )
	png? ( >=media-libs/libpng-1.5 )
	dev-games/bsnes-libretro"
DEPEND="dev-util/pkgconfig
	!dynamic? ( dev-games/bsnes-libretro )
	${RDEPEND}"

REQUIRED_USE="|| ( alsa jack openal oss pulseaudio )"

pkg_setup() {
	use python && python_set_active_version 3
	games_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-build.patch" \
		"${FILESDIR}/${P}-python.patch"

	if use python; then
		sed -i qb/config.libs.sh \
			-e "s:%PYTHON_VER%:$(python_get_version):" \
			|| die
	fi
}

src_configure() {
	egamesconf \
		$(use_enable alsa) \
		$(use_enable ffmpeg) \
		$(use_enable jack) \
		$(use_enable openal al) \
		$(use_enable oss) \
		$(use_enable cg) \
		$(use_enable xml) \
		$(use_enable fbo) \
		$(use_enable truetype freetype) \
		$(use_enable pulseaudio pulse) \
		$(use_enable dynamic) \
		$(use_enable netplay) \
		$(use_enable sdl-image sdl_image) \
		$(use_enable xv xvideo) \
		$(use_enable python) \
		$(use_enable png libpng) \
		$(use_enable sdl) \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README.md AUTHORS
	prepgamesdirs
}
