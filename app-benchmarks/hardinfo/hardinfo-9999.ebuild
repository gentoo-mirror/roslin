# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

ESVN_REPO_URI="svn://svn.berlios.de/hardinfo/trunk"
#ESVN_PROJECT="hardinfo2"

DESCRIPTION="HardInfo can gather information about your system's hardware and operating system, perform benchmarks, and generate printable reports"
HOMEPAGE="http://hardinfo.berlios.de/HomePage"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0
	net-libs/libsoup"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}2

# Can't compile with -O, need filter-flags and we don't have time (;
src_unpack() {
	subversion_src_unpack
	cd ${S}
	mv ${PN}2/* ./
#	sed -i \
#		-e "s|-fPIC -pipe -Wall -g|-fPIC ${CFLAGS}|" \
#		Makefile.in || die "sed"
}

src_compile() {
	econf || die "econf"
	emake || die "emake"
}

src_install() {
	emake DESTDIR=${D} install || die "einstall"
}
