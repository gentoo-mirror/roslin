# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games git

DESCRIPTION="Simple SNES emulator frontend based on libsnes"
HOMEPAGE="https://github.com/Themaister/SSNES"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Themaister/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="alsa cg filters ffmpeg jack libsamplerate openal oss pulseaudio truetype xml"

REQUIRED_USE="|| ( alsa jack openal oss )"

RDEPEND="dev-games/libsnes
	media-libs/libsdl[joystick]
	alsa? ( media-libs/alsa-lib )
	cg? ( media-gfx/nvidia-cg-toolkit )
	ffmpeg? ( media-video/ffmpeg )
	jack? ( media-sound/jack-audio-connection-kit )
	openal? ( media-libs/openal )
	xml? ( dev-libs/libxml2 )
	truetype? ( media-libs/freetype:2 )
	pulseaudio? ( media-sound/pulseaudio )
	libsamplerate? ( media-libs/libsamplerate )"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-build.patch" \
		"${FILESDIR}/${PN}-cflags.patch"
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
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README.md AUTHORS
	prepgamesdirs
}
