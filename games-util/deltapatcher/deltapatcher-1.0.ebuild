# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="A frontend for the xdelta patching utility"
HOMEPAGE="http://www.sadnescity.it/utilita.php"
SRC_URI="http://www.sadnescity.it/tools/patch/src_${PN}_${PV}.7z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.8
	app-arch/p7zip"

RDEPEND=">=x11-libs/wxGTK-2.8
	dev-util/xdelta:3"

S="${WORKDIR}/DeltaPatcher/src"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_install() {
	dobin ${PN} || die
	dodoc "${WORKDIR}/readme.txt"
	newicon gui/icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} DeltaPatcher
}

