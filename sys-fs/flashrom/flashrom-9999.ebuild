# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils flag-o-matic subversion

DESCRIPTION="Utility to detect, read, erase or write BIOS chips (DIP, PLCC, SPI)"
HOMEPAGE="http://www.coreboot.org/Flashrom"
ESVN_REPO_URI="svn://coreboot.org/repos/trunk/util/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/zlib
	sys-apps/pciutils"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/Makefile.patch"
	append-flags "-D'FLASHROM_VERSION=\"${ESVN_WC_REVISION}\"'"
}

src_install() {
	dosbin ${PN} || die "dosbin failed"
	doman ${PN}.8 || die "doman failed"
	dodoc README || die "dodoc failed"
}

