# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MY_PV="${PV/./}"

DESCRIPTION="A reference utility for creating and applying UPS patches"
HOMEPAGE="http://byuu.cinnamonpirate.com"
SRC_URI="http://byuu.cinnamonpirate.com/files/${PN}_v${MY_PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	x11-libs/libXtst"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i \
		-e "s/g++/g++ ${CXXFLAGS}/" \
		-e "/strip/d" \
		-e "/clear/d" \
		cc.sh || die "sed"
}

src_compile() {
	./cc.sh || die "compilation failed"
}

src_install() {
	dobin ${PN} || die "failed bin"
}
