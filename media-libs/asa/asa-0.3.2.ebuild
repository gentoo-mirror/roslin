# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PV="e4599e545d15ad39934ac8df2e8dae2780fd1ec7"

DESCRIPTION="An open-source and cross-platform SSA/ASS subtitles renderer."
HOMEPAGE="http://asa.diac24.net/Main_Page"
SRC_URI="http://git.spaceboyz.net/asa.git/snapshots/asa-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X nls"

DEPEND=">=media-libs/freetype-2.2.1
	>=sys-libs/zlib-1.2.3
	media-libs/fontconfig
	>=dev-libs/expat-2.0.0
	>=dev-libs/libpcre-6.5"
RDEPEND=""

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mv ${P}-${MY_PV} ${P}
}

src_compile() {
#	./bootstrap || die "some weird script failed"

	econf \
		$(use_with X x) \
		$(use_enable nls) \
		--disable-optimize \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
