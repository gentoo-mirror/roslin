# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit qt4-r2

MY_P="${P}-source"

DESCRIPTION="A Qt4 program for connecting with the Wii Homebrew/TCPLoader Channel"
HOMEPAGE="http://sourceforge.net/projects/wiitcpload/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

PATCHES=("${FILESDIR}/${PN}.pro.patch")
DOCS="doc/CHANGELOG"
