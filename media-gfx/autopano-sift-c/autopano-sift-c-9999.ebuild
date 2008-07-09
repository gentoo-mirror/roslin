# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cmake-utils subversion

ESVN_REPO_URI="https://hugin.svn.sourceforge.net/svnroot/hugin/autopano-sift-C/trunk"

DESCRIPTION="SIFT algorithm for automatic panorama creation in C."
HOMEPAGE="http://hugin.sf.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-libs/libxml2
	media-libs/libpano13
	media-libs/tiff
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib"
RDEPEND="${DEPEND}"
