# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit qt4 eutils

DESCRIPTION="Subtitle downloader"
HOMEPAGE="http://krzemin.iglu.cz/qnapi"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="app-arch/p7zip
	|| ( $(qt4_min_version 4.3) 
	    x11-libs/qt-gui:4 )"
DEPEND="${RDEPEND}"

src_compile() {
	eqmake4 || die "eqmake4 failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
}
