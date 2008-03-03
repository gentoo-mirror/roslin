# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Tool designed specifically to extract as much information as possible from a Bluetooth device without the requirement to pair."
HOMEPAGE="http://www.pentest.co.uk/"
SRC_URI="http://www.pentest.co.uk/src/${P}.tar.bz2"
#http://ftp.de.debian.org/debian/pool/main/b/btscanner/${PN}_2.1-3.diff.gz

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="net-wireless/bluez-utils
	dev-libs/libxml2
	sys-libs/ncurses"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s|-Wimplicit-function-dec||" \
		configure.in || die "sed failed"
	sed -i \
		-e "s|file:///usr/local/etc/btscanner.dtd|/etc/btscanner.dtd|" \
		-e "s|<oui>/usr/local/|<oui>/usr/|" \
		btscanner.xml || die "sed failed"
#	mv ${WORKDIR}/${PN}_2.1-3.diff ${S}/${PN}_2.1-3.diff
#	epatch ${S}/${PN}_2.1-3.diff
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "einstall"
}
