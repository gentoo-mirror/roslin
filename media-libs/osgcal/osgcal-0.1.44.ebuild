# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="an adapter for using cal3d inside OpenSceneGraph"
HOMEPAGE="http://osgcal.sourceforge.net/"
SRC_URI="http://download.gna.org/underware/sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

CAL3D_V="0.10.0"

DEPEND=">=dev-games/openscenegraph-1.2
		>=media-libs/cal3d-${CAL3D_V}"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# this is a bit questionable. it more or less does what the
	# configure script should do. but since that only exists in
	# http://cvs.gna.org/cvsweb/osgcal/?cvsroot=underware
	# we are redoing the changes here. a bit risky IMO. a snapshot
	# would be much better... or a new release
	sed -e "s:@prefix@:/usr/:" \
		-e "s:@exec_prefix@:\$\{prefix\}:" \
		-e "s:@libdir@:\$\{exec_prefix\}/lib:" \
		-e "s:@includedir@:\$\{prefix\}/include:" \
		-e "s:@PACKAGE_VERSION@:${PV}:" \
		-e "s:@CAL3D_VERSION@:${CAL3D_V}:" \
		-e "s:@GIFPLUGIN_CFLAGS@:-DSUPPORT_GIF_HLS:" \
		"${FILESDIR}"/${PN}.pc > ${PN}.pc
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS.txt Changelog COPYING.txt README.txt TODO.txt VERSION.txt docs/usage.txt

	insinto /usr/$(get_libdir)/pkgconfig
	doins ${PN}.pc
}
