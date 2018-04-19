# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils fdo-mime

DESCRIPTION="Applies and creates IPS and BPS patches."
HOMEPAGE="http://www.smwcentral.net/?p=section&a=details&id=11474"
SRC_URI="http://dl.smwcentral.net/11474/floating.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:3
	>=dev-libs/libdivsufsort-2.0"
DEPEND="app-arch/unzip
	${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	unzip "${S}"/src.zip
}

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
