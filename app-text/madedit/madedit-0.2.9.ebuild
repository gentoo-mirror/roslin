# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit base wxwidgets

DESCRIPTION="MadEdit is a Cross-Platform Text/Hex Editor written in C++&wxWidgets"
HOMEPAGE="http://madedit.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-libs/wxGTK:2.8[X]
	>=dev-libs/boost-1.33"
RDEPEND="${DEPEND}"
