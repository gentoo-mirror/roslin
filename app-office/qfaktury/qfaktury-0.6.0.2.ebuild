# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils cmake-utils

DESCRIPTION="A Polish tool for printing and managing invoices"
HOMEPAGE="http://e-linux.pl/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-0.6.0.1"

src_prepare() {
	sed -e "s:/usr/local:/usr:g" \
	    -i Settings.h \
	    || die "sed failed"
	    
	epatch "${FILESDIR}"/${PN}-nip.patch
}

src_install() {
	cmake-utils_src_install

	insinto /usr/share/${PN}/templates
	doins templates/*.css \
		|| die "doins failed"

	doicon icons/${PN}*.png \
		|| die "doicon failed"

	make_desktop_entry ${PN} QFaktury qfaktury_64
}

