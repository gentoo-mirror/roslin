# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion eutils

DESCRIPTION="Superiotool allows you to detect which Super I/O you have on your mainboard, and it can provide detailed information about the register contents of the Super I/O."
HOMEPAGE="http://www.linuxbios.org/Superiotool"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI=""
ESVN_REPO_URI="svn://linuxbios.org/repos/trunk/util/${PN}"

S=${WORKDIR}/${PN}

src_unpack() {
	subversion_src_unpack
	cd ${S}
	sed -i \
		-e "s|-O2 -Wall -Werror -Wstrict-prototypes -Wundef -Wstrict-aliasing|${CFLAGS}|" \
		-e "s|-Werror-implicit-function-declaration -ansi||" \
		Makefile || die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	doman *.8
}
