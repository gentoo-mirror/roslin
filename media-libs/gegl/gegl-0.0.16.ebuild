# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="a graph based image processing framework."
HOMEPAGE="http://www.gegl.org/"
SRC_URI="ftp://ftp.gimp.org/pub/${PN}/0.0/${P}.tar.bz2"

LICENSE="|| ( GPL-3 LGPL-3 )"
SLOT="0"
KEYWORDS="~x86"

IUSE="jpeg graphviz openexr ruby sdl svg debug doc threads gtk cairo pango \
	enscript asciidoc ffmpeg workshop"

RDEPEND=""
DEPEND="${RDEPEND}
	>=media-libs/babl-0.0.20
	>=dev-libs/glib-2.14.1
	gtk? ( >=x11-libs/gtk+-2.8.6 )
	>=dev-lang/lua-5.1.0
	cairo? ( x11-libs/cairo )
	pango? ( x11-libs/pango )
	media-libs/libpng
	jpeg? ( media-libs/jpeg )
	ruby? ( dev-lang/ruby )
	sdl? ( media-libs/libsdl )
	openexr? ( media-libs/openexr )
	svg? ( >=gnome-base/librsvg-2.14.0 )
	graphviz? ( media-gfx/graphviz )
	enscript? ( app-text/enscript )
	asciidoc? ( app-text/asciidoc )
	ffmpeg? ( media-video/ffmpeg )"

src_compile() {
	local MYCONF="$(use_enable debug) $(use_enable doc) \
		$(use_enable threads mp) $(use_with jpeg libjpeg) \
		$(use_enable workshop)"
	econf ${MYCONF} || die "econf failed" 
	env GEGL_SWAP=${WORKDIR} emake || die "emake failed"
}

src_install() {
	# emake install doesn't install anything
	einstall || die "einstall failed"
	dodoc ChangeLog INSTALL README NEWS

	# don't know why einstall omits this?!
	insinto /usr/include/${PN}-0.0/${PN}/buffer/
	doins ${WORKDIR}/${P}/${PN}/buffer/*.h || die "doins buffer failed"
	insinto /usr/include/${PN}-0.0/${PN}/module/
	doins ${WORKDIR}/${P}/${PN}/module/*.h || die "doins module failed"
}
