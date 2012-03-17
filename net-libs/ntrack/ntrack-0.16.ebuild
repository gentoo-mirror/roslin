# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils

MY_PV="${PV/./}"

DESCRIPTION="A lightweight library for getting events on network online status changes"
HOMEPAGE="https://launchpad.net/ntrack"
SRC_URI="http://launchpad.net/${PN}/main/${MY_PV}/+download/ntrack-${MY_PV}.tar.gz"

LICENSE="|| ( GPL-3 LGPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="glib qt4"

DEPEND="dev-libs/libnl
	glib? ( dev-libs/glib:2 )
	qt4? ( x11-libs/qt-core:4 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

DOCS=( "AUTHORS" "NEWS" "README" )

PATCHES=( "${FILESDIR}/${PN}-0.14-docs.patch" )

REQUIRED_USE="|| ( glib qt4 )"

src_prepare() {
	autotools-utils_src_prepare

	# eautoreconf breaks, so let's use this instead
	sh autogen.sh
}

src_configure() {
	local myeconfargs=(
		$(use_with glib glib2)
		$(use_with qt4)
		--without-gobject
		--without-pygobject
	)

	autotools-utils_src_configure
}
