# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools eutils

DESCRIPTION="Send text message using your mobile phone through a bluetooth connection"
HOMEPAGE="http://code.google.com/p/phonetooth"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gammu"

RDEPEND="dev-python/pygtk
         dev-python/pybluez
	 dev-python/pyserial
         app-mobilephone/obex-data-server
	 dev-python/dbus-python
	 gammu? ( dev-python/python-gammu )"
DEPEND="${RDEPEND}"

src_compile() {
	econf
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README
}
