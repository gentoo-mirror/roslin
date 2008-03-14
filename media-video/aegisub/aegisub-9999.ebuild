# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools eutils subversion

ESVN_REPO_URI="https://spaceboyz.net/svn/aegisub/trunk"
ESVN_PROJECT="aegisub"

DESCRIPTION="A WxWidgets subtitle editing tool for ass"
HOMEPAGE="http://malakith.net/aegiwiki/Main_Page"
LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="asa libass nls portaudio pulseaudio"

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
	pulseaudio? ( >=media-sound/pulseaudio-0.9.6 )"

S=${WORKDIR}/${P}

src_unpack() {
	subversion_src_unpack
}

src_compile() {
	sh autogen.sh

#	myconf="--with-wx-config=/usr/bin/wx-config-2.8"

	econf \
		$(use_enable nls) \
		$(use_with portaudio) \
		$(use_with pulseaudio) \
		$(use_with asa) \
		$(use_with libass) \
		"--with-wx-config=/usr/bin/wx-config-2.8" \
		|| die "econf failed"
	emake || die "emake failed"
}


src_install() {
	emake DESTDIR=${D} install || die
}
