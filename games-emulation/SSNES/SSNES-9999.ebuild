# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games confutils git

DESCRIPTION="Simple SNES emulator frontend based on libsnes"
HOMEPAGE="https://github.com/Themaister/SSNES"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Themaister/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="alsa cg ffmpeg jack openal oss xml"

RDEPEND="dev-games/libsnes
	media-libs/libsdl[joystick]
	media-libs/libsamplerate
	alsa? ( media-libs/alsa-lib )
	cg? ( media-gfx/nvidia-cg-toolkit )
	ffmpeg? ( media-video/ffmpeg )
	jack? ( media-sound/jack-audio-connection-kit )
	openal? ( media-libs/openal )
	xml? ( dev-libs/libxml2 )"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

DOCS=("README.md" "AUTHORS")

pkg_config() {
	games-pkg_setup
	confutils_require_any alsa jack openal oss
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
		|| die
}
