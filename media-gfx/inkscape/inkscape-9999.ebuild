# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit subversion gnome2 eutils

DESCRIPTION="A SVG based generic vector-drawing program"
HOMEPAGE="http://www.inkscape.org/"
SRC_URI=""

ESVN_REPO_URI="https://inkscape.svn.sourceforge.net/svnroot/inkscape/inkscape/trunk"
ESVN_PROJECT="inkscape"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS=""
IUSE="cairo dia doc gnome inkjar jabber lcms mmx nls perl postscript python spell wmf"
RESTRICT="test"

COMMON_DEPEND="
	>=virtual/poppler-glib-0.8.3[cairo]
	dev-cpp/glibmm
	>=dev-cpp/gtkmm-2.10.0:2.4
	>=dev-libs/boehm-gc-6.4
	dev-libs/boost
	>=dev-libs/glib-2.6.5:2
	>=dev-libs/libsigc++-2.0.12
	>=dev-libs/libxml2-2.6.20
	>=dev-libs/libxslt-1.0.15
	dev-libs/popt
	dev-python/lxml
	dev-python/pyxml
	media-gfx/imagemagick
	media-libs/fontconfig
	>=media-libs/freetype-2
	media-libs/libpng
	x11-libs/libXft
	>=x11-libs/gtk+-2.10.7:2
	>=x11-libs/pango-1.4.0
	sci-libs/gsl
	gnome? ( >=gnome-base/gnome-vfs-2.0 )
	lcms? ( >=media-libs/lcms-1.14 )
	perl? (
		dev-perl/XML-Parser
		dev-perl/XML-XQL
	)
	spell? ( app-text/gtkspell )"

# These only use executables provided by these packages
# See share/extensions for more details. inkscape can tell you to
# install these so we could of course just not depend on those and rely
# on that.
RDEPEND="
	${COMMON_DEPEND}
	dev-python/numpy
	dia? ( app-office/dia )
	postscript? ( >=media-gfx/pstoedit-3.44[plotutils] media-gfx/skencil )
	wmf? ( media-libs/libwmf )"

DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	x11-libs/libX11
	>=dev-util/intltool-0.29"

S=${WORKDIR}/${PN}

pkg_setup() {
	G2CONF="${G2CONF} --with-xft"
	G2CONF="${G2CONF} $(use_enable cairo poppler-cairo)"
	G2CONF="${G2CONF} $(use_with spell gtkspell)"
	G2CONF="${G2CONF} $(use_enable jabber inkboard)"
	G2CONF="${G2CONF} $(use_enable mmx)"
	G2CONF="${G2CONF} $(use_with inkjar)"
	G2CONF="${G2CONF} $(use_with gnome gnome-vfs)"
	G2CONF="${G2CONF} $(use_enable lcms)"
	G2CONF="${G2CONF} $(use_with perl)"
	G2CONF="${G2CONF} $(use_with python)"
	G2CONF="${G2CONF} $(use_enable nls)"
}

src_unpack() {
	subversion_src_unpack
#	gnome2_src_unpack

#	cd "${S}"
#	epatch "${FILESDIR}"/${PN}-0.46-gcc43.patch
#	epatch "${FILESDIR}"/${P}-poppler-0.8.3.patch
#	epatch "${FILESDIR}"/${P}-bug-174720-0.patch
#	epatch "${FILESDIR}"/${P}-bug-174720-1.patch
#	epatch "${FILESDIR}"/${P}-bug-214171.patch

	# This should go to src_compile, but... (;
	sh autogen.sh || die "autogen"
}

DOCS="AUTHORS ChangeLog NEWS README"
