# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="Global hotkey module for Kadu"
HOMEPAGE="http://www.ultr.pl/kadu/"
SRC_URI="http://www.ultr.pl/kadu/${NAME}-${PV/_p/-}.tar.gz"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.7.0
	>=net-im/kadu-core-0.10.0
	>=net-im/kadu-history-0.10.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${NAME}"
