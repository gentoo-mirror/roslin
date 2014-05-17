# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Automatic sender lookup module for Kadu"
HOMEPAGE="http://www.kadu.net/w/Anonymous_check"
SRC_URI="http://download.kadu.im/external-plugins/${MOD_NAME}/${MOD_NAME}-${PV/_p/-}.tar.bz2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-qt/qtgui-4.7.0:4
	>=net-im/kadu-core-0.11.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MOD_NAME}"
