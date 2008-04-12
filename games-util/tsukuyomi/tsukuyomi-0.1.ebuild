# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A reference utility for creating and applying UPS patches"
HOMEPAGE="http://byuu.cinnamonpirate.com"
MY_PV="${PV/./}"
SRC_URI="http://byuu.cinnamonpirate.com/files/${PN}_v${MY_PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="x11-libs/gtk+
	x11-libs/libXtst"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

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

