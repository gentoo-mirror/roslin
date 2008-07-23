# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="client of cdemu suite to mount all kinds of cd images"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/cdemu-client-${PV}.tar.bz2"

S="${WORKDIR}/cdemu-client-${PV}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4
		dev-python/dbus-python
		dev-util/intltool"
RDEPEND="${DEPEND}
		>=app-cdr/cdemud-1.1.0"

src_install() {
	emake install DESTDIR="${D}" || die "Error: install failed!"
	dodoc AUTHORS ChangeLog README TODO
}
