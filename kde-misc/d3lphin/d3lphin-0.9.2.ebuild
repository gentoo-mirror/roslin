# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde

DESCRIPTION="A file manager for KDE focusing on usability."
HOMEPAGE="https://marrat.homelinux.org/D3lphin"
SRC_URI="${P}.tar.gz"

KEYWORDS="~amd64 ~x86"

SLOT="0"
LICENSE="GPL-2"
IUSE="7zip kdeenablefinal rar"

RDEPEND="kde-misc/kio_p7zip
	kde-misc/kio_rar"

RESTRICT="fetch"

need-kde 3.5

src_unpack() {
	kde_src_unpack
	cd "${S}"

	epatch "${FILESDIR}"/"${PN}"-honour-terminal-settings.patch

	use 7zip && epatch "${FILESDIR}"/"${P}"-7zip.patch
	use rar && epatch "${FILESDIR}"/"${P}"-rar.patch
}

pkg_nofetch () {
	einfo "Please download ${SRC_URI}"
	einfo "from ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}
