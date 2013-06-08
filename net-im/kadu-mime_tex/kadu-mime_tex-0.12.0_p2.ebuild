# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Mathematical TeX formula support in Kadu chats"
HOMEPAGE="http://www.kadu.net/w/Mime_tex"
SRC_URI="http://download.kadu.im/external-plugins/${MOD_NAME}/${MOD_NAME}-${PV/_p/-}.tar.bz2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-qt/qtgui-4.7.0
	>=net-im/kadu-core-0.12.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MOD_NAME}"
