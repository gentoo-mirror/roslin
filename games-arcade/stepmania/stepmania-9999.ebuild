# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games subversion autotools eutils

DESCRIPTION="An advanced DDR simulator"
HOMEPAGE="http://www.stepmania.com/stepmania/"
SRC_URI=""

ESVN_REPO_URI="https://svn.stepmania.com/svn/trunk/stepmania"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug X gtk force-oss jpeg mp3 vorbis network ffmpeg theora"

DEPEND="gtk? ( x11-libs/gtk+:2 )
	media-libs/alsa-lib
	mp3? ( media-libs/libmad )
	vorbis? ( media-libs/libvorbis )
	media-libs/libpng
	jpeg? ( media-libs/jpeg )
	ffmpeg? ( >=media-video/ffmpeg-0.5 )
	theora? ( media-libs/libtheora )
	>=dev-lang/lua-5
	virtual/glu
	x11-libs/libXrandr
	virtual/opengl"

RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-datadir.patch"
}

src_configure() {
sh ./autogen.sh

	egamesconf \
	--disable-dependency-tracking \
	$(use_enable gtk gtk2) \
	$(use_enable force-oss) \
	$(use_with debug) \
	$(use_with X x) \
	$(use_with jpeg) \
	$(use_with mp3) \
	$(use_with vorbis) \
	$(use_with network) \
	$(use_with ffmpeg) \
	$(use_with theora)
}

src_install() {
	dogamesbin src/${PN} || die "dogamesbin stepmania failed"

	insinto "${GAMES_DATADIR}"/${PN}
	if use gtk ; then
		doins src/GtkModule.so || die "doins GtkModule.so failed"
	fi
	doins -r Announcers Assets BGAnimations BackgroundEffects \
		BackgroundTransitions CDTitles Characters Courses Data \
		NoteSkins Packages RandomMovies Songs Themes || die "doins failed"
	dodoc Docs/* || die "dodoc failed"

	newicon "Themes/default/Graphics/Common window icon.png" ${PN}.png
	make_desktop_entry ${PN} StepMania

	prepgamesdirs
}
