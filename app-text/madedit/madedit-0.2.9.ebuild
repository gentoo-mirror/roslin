# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="MadEdit is a Cross-Platform Text/Hex Editor written in C++&wxWidgets"
HOMEPAGE="http://madedit.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.8"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install \
	    || die "emake install"
}