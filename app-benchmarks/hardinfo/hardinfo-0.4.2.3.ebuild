# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="HardInfo can gather information about your system's hardware and operating system, perform benchmarks, and generate printable reports"
HOMEPAGE="http://hardinfo.berlios.de/HomePage"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0
	net-libs/libsoup"
DEPEND="${RDEPEND}"

# Can't compile with -O, need filter-flags and we don't have time (;
#src_unpack() {
#	unpack ${A}
#	cd ${S}
#	sed -i \
#		-e "s|-fPIC -pipe -Wall -g|-fPIC ${CFLAGS}|" \
#		Makefile.in || die "sed"
#}

src_compile() {
	econf || die "econf"
	emake || die "emake"
}

src_install() {
	emake DESTDIR=${D} install || die "einstall"
}
