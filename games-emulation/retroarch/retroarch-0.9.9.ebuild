# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_1,3_2,3_3} )

inherit games python-single-r1 git-2

DESCRIPTION="Universal frontend for libretro-based emulators"
HOMEPAGE="http://www.libretro.com/"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/RetroArch.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa cg +fbo ffmpeg jack netplay openal oss pulseaudio python sdl sdl-image truetype xml xv zlib"

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
	zlib? ( sys-libs/zlib )
	rgui? ( virtual/opengl )
	python? ( ${PYTHON_DEPS} )"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

REQUIRED_USE="|| ( alsa jack openal oss pulseaudio )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
	games_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-build.patch" \
		"${FILESDIR}/${PN}-python.patch"

	if use python; then
		PYTHON_LIBS="$(python_get_EPYTHON)"
		sed -i qb/config.libs.sh \
			-e "s:%PYTHON_VER%:${PYTHON_LIBS/python/}:" \
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
		$(use_enable xml libxml2) \
		$(use_enable fbo) \
		$(use_enable truetype freetype) \
		$(use_enable pulseaudio pulse) \
		$(use_enable netplay) \
		$(use_enable sdl-image sdl_image) \
		$(use_enable xv xvideo) \
		$(use_enable python) \
		$(use_enable zlib) \
		$(use_enable sdl) \
		--enable-dynamic \
		--with-man_dir="/usr/share/man/man1" \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README.md AUTHORS
	prepgamesdirs
}
