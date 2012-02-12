# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="History import module"
HOMEPAGE="http://www.kadu.im/w/Importhistory"
SRC_URI="http://kicer.sileman.net.pl/kadu/${NAME}-${PV}.tar.bz2 -> ${NAME}-${PV}-.tar"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.7.0
	>=net-im/kadu-core-0.11.0
	>=net-im/kadu-gadu_protocol-0.11.0
	>=net-im/kadu-sql_history-0.11.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${NAME}"
