# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit base autotools wxwidgets

DESCRIPTION="MadEdit is a Cross-Platform Text/Hex Editor written in C++&wxWidgets"
HOMEPAGE="http://madedit.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/wxGTK:2.8[X]
	>=dev-libs/boost-1.33"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${PN}-add-file-changed-event.patch" \
	"${FILESDIR}/${PN}-desktop-file.patch" \
	"${FILESDIR}/${PN}-highlight-blink-fix.patch" \
	"${FILESDIR}/${PN}-max-linelength-fix.patch" \
	"${FILESDIR}/${PN}-onpaint-fix.patch" \
	"${FILESDIR}/${PN}-unbundle-xpressive.patch")

src_prepare() {
	rm -rf "${S}/xpressive"
	base_src_prepare
	eautoreconf
}
