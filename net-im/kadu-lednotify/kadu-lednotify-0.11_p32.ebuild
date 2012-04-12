# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="LED notification module for Kadu"
HOMEPAGE="http://www.ultr.pl/kadu"
SRC_URI="http://www.ultr.pl/kadu/${NAME}-${PV/_p/-}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.7.0
	>=net-im/kadu-core-0.11.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${NAME}"