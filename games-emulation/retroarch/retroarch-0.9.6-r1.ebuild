# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games python git-2

DESCRIPTION="Universal frontend for libretro-based emulators"
HOMEPAGE="http://themaister.net/retroarch.html"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Themaister/RetroArch.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa cg +dynamic +fbo ffmpeg jack netplay openal oss pulseaudio python sdl-image truetype x264rgb xml xv"

RDEPEND="media-libs/libsdl[joystick]
	alsa? ( media-libs/alsa-lib )
	cg? ( media-gfx/nvidia-cg-toolkit )
	ffmpeg? ( x264rgb? ( >=media-video/ffmpeg-0.9 )
		!x264rgb? ( virtual/ffmpeg ) )
	jack? ( media-sound/jack-audio-connection-kit )
	openal? ( media-libs/openal )
	xml? ( dev-libs/libxml2 )
	truetype? ( media-libs/freetype:2 )
	pulseaudio? ( media-sound/pulseaudio )
	sdl-image? ( media-libs/sdl-image )
	xv? ( x11-libs/libXv )
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
		"${FILESDIR}/${PN}-python.patch"

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
		$(use_enable x264rgb) \
		$(use_enable python) \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README.md AUTHORS
	prepgamesdirs
}
