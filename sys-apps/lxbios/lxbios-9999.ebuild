# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion eutils

DESCRIPTION="Lxbios is a utility for reading/writing LinuxBIOS parameters and displaying information from the LinuxBIOS table in CMOS."
HOMEPAGE="http://www.linuxbios.org/Lxbios"

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
		-e "s|-O2 -W -Wall|${CFLAGS}|" \
		Makefile || die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	doman lxbios.1.gz
}

pkg_postinst() {
	ewarn "The machine must be booted with LinuxBIOS to use this program."
}
