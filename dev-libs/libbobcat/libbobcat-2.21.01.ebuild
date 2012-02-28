# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

MY_PN=${PN##lib}
DESCRIPTION="Brokken's own base classes and templates"
HOMEPAGE="http://bobcat.sourceforge.net/"
# Note: Upstreamm is a Debian dev, latest tarball not released upstream
SRC_URI="mirror://debian/pool/main/b/${MY_PN}/${MY_PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+milter"

# TODO dependency on bisonc++?
RDEPEND="milter? (
		|| ( mail-filter/libmilter mail-mta/sendmail ) )"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.3
	dev-util/icmake
	x11-libs/libX11"

S=${WORKDIR}/${MY_PN}-${PV}

src_prepare() {
	sed 's|^\(#define COPT \+"-Itmp \).\+"$|\1'"${CXXFLAGS}"'"|' -i build \
		|| die 'sed failed (file missing)'
}

src_compile() {
	./build libraries all lcgen || die
	if use milter; then
	    ./build all || die
	fi
}

src_install() {
	./build install "${D}" "${D}" || die
}
