# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit qt4 eutils

DESCRIPTION="Subtitle downloader"
HOMEPAGE="http://krzemin.iglu.cz/qnapi"
SRC_URI="http://krzemin.iglu.cz/${PN}/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="app-arch/p7zip
	$(qt4_min_version 4.3)"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	mv manpage ${PN}.1
}

src_compile() {
	eqmake4 || die "eqmake4 failed"
	emake || die "emake failed"
}

src_install() {
	dobin ${PN}

	domenu ${PN}.desktop ${PN}-download.desktop

	doman ${PN}.1

	dodoc README
}
