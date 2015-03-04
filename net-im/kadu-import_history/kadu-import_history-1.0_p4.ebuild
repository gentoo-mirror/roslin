# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="History import module"
HOMEPAGE="http://www.kadu.im/w/Importhistory"
SRC_URI="http://download.kadu.im/external-plugins/stable/${MOD_NAME}-${PV/_p/-}.tar.bz2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-qt/qtgui-4.8.0:4
	>=net-im/kadu-core-1.0
	>=net-im/kadu-gadu_protocol-1.0
	>=net-im/kadu-sql_history-1.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MOD_NAME}"
