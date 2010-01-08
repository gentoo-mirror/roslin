# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="Free disk space and maintain privacy"
HOMEPAGE="http://bleachbit.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pygtk"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install

	newbin ${PN}.py ${PN}
	doicon ${PN}.png

	insinto /usr/share/applications
	doins ${PN}.desktop

	insinto /usr/share/data/${PN}
	doins -r cleaners
}
