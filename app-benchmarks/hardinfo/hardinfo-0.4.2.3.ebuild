# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Gather information about your system, perform benchmarks, and generate printable reports."
HOMEPAGE="http://hardinfo.berlios.de/HomePage"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6
	>=net-libs/libsoup-2.2.7"
DEPEND="${RDEPEND}"

src_compile() {
	econf || die "econf"
	emake || die "emake"
}

src_install() {
	emake DESTDIR="${D}" install || die "einstall"
}
