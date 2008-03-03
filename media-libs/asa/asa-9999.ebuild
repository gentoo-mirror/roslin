# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://git.spaceboyz.net/asa.git"

inherit git

DESCRIPTION="An open-source and cross-platform SSA/ASS subtitles renderer."
HOMEPAGE="http://asa.diac24.net/Main_Page"
SRC_URI=""

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

src_unpack() {
	git_src_unpack
}

src_compile() {
	./bootstrap || die "some weird script failed"

	econf \
		$(use_with X x) \
		$(use_enable nls) \
		--disable-optimize \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make install || die "make install failed"
}
