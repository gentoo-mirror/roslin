# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MY_PV="${PV/./}"

DESCRIPTION="A utility for applying UPS patches"
HOMEPAGE="http://byuu.org"
SRC_URI="http://bsnes.googlecode.com/files/${PN}_v${MY_PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.5:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i \
		-e "s/-O3/${CXXFLAGS}/" \
		-e "/link  := -s/d" \
		Makefile || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" prefix="/usr" install || die
}
