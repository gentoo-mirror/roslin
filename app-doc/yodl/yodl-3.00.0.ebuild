# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Tools to process files written in Your Own Document Language (Yodl)"
HOMEPAGE="http://yodl.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${PV}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/icmake
	dev-texlive/texlive-latex"
RDEPEND=""

src_prepare() {
	sed 's|^#define COPT .\+$|#define COPT "'"${CXXFLAGS}"'"|' -i build \
		|| die 'sed failed (file missing)'
}

src_compile() {
	addpredict /var/cache/fonts  # TODO proper fix
	./build programs || die './build programs'
	./build man || die './build man'
	./build manual || die './build manual'
	./build macros || die './build macros'
}

src_install() {
	./build install programs "${D}" || die './build install programs'
	./build install man "${D}" || die './build install man'
	./build install manual "${D}" || die './build install manual'
	./build install macros "${D}" || die './build install macros'
	./build install docs "${D}" || die './build install docs'
}
