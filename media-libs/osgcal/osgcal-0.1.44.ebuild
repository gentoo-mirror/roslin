# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="an adapter for using cal3d inside OpenSceneGraph"
HOMEPAGE="http://osgcal.sourceforge.net/"
SRC_URI="http://download.gna.org/underware/sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

CAL3D_V="0.10.0"

DEPEND="=dev-games/openscenegraph-1.2[producer]
		>=media-libs/cal3d-${CAL3D_V}
		>=media-libs/libsdl-1.2.10"
RDEPEND="${DEPEND}"

src_prepare() {
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
		"${FILESDIR}"/${PN}.pc > ${PN}.pc \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog README NEWS || die "dodoc failed"

	insinto /usr/$(get_libdir)/pkgconfig
	doins ${PN}.pc || die "doins failed"
}
