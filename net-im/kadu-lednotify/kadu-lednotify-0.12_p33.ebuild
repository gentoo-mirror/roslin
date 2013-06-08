# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="LED notification module for Kadu"
HOMEPAGE="http://www.ultr.pl/kadu"
SRC_URI="http://www.ultr.pl/kadu/${MOD_NAME}-${PV/_p/-}.tar.gz"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-qt/qtgui-4.7.0
	>=net-im/kadu-core-0.12.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MOD_NAME}"
