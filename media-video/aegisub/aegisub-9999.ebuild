# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

WX_GTK_VER="2.8"

inherit wxwidgets subversion

ESVN_REPO_URI="http://svn.aegisub.net/trunk"
ESVN_PROJECT="aegisub"

DESCRIPTION="A WxWidgets subtitle editing tool for ass"
HOMEPAGE="http://malakith.net/aegiwiki/Main_Page"
LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="asa libass nls openal portaudio pulseaudio"

DEPEND=">=sys-devel/automake-1.10
	>=sys-devel/autoconf-2.61
	nls? ( >=sys-devel/gettext-0.16.1 )
	>=dev-lang/lua-5.1.2
	>=sys-devel/libtool-1.5.24
	>=media-gfx/imagemagick-6.3.4
	>=app-text/hunspell-1.1.5
	>=x11-libs/wxGTK-2.8.4.0
	>=media-video/ffmpeg-0.4.9
	asa? ( >=media-libs/asa-0.3.2 )
	libass? ( >=media-libs/libass-0.9.4 )
	nls? ( >=sys-devel/gettext-0.16.1 )
	portaudio? ( =media-libs/portaudio-18.1 )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.6 )
	openal? ( media-libs/openal )"

src_unpack() {
	subversion_src_unpack

	cd ${S}
	epatch ${FILESDIR}/${PN}-audio-tests.patch
}

src_compile() {
	sh autogen.sh

	econf \
		$(use_enable nls) \
		$(use_with openal) \
		$(use_with portaudio) \
		$(use_with pulseaudio) \
		$(use_with asa) \
		$(use_with libass) \
		|| die "econf failed"
	emake || die "emake failed"
}


src_install() {
	emake DESTDIR="${D}" install || die
}
