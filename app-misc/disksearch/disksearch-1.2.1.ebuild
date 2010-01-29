# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Tool for searching for files on removable media disks"
HOMEPAGE="http://disksearch.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=virtual/python-2.3
	>=dev-python/pygtk-2.4"

RDEPEND=">=x11-libs/gtk+-2.4
	${DEPEND}"

src_compile() {
	epatch "${FILESDIR}/homedir.patch"
}

src_install() {
	emake prefix="${D}/usr/" || die "emake failed"
	insinto "/usr/share/applications/"
	doins "${FILESDIR}/disksearch.desktop" || die
}
