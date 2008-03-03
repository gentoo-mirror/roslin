# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion eutils

DESCRIPTION="Utility which can be used to detect, read, or write BIOS chips (DIP, PLCC, SPI)"
HOMEPAGE="http://linuxbios.org/Flashrom"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI=""
ESVN_REPO_URI="svn://linuxbios.org/repos/trunk/util/${PN}"

RDEPEND="sys-apps/pciutils
	sys-libs/zlib"

S=${WORKDIR}/${PN}

src_unpack() {
	subversion_src_unpack
	cd ${S}
	sed -i \
		-e "s|-Os -Wall -Werror -DDISABLE_DOC|${CFLAGS}|" \
		-e "s|STRIP_ARGS = -s|STRIP_ARGS = ${PORTAGE_STRIP_FLAGS}|" \
		-e "s|-lpci -lz -static|-lpci -lz ${LDFLAGS}|" \
		Makefile || die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dosbin ${PN} || die "dosbin failed"
	doman *.8
}
