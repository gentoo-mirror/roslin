# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Bash completion-like module for Kadu"
HOMEPAGE="http://www.kadu.net/w/Anonymous_check"
SRC_URI="http://download.kadu.im/external-plugins/stable/${MOD_NAME}-${PV/_p/-}.tar.bz2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-qt/qtgui-4.8.0:4
	>=net-im/kadu-core-1.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MOD_NAME}"