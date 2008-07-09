# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

ESVN_REPO_URI="https://panotools.svn.sourceforge.net/svnroot/panotools/trunk/libpano"

DESCRIPTION="Helmut Dersch's panorama toolbox library"
HOMEPAGE="http://panotools.sf.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="java"

DEPEND="!media-libs/libpano12
	media-libs/libpng
	media-libs/tiff
	media-libs/jpeg
	sys-libs/zlib
	java? ( virtual/jdk )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf=""
	use java && myconf="--with-java=${JAVA_HOME}"
	use java || myconf="--without-java"

	./bootstrap "${myconf}" || die "Bootstrap failed"
	econf "${myconf}"
	emake || die "Make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README README.linux AUTHORS NEWS doc/*.txt doc/*.readme
}
