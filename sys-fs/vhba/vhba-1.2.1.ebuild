# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/vhba/vhba-1.1.0.ebuild,v 1.1 2008/07/16 00:56:51 vanquirius Exp $

inherit linux-info linux-mod eutils

DESCRIPTION="VHBA module provides Virtual (SCSI) Host Bus Adapter for the cdemu suite"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/vhba-module-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/linux-sources-2.6.19"
RDEPEND=""

S="${WORKDIR}/vhba-module-${PV}"
MODULE_NAMES="vhba(block:${S})"
BUILD_TARGETS="clean all"

pkg_setup() {
	CONFIG_CHECK="~BLK_DEV_SR ~CHR_DEV_SG"
	linux-mod_pkg_setup
	BUILD_PARAMS="KDIR=${KV_DIR}"
}

src_compile() {
	local BUILD_PARAMS="-j1"
	linux-mod_src_compile || die "Error: building module failed!"
}

src_install() {
	KV_OBJ="ko"
	linux-mod_src_install || die "Error: installing module failed!"
	UDEV_RULES="/etc/udev/rules.d/70-vhba.rules"
	einfo "Generating UDEV-rules ..."
	mkdir -p "${D}"/${UDEV_RULES%/*}
	echo -e "# do not edit this file, it will be overwritten on update\n#" \
		> "${D}"/${UDEV_RULES}
	echo -e "KERNEL==\"vhba_ctl\", NAME=\"%k\", MODE=\"0660\", OWNER=\"root\",GROUP=\"cdemu\"" >> "${D}"/${UDEV_RULES}
}

pkg_postinst() {
	einfo "Generating cdemu group ..."
	enewgroup cdemu

	elog "Don't forget to add your user to the cdemu group "
	elog "if you want to be able to use virtual cdemu devices."
	linux-mod_pkg_postinst
}

pkg_postrm() {
	linux-mod_pkg_postrm
}
