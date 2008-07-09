# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils cvs

ECVS_SERVER="enblend.cvs.sourceforge.net:/cvsroot/enblend"
ECVS_MODULE="enblend"

DESCRIPTION="Image Blending with Multiresolution Splines"
HOMEPAGE="http://enblend.sf.net/"
SRC_URI=""

LICENSE="GPL-2 VIGRA"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/tiff
	media-libs/lcms
	virtual/glut
	media-libs/glew
	media-libs/plotutils
	>=dev-libs/boost-1.31.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

pkg_setup() {
	# bug 202476
	if ! built_with_use media-libs/plotutils X ; then
		eerror
		eerror "media-gfx/plotutils has to be built with USE=\"X\""
		eerror
		die "emerge plotutils with USE=\"X\""
	fi

	ewarn
	ewarn "The compilation of enblend needs a lot of RAM. If you have less"
	ewarn "than 1GB RAM (and swap) you probably won't be able to compile it."
	ewarn
}

src_compile() {
	emake -f Makefile.cvs || die "emake -f Makefile.cvs failed"
	econf
	emake || die "Make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
