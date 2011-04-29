# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="eXtra fast Directory changer"
HOMEPAGE="http://xd-home.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/xd-home/xd-home/${PV}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-util/icmake
	dev-libs/libbobcat
	doc? ( app-doc/yodl )"
RDEPEND="${DEPEND}"

src_prepare() {
	sed 's|^#include "icmake/library"$|#define COPT "--std=c++0x -Wall '"${CXXFLAGS}"'"\n\0|' -i build \
		|| die 'sed failed (file missing)'
}

src_compile() {
	./build program || die './build program'
	./build library || die './build library'

	use doc && {
		./build man || die './build man'
	}
}

src_install() {
	./build install "${D}"
}
