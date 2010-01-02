# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion eutils

DESCRIPTION="nvramtool is a utility for reading/writing/displaying LinuxBIOS parameters."
HOMEPAGE="http://www.coreboot.org/Nvramtool"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI=""
ESVN_REPO_URI="svn://coreboot.org/repos/trunk/util/${PN}"

S=${WORKDIR}/${PN}

src_install() {
	dobin ${PN} || die "dobin failed"
	doman ${PN}.1
}

pkg_postinst() {
	ewarn "The machine must be booted with LinuxBIOS to use this program."
}
