# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit qt4

MY_P="${P}-source"

DESCRIPTION="A Qt4 program for connecting with the Wii Homebrew/TCPLoader Channel"
HOMEPAGE="http://sourceforge.net/projects/wiitcpload/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="|| ( =x11-libs/qt-4.3*:4
		x11-libs/qt-gui )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}/${PN}.pro.patch" )

#src_prepare() {
#	epatch "${FILESDIR}/${PN}.pro.patch" || die "epatch failed"
#}

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake failed"
	dodoc doc/CHANGELOG || die "dodoc failed"
}
