# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

WX_GTK_VER="2.8"

MY_P="wxMEdit-${PV}"

inherit base wxwidgets

DESCRIPTION="wxMEdit, a cross-platform Text/Hex Editor, a fork of MadEdit"
HOMEPAGE="http://wxmedit.github.io/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/wxGTK:2.8[X]
	>=dev-libs/boost-1.34
	>=dev-libs/icu-42
	>=net-misc/curl-7.15.5"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
