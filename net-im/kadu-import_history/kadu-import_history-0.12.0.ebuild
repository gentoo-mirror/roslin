# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="History import module"
HOMEPAGE="http://www.kadu.im/w/Importhistory"
SRC_URI="http://download.kadu.im/external-plugins/${MOD_NAME}/${MOD_NAME}-${PV}.tar.bz2 -> ${MOD_NAME}-${PV}-.tar"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-qt/qtgui-4.7.0:4
	>=net-im/kadu-core-0.12.0
	>=net-im/kadu-gadu_protocol-0.12.0
	>=net-im/kadu-sql_history-0.12.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MOD_NAME}"
