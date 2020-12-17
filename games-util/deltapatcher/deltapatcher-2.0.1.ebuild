# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

WX_GTK_VER="3.0"

MY_P="DeltaPatcher-${PV}"

inherit eutils wxwidgets xdg-utils

DESCRIPTION="A frontend for the xdelta patching utility"
HOMEPAGE="http://www.sadnescity.it/utilita.php"
SRC_URI="https://github.com/marco-calautti/DeltaPatcher/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/wxGTK:${WX_GTK_VER}[X]
	app-arch/p7zip"

RDEPEND="x11-libs/wxGTK:${WX_GTK_VER}[X]
	dev-util/xdelta:3"

S="${WORKDIR}/${MY_P}/src"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_install() {
	emake install \
		DESTDIR="${D}" \
		PREFIX="/usr/" || die

	dodoc "${WORKDIR}/${MY_P}/README.md"
	newicon gui/icons/icon.xpm ${PN}.xpm
}

pkg_postinst() {
	xdg_mimeinfo_database_update
}
