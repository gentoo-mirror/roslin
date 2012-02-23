# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games confutils git-2

DESCRIPTION="Simple SNES emulator frontend based on libsnes"
HOMEPAGE="http://themaister.net/ssnes.html"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Themaister/SSNES.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="alsa cg dynamic +fbo ffmpeg jack netplay openal oss pulseaudio sdl-image truetype x264rgb xml xv"

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
	virtual/libsnes"
DEPEND="dev-util/pkgconfig
	!dynamic? ( virtual/libsnes )
	${RDEPEND}"

pkg_setup() {
	confutils_require_any alsa jack openal oss pulseaudio
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-build.patch"
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
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README.md AUTHORS
	prepgamesdirs
}
