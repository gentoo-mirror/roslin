# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Generic Graphics Library is a graph based image processing framework."
HOMEPAGE="http://www.gegl.org/"
SRC_URI="ftp://ftp.gimp.org/pub/${PN}/0.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="debug doc jpeg graphviz openexr ruby sdl svg"
# use_enable smp breaks configure and workshop breaks make
#IUSE="${IUSE} smp workshop"

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

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable doc docs) \
		$(use_with jpeg libjpeg) \
		|| die "configure failed" 
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "einstall failed"
	dodoc AUTHORS ChangeLog README

	# don't know why einstall omits this?!
	insinto /usr/include/${PN}-1.0/${PN}/buffer/
	doins ${S}/${PN}/buffer/*.h || die "doins buffer failed"
	insinto /usr/include/${PN}-1.0/${PN}/module/
	doins ${S}/${PN}/module/*.h || die "doins module failed"
}
