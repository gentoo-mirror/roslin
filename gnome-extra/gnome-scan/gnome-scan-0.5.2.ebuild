# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils gnome2

DESCRIPTION="The Gnome Scan project aim to provide scan features every where in the desktop like print is."
HOMEPAGE="http://www.gnome.org/projects/gnome-scan/index"
SRC_URI="http://download.gna.org/gnomescan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug doc"

RDEPEND=">=x11-libs/gtk+-2.8
	media-gfx/sane-backends
	>=dev-libs/glib-2.4
	>=x11-libs/cairo-1.2
	>=app-text/scrollkeeper-0.3.14
	>=media-libs/gegl-0.0.13
	gnome-base/libgnomeui"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	dev-util/pkgconfig"

DOCS="AUTHORS NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable debug)"
}

#src_compile() {
#	econf \
#		$(use_enable debug debugging) \
#		$(use_enable gnome) || die "econf failed"
#	emake || die "emake failed"
#}

