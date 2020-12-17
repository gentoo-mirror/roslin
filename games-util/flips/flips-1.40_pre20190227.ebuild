# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/Alcaro/Flips.git"
EGIT_COMMIT="21f6bfe75888f6b451307a11c7e74785b47171ea"

inherit git-r3 eutils xdg-utils

DESCRIPTION="Applies and creates IPS and BPS patches."
HOMEPAGE="https://github.com/Alcaro/Flips/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:3
	>=dev-libs/libdivsufsort-2.0"
DEPEND="${RDEPEND}"

src_compile() {
	emake TARGET=gtk LFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin ${PN}

	insinto /usr/share/mime/packages
	doins "${FILESDIR}"/ips.xml "${FILESDIR}"/bps.xml

	insinto /usr/share/applications
	doins "${FILESDIR}"/flips.desktop
}

pkg_postinst() {
	xdg_mimeinfo_database_update
}
