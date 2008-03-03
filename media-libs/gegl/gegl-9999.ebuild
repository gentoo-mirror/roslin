# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion

DESCRIPTION="Generic Graphics Library is a graph based image processing framework."
HOMEPAGE="http://www.gegl.org/"
#SRC_URI="ftp://ftp.gimp.org/pub/${PN}/0.0/${P}.tar.bz2"

ESVN_REPO_URI="http://svn.gnome.org/svn/gegl/trunk/"
ESVN_PROJECT="${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="jpeg graphviz openexr ruby sdl svg"

RDEPEND=">=media-libs/babl-0.0.14"
DEPEND="${RDEPEND}
	>=dev-libs/glib-2.10
	media-libs/libpng
	jpeg? ( media-libs/jpeg )
	ruby? ( dev-lang/ruby )
	sdl? ( media-libs/libsdl )
	openexr? ( media-libs/openexr )
	svg? ( gnome-base/librsvg )
	graphviz? ( media-gfx/graphviz )"

S=${WORKDIR}/${PN}

src_compile() {
	./autogen.sh || die "autogen failed" 
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog

	# don't know why einstall omits this?!
	insinto /usr/include/${PN}-1.0/${PN}/buffer/
	doins ${S}/${PN}/buffer/*.h || die "doins buffer failed"
	insinto /usr/include/${PN}-1.0/${PN}/module/
	doins ${S}/${PN}/module/*.h || die "doins module failed"
}
