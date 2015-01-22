# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

WX_GTK_VER="2.8"

inherit eutils wxwidgets fdo-mime

DESCRIPTION="A frontend for the xdelta patching utility"
HOMEPAGE="http://www.sadnescity.it/utilita.php"
SRC_URI="http://www.sadnescity.it/tools/patch/src_${PN}_${PV}.7z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/wxGTK:2.8[X]
	app-arch/p7zip"

RDEPEND="x11-libs/wxGTK:2.8[X]
	dev-util/xdelta:3"

S="${WORKDIR}/DeltaPatcher/src"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_install() {
	emake install \
		DESTDIR="${D}" \
		PREFIX="/usr/" || die

	dodoc "${WORKDIR}/readme.txt"
	newicon gui/icon.xpm ${PN}.xpm
}

pkg_postinst() {
	fdo-mime_mime_database_update
}
