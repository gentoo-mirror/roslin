# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils gnome2

DESCRIPTION="The Gnome Scan project aim to provide scan features every where in the desktop like print is."
HOMEPAGE="http://www.gnome.org/projects/gnome-scan/index"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

RDEPEND=">=x11-libs/gtk+-2.12
	media-gfx/sane-backends
	>=media-libs/gegl-0.0.16
	>=media-gfx/gimp-2.3
	>=gnome-base/libglade-2.6"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	dev-util/pkgconfig"

DOCS="AUTHORS NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable debug)"
}
