# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils qt4-r2

MY_P="${P/_p/_}"

DESCRIPTION="A Polish tool for printing and managing invoices"
HOMEPAGE="http://e-linux.pl/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -e "s:/usr/local:/usr:g" \
	    -i Settings.h \
	    || die "sed failed"
}

src_install() {
	dobin ${PN} || die

	insinto /usr/share/${PN}/templates
	doins templates/*.css \
		|| die "doins failed"

	doicon icons/${PN}*.png \
		|| die "doicon failed"

	make_desktop_entry ${PN} QFaktury qfaktury_64
}
