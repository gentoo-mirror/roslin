# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit wxwidgets eutils cmake-utils subversion

ESVN_REPO_URI="https://hugin.svn.sourceforge.net/svnroot/hugin/hugin/trunk"

DESCRIPTION="GUI for the creation & processing of panoramic images"
HOMEPAGE="http://hugin.sf.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="sift"

DEPEND="app-arch/zip
		media-libs/libpano13
		>=dev-libs/boost-1.30.0
		=x11-libs/wxGTK-2.8*
		sys-libs/zlib
		media-libs/libpng
		media-libs/jpeg
		media-libs/tiff
		media-libs/openexr
		media-gfx/exiv2
		media-libs/exiftool
		>=media-gfx/enblend-3.1
		sift? ( media-gfx/autopano-sift-c )"

DOCS="AUTHORS README TODO"

pkg_setup() {
	if ! built_with_use --missing true dev-libs/boost threads ; then
		eerror "dev-libs/boost has to be compiled with USE=threads"
		die "Needed USE-flag for dev-libs/boost not found."
	fi

	if ! use sift; then
		elog "It is recommended to emerge this package with the"
		elog "sift use flag to install media-gfx/autopano-sift-c"
		elog "that produces control points between images in a"
		elog "panorama."
	fi
}
