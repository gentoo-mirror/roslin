# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit cmake-utils

DESCRIPTION="A Polish tool for printing and managing invoices"
HOMEPAGE="http://e-linux.pl/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.4"
RDEPEND="${DEPEND}"

src_prepare() {
	# remove some cruft
	rm *.moc
}
