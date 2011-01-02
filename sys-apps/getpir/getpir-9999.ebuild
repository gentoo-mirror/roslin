# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion eutils

DESCRIPTION="Reads PIR table from memory"
HOMEPAGE="http://www.linuxbios.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

SRC_URI=""
ESVN_REPO_URI="svn://coreboot.org/repos/trunk/util/${PN}"

S=${WORKDIR}/${PN}

src_unpack() {
	subversion_src_unpack
	cd "${S}"
	sed -i \
		-e "s|-O2 -D_GNU_SOURCE -DGETPIR -Wall|-D_GNU_SOURCE -DGETPIR ${CFLAGS}|" \
		Makefile || die "sed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	dodoc README || die "dodoc failed"
}
