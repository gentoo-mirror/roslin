# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion eutils

DESCRIPTION="Generic Graphics Library is a graph based image processing framework."
HOMEPAGE="http://www.gegl.org/"
ESVN_REPO_URI="http://svn.gnome.org/svn/gegl/trunk/"
SRC_URI=""

LICENSE="|| ( GPL-3 LGPL-3 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="jpeg graphviz openexr ruby sdl svg debug doc threads gtk cairo pango \
	enscript asciidoc ffmpeg workshop"

RDEPEND=""
DEPEND="${RDEPEND}
	>=media-libs/babl-0.0.20
	>=dev-libs/glib-2.14.1
	media-libs/libpng
	gtk? ( >=x11-libs/gtk+-2.8.6 )
	sdl? ( media-libs/libsdl )
	jpeg? ( media-libs/jpeg )
	openexr? ( media-libs/openexr )
	cairo? ( x11-libs/cairo )
	pango? ( x11-libs/pango )
	dev-lang/ruby
	svg? ( >=gnome-base/librsvg-2.14.0 )
	graphviz? ( media-gfx/graphviz )
	enscript? ( app-text/enscript )
	asciidoc? ( app-text/asciidoc )
	ffmpeg? ( media-video/ffmpeg )"

src_compile() {
	local MYCONF="$(use_enable debug) \
		$(use_enable doc) \
		$(use_enable threads mp) \
		$(use_with jpeg libjpeg) \
		$(use_enable workshop)"

	"${S}"/autogen.sh $(use_enable) || die
	econf ${MYCONF} || die "configure failed"
	env GEGL_SWAP="${WORKDIR}" emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog INSTALL README

	# don't know why einstall omits this?!
	insinto /usr/include/${PN}-1.0/${PN}/buffer/
	doins "${WORKDIR}/${P}/${PN}"/buffer/*.h || die "doins buffer failed"
	insinto /usr/include/${PN}-1.0/${PN}/module/
	doins "${WORKDIR}/${P}/${PN}"/module/*.h || die "doins module failed"
}
