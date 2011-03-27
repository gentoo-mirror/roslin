# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games confutils git

DESCRIPTION="Simple SNES emulator frontend based on libsnes"
HOMEPAGE="https://github.com/Themaister/SSNES"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Themaister/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="alsa cg dynamic filters ffmpeg jack libsamplerate openal oss pulseaudio truetype xml"

RDEPEND="media-libs/libsdl[joystick]
	alsa? ( media-libs/alsa-lib )
	cg? ( media-gfx/nvidia-cg-toolkit )
	ffmpeg? ( media-video/ffmpeg )
	jack? ( media-sound/jack-audio-connection-kit )
	openal? ( media-libs/openal )
	xml? ( dev-libs/libxml2 )
	truetype? ( media-libs/freetype:2 )
	pulseaudio? ( media-sound/pulseaudio )
	libsamplerate? ( media-libs/libsamplerate )
	!dynamic? ( || ( dev-games/libsnes
	dev-games/snes9x-libsnes ) )"
DEPEND="dev-util/pkgconfig
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
		$(use_enable truetype freetype) \
		$(use_enable filters filter) \
		$(use_enable pulseaudio pulse) \
		$(use_enable libsamplerate src) \
		$(use_enable dynamic) \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README.md AUTHORS
	prepgamesdirs
}
