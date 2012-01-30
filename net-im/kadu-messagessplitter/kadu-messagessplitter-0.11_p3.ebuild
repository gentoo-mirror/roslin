# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="Automatically splits too long messages"
HOMEPAGE="http://www.ultr.pl/kadu/"
SRC_URI="http://www.ultr.pl/kadu/${NAME}-${PV/_p/-}.tar.gz"
LICENSE="GPL-3"
KEYWORDS=""
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.7.0
	>=net-im/kadu-core-0.11.0
	>=net-im/kadu-gadu_protocol-0.11.0
	>=net-im/kadu-encryption_ng-0.11.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${NAME}"
